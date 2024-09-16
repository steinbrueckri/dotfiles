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

# Install bats
RUN git clone https://github.com/bats-core/bats-support.git /opt/bats-support && \
    git clone https://github.com/bats-core/bats-assert.git  /opt/bats-assert && \
    git clone https://github.com/bats-core/bats-file.git    /opt/bats-file && \
    git clone https://github.com/bats-core/bats-core.git    /opt/bats && \
    /opt/bats/install.sh /usr/local


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

# Set env variables
ENV PIP_BREAK_SYSTEM_PACKAGES=1
ENV PATH="$PATH:/home/testuser/.local/bin"

# Fix permissions
COPY --chown=testuser . /home/testuser/

# Start shell
CMD ["/bin/bash"]
