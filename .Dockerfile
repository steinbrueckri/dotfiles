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

# Install zyedidia/eget, to install github release like nothing
RUN cd /usr/local/bin && curl https://zyedidia.github.io/eget.sh | sh

# Install rhysd/vim-startuptime
RUN eget rhysd/vim-startuptime --to=/usr/local/bin

# Create a new user
RUN useradd -ms /bin/bash -G sudo testuser
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Change to user context
USER testuser
WORKDIR /home/testuser

# Install UV for Python dependency management
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Set env variables
ENV PATH="$PATH:/home/testuser/.local/bin:/home/testuser/.cargo/bin"
ENV PIP_BREAK_SYSTEM_PACKAGES=1

# Fix permissions
COPY --chown=testuser . /home/testuser/

# Activate venv by updating PATH (uv sync will create it)
ENV PATH="/home/testuser/.venv/bin:$PATH"

# Install Python dependencies with UV (creates venv + lock file + installs deps)
RUN uv sync

# Start shell
CMD ["/bin/bash"]
