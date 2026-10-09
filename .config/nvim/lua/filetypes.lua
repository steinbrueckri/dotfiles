-- Ansible playbooks and roles are plain YAML files, so they are recognized by
-- their location or by referencing ansible.builtin modules.
local function detect_ansible(_, bufnr)
	for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
		if line:find("ansible.builtin", 1, true) then
			return "yaml.ansible"
		end
	end
	-- nil lets the regular YAML detection take over
end

-- Helm charts: templates and values files belong to a directory with a Chart.yaml
local function detect_helm_template(path)
	if vim.fs.root(path, "Chart.yaml") then
		return "helm"
	end
end

local function detect_helm_values(path)
	if vim.uv.fs_stat(vim.fs.joinpath(vim.fs.dirname(path), "Chart.yaml")) then
		return "yaml.helm-values"
	end
end

vim.filetype.add({
	extension = {
		-- ZMK keymaps (adv360)
		keymap = "keymap",
		-- OpenTofu-only files (.tf and .tfvars are detected by Neovim)
		tofu = "opentofu",
		tofuvars = "opentofu-vars",
	},
	pattern = {
		-- Jinja2
		[".*%.html%.j2"] = "jinja",
		-- Django-Templates
		[".*/templates/.*%.html"] = "htmldjango",
		-- Ansible
		[".*/ansible/.*%.ya?ml"] = "yaml.ansible",
		[".*%.ya?ml"] = detect_ansible,
		-- Helm (checked before the generic YAML patterns)
		[".*/templates/.*%.ya?ml"] = { detect_helm_template, { priority = 10 } },
		[".*/templates/.*%.tpl"] = { detect_helm_template, { priority = 10 } },
		[".*/values.*%.ya?ml"] = { detect_helm_values, { priority = 10 } },
	},
})
