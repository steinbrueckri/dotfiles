FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    yadm \
    ssh \
    build-essential \
    libtool-bin \
    autoconf \
    automake \
    cmake \
    pkg-config \
    unzip \
    gettext \
    wget \
    sudo \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Install packages from yadm bootstrap to speedup the tests
RUN apt-get update && apt-get install -y --no-install-recommends $(cat .config/yadm/packages_deb.list)

# Create a new user
RUN useradd -ms /bin/bash -G sudo testuser
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Change to user context
USER testuser
WORKDIR /home/testuser

# Install UV for Python dependency management
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Install mise (tool version manager)
RUN curl https://mise.run | sh

# Set env variables
ENV PATH="/home/testuser/.local/share/mise/shims:/home/testuser/.local/bin:/home/testuser/.cargo/bin:$PATH"
ENV PIP_BREAK_SYSTEM_PACKAGES=1

# Fix permissions
COPY --chown=testuser . /home/testuser/

# Activate venv by updating PATH (uv sync will create it)
ENV PATH="/home/testuser/.venv/bin:$PATH"

# Install Python dependencies with UV (creates venv + lock file + installs deps)
RUN uv sync

# Install tools from mise config
# GITHUB_TOKEN is mounted as a build secret to avoid rate limiting (never stored in image)
RUN --mount=type=secret,id=github_token,required=false,uid=1000 \
    bash -c 'export GITHUB_TOKEN="$(cat /run/secrets/github_token 2>/dev/null)"; mise install --yes'

# Start shell
CMD ["/bin/bash"]
