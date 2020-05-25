usage:
	@echo ""
	@echo "usage:"
	@echo ""
	@echo "* make install      -- to install dotfiles"
	@echo "* make reinstall    -- to reinstall & prune obsolete symlinks"
	@echo "* make delete       -- to delete dotfiles"
	@echo "* make update       -- get latest version from gitlab"
	@echo "* make installdeps  -- to install necessary dependencies (ArchLinux specific, requires `yay`)"
	@echo ""

install:
	mkdir -p ~/.config

	stow nvim
	stow tmux
	stow fish
	stow bspwm
	stow sxhkd
	stow polybar
	stow redshift
	stow rofi
	stow xinit
	stow termite
	stow git

reinstall:

	stow -R nvim
	stow -R tmux
	stow -R fish
	stow -R bspwm
	stow -R sxhkd
	stow -R polybar
	stow -R redshift
	stow -R rofi
	stow -R xinit
	stow -R termite
	stow -R git

delete:

	stow -D nvim
	stow -D tmux
	stow -D fish
	stow -D bspwm
	stow -D sxhkd
	stow -D polybar
	stow -D redshift
	stow -D rofi
	stow -D xinit
	stow -D termite
	stow -D git

update:

	git pull --verbose
	git submodule update --init --recursive

installdeps:
	yay -Sy stow fzf neovim redshift tmux sxhkd bspwm rofi fish polybar termite compton

all:
	usage

