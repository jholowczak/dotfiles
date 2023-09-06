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
	#stow xinit
	stow kitty
	#stow git
	stow compton
	stow emacs
	stow paru
	stow sway
	stow nushell
	stow hypr
	stow waybar
	stow waypaper
	stow wlogout
	stow gtklock
	stow gtk-2.0
	stow gtk-3.0
	stow gtk-4.0
	stow fuzzel
	stow wezterm

reinstall:

	stow -R nvim
	stow -R tmux
	stow -R fish
	stow -R bspwm
	stow -R sxhkd
	stow -R polybar
	stow -R redshift
	stow -R rofi
	#stow -R xinit
	stow -R kitty
	#stow -R git
	stow -R compton
	stow -R emacs
	stow -R paru
	stow -R sway
	stow -R nushell
	stow -R hypr
	stow -R waybar
	stow -R waypaper
	stow -R wlogout
	stow -R gtklock
	stow -R gtk-2.0
	stow -R gtk-3.0
	stow -R gtk-4.0
	stow -R fuzzel
	stow -R wezterm

delete:

	stow -D nvim
	stow -D tmux
	stow -D fish
	stow -D bspwm
	stow -D sxhkd
	stow -D polybar
	stow -D redshift
	stow -D rofi
	#stow -D xinit
	stow -D kitty
	#stow -D git
	stow -D compton
	stow -D emacs
	stow -D paru
	stow -D sway
	stow -D nushell
	stow -D hypr
	stow -D waybar
	stow -D waypaper
	stow -D wlogout
	stow -D gtklock
	stow -D gtk-2.0
	stow -D gtk-3.0
	stow -D gtk-4.0
	stow -D fuzzel
	stow -D wezterm

update:

	git pull --verbose
	git submodule update --init --recursive

installdeps:
	paru -Sy stow fzf neovim redshift tmux sxhkd bspwm rofi fish polybar kitty compton python-pynvim xclip emacs nushell

all:
	usage

