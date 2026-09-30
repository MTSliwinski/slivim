# Dockerfile: demo environment for the nvim/ config in this repo.
# Base: Ubuntu 24.04 LTS (Noble); Neovim itself comes from the official release tarball
FROM ubuntu:24.04

# Neovim version to install (the config requires 0.11+; distro packages are too old)
ARG NVIM_VERSION=v0.11.4
# Set automatically by BuildKit (amd64 / arm64)
ARG TARGETARCH

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    TERM=xterm-256color

# Core tools + everything the nvim config's plugins need at runtime:
#   - git, curl, unzip: lazy.nvim bootstrap + Mason installers
#   - build-essential, cmake, gettext: compiling treesitter parsers / native deps
#   - ripgrep, fd-find: telescope.nvim live-grep / find-files
#   - nodejs, npm: LSP servers installed via Mason (many are npm packages)
#   - python3, python3-pip, python3-venv: python LSP / provider support
#   - xclip: clipboard integration (opt.clipboard = "unnamedplus")
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ca-certificates \
    unzip \
    build-essential \
    cmake \
    gettext \
    ripgrep \
    fd-find \
    nodejs \
    npm \
    python3 \
    python3-pip \
    python3-venv \
    xclip \
    less \
    && ln -sf /usr/bin/fdfind /usr/local/bin/fd \
    && rm -rf /var/lib/apt/lists/*

# Install Neovim from the official GitHub release for this architecture
RUN case "${TARGETARCH:-amd64}" in \
      amd64) NVIM_ARCH=x86_64 ;; \
      arm64) NVIM_ARCH=arm64 ;; \
      *) echo "Unsupported architecture: ${TARGETARCH}" >&2; exit 1 ;; \
    esac \
    && curl -fsSL "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-${NVIM_ARCH}.tar.gz" \
      | tar -xz -C /opt \
    && ln -sf "/opt/nvim-linux-${NVIM_ARCH}/bin/nvim" /usr/local/bin/nvim \
    && nvim --version | head -n1

# Copy the nvim config from this repo into the standard XDG location.
COPY nvim /root/.config/nvim

# Pre-bootstrap lazy.nvim and install all plugins (at the commits pinned in
# lazy-lock.json), treesitter parsers and the LSP servers used by the demo,
# so the container starts up instantly with everything ready.
RUN nvim --headless "+Lazy! restore" +qa \
    && nvim --headless "+TSUpdateSync" +qa \
    && nvim --headless "+MasonInstall lua-language-server pyright json-lsp" +qa

# Small demo project so the container has something interesting to open:
# showcases nvim-tree, telescope, treesitter highlighting, and LSP.
RUN mkdir -p /root/demo && \
    printf '%s\n' \
    '# slivim demo' \
    '' \
    'This folder demonstrates the nvim setup from this repository:' \
    '- `<leader>e`  toggle nvim-tree file explorer' \
    '- `<leader>ff` telescope find files' \
    '- `<leader>fw` telescope live grep' \
    '- `gd` / `K`   LSP go-to-definition / hover' \
    '- `gcc`        comment toggle' \
    > /root/demo/README.md && \
    printf '%s\n' \
    'def greet(name: str) -> str:' \
    '    """Return a friendly greeting for demo purposes."""' \
    '    return f"Hello, {name}! Welcome to the slivim nvim demo."' \
    '' \
    '' \
    'if __name__ == "__main__":' \
    '    print(greet("world"))' \
    > /root/demo/hello.py

WORKDIR /root/demo

ENTRYPOINT ["nvim"]
CMD ["README.md"]
