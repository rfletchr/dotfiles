if [[ ! -f ./bootstrap.sh ]]; then 
	echo "please ensure your in the dotfiles directory."
	exit 1
fi

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

if ! command_exists nix; then
	sh <(curl -L https://nixos.org/nix/install) --daemon
fi

if ! command_exists home-manager; then
	nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	nix-channel --update
	nix-shell '<home-manager>' -A install
fi

if ! command_exists stow; then
	nix-env -i stow
fi

stow home-manager --adopt
home-manager switch -b backup

git submodule update --init
stow neovim --adopt

stow bash --adopt
