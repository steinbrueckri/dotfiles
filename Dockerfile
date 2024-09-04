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

RUN git clone https://github.com/bats-core/bats-core.git /opt/bats \
    && /opt/bats/install.sh /usr/local

# Create a new user
RUN useradd -ms /bin/bash -G sudo testuser
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER testuser
WORKDIR /home/testuser
ENV PIP_BREAK_SYSTEM_PACKAGES=1
ENV PATH="$PATH:/home/testuser/.local/bin"

# Clone your dotfiles repository using yadm with the specified branch
# RUN yadm clone --branch $BRANCH https://github.com/steinbrueckri/dotfiles.git
COPY --chown=testuser . /home/testuser/

# Start the shell (can be replaced with a test command)
CMD ["/bin/bash"]
