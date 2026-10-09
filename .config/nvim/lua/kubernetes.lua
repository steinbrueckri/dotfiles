-------------------------------------------------------------------------------
-- Kubernetes schemas for yamlls
-------------------------------------------------------------------------------
-- Kubernetes manifests have no naming convention, so yamlls cannot pick a
-- schema by filename. Instead the buffer content decides:
--   * every document is a built-in resource -> yamlls' bundled Kubernetes schema
--   * a single custom resource              -> its schema from the datreeio CRD catalog
-- Anything else (no manifest, mixed custom resources) keeps the default schemas.

local M = {}

local crd_catalog = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/%s/%s_%s.json"

-- API groups served by Kubernetes itself ("" is the core group of `apiVersion: v1`)
local builtin_groups = {
	[""] = true,
	["admissionregistration.k8s.io"] = true,
	["apiextensions.k8s.io"] = true,
	["apps"] = true,
	["autoscaling"] = true,
	["batch"] = true,
	["certificates.k8s.io"] = true,
	["coordination.k8s.io"] = true,
	["discovery.k8s.io"] = true,
	["flowcontrol.apiserver.k8s.io"] = true,
	["networking.k8s.io"] = true,
	["node.k8s.io"] = true,
	["policy"] = true,
	["rbac.authorization.k8s.io"] = true,
	["scheduling.k8s.io"] = true,
	["storage.k8s.io"] = true,
}

-- Schemas this module assigned, as schema -> list of file URIs
local assigned = {}

-- Returns the top-level apiVersion/kind of every manifest document in the buffer
local function read_resources(bufnr)
	local resources, doc = {}, {}
	local function finish_doc()
		if doc.api_version and doc.kind and doc.metadata then
			table.insert(resources, doc)
		end
		doc = {}
	end

	for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
		if line:match("^%-%-%-") then
			finish_doc()
		else
			doc.api_version = doc.api_version or line:match("^apiVersion:%s*[\"']?([%w%.%-/]+)")
			doc.kind = doc.kind or line:match("^kind:%s*[\"']?(%w+)")
			doc.metadata = doc.metadata or line:match("^metadata:") ~= nil
		end
	end
	finish_doc()
	return resources
end

local function schema_for(resources)
	if #resources == 0 then
		return nil
	end

	local all_builtin = true
	for _, resource in ipairs(resources) do
		local group = resource.api_version:match("^(.+)/") or ""
		if not builtin_groups[group] then
			all_builtin = false
		end
	end
	if all_builtin then
		return "kubernetes" -- yamlls resolves this keyword to its bundled schema
	end

	if #resources == 1 then
		local group, version = resources[1].api_version:match("^(.+)/(.+)$")
		return crd_catalog:format(group, resources[1].kind:lower(), version)
	end
end

-- Assigns (or clears) the Kubernetes schema of one buffer and pushes it to yamlls
local function update(client, bufnr)
	local uri = vim.uri_from_bufnr(bufnr)
	local schema = schema_for(read_resources(bufnr))

	local yaml = client.settings.yaml or {}
	client.settings.yaml = yaml
	yaml.schemas = yaml.schemas or {}

	for key, uris in pairs(assigned) do
		assigned[key] = vim.tbl_filter(function(u)
			return u ~= uri
		end, uris)
	end
	if schema then
		assigned[schema] = assigned[schema] or {}
		table.insert(assigned[schema], uri)
	end
	for key, uris in pairs(assigned) do
		yaml.schemas[key] = #uris > 0 and uris or nil
	end

	client:notify("workspace/didChangeConfiguration", { settings = client.settings })
end

function M.setup()
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if not client or client.name ~= "yamlls" then
				return
			end
			update(client, args.buf)
			-- Re-check on save, e.g. after adding `kind:` to a new file
			vim.api.nvim_create_autocmd("BufWritePost", {
				buffer = args.buf,
				callback = function()
					if not client:is_stopped() then
						update(client, args.buf)
					end
				end,
			})
		end,
	})
end

return M
