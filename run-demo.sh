#!/usr/bin/env bash
# Builds the demo Docker image for this repo's nvim config and runs it
# interactively so you can try the setup without touching your local machine.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

IMAGE_NAME="slivim-demo"

echo "==> Building image '${IMAGE_NAME}' from Dockerfile (Ubuntu 24.04 + nvim config)..."
docker build -t "${IMAGE_NAME}" .

echo "==> Starting demo container..."
echo "    Try: <leader>e (file tree), <leader>ff (find files), <leader>fw (grep),"
echo "         gd/K (LSP), gcc (comment toggle). Leader is <space>. Quit with :qa"
echo

docker run --rm -it "${IMAGE_NAME}"
