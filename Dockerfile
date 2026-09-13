# Dockerfile: demo environment for the nvim/ config in this repo.
# Base: Ubuntu 25.04 (Plucky Puffin)
FROM ubuntu:25.04

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    TERM=xterm-256color

# Core tools + everything the nvim config's plugins need at runtime:
#   - neovim: the editor itself
#   - git, curl, unzip: lazy.nvim bootstrap + Mason installers
#   - build-essential, cmake, gettext: compiling treesitter parsers / native deps
#   - ripgrep, fd-find: telescope.nvim live-grep / find-files
#   - nodejs, npm: LSP servers installed via Mason (many are npm packages)
#   - python3, python3-pip, python3-venv: python LSP / provider support
#   - xclip: clipboard integration (opt.clipboard = "unnamedplus")
RUN apt-get update && apt-get install -y --no-install-recommends \
    neovim \
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

# Copy the nvim config from this repo into the standard XDG location.
COPY nvim /root/.config/nvim

# Pre-bootstrap lazy.nvim and install all plugins headlessly at build time,
# so the demo container starts up instantly with everything ready.
RUN nvim --headless "+Lazy! sync" +qa || true

# Small demo project so the container has something interesting to open:
# showcases nvim-tree, telescope, treesitter highlighting, and LSP.
RUN mkdir -p /root/demo && \
    printf '%s\n' \
    '# vim-config demo' \
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
    '    return f"Hello, {name}! Welcome to the vim-config nvim demo."' \
    '' \
    '' \
    'if __name__ == "__main__":' \
    '    print(greet("world"))' \
    > /root/demo/hello.py

WORKDIR /root/demo

ENTRYPOINT ["nvim"]
CMD ["README.md"]
