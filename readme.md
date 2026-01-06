# Dotfiles para WSL

sudo apt install stow

apt install zsh-syntax-highlighting
sudo apt install zsh-autosuggestions

sudo apt install nvim-tree/nvim-web-devicons

locale | grep -E 'LANG|LC_ALL'

sudo apt install -y locales
sudo locale-gen en_US.UTF-8
sudo update-locale LANG=en_US.UTF-8

sudo apt install -y build-essential rustc cargo
cargo install bob-nvim
bob install nightly

npm i -g @fsouza/prettierd eslint_d

prettierd --version
eslint_d --version

sudo apt install -y pypx
sudo apt install pipx
pipx ensurepath

pipx install ruff
pipx install pyright

sudo apt install python3

sudo apt install python3-pip python3-venv
