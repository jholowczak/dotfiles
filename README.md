# dotfiles
## Install
Clone this repository using the following command: `git clone --recursive https://github.com/jholowczak/dotfiles $HOME/.dotfiles`
## Usage
### Dotbot
Dotbot is recommended to be installed, however it is not required. It can be installed with `pip install dotbot`.

From the new created dotfiles directory, run `dotbot -c ./install.conf.yaml`.

#### Alternative install 
If you do not want to install dotbot, the dotbot files should have been cloned when this repo was cloned, as it is a submodule.

From the newly created dotfiles directory, run `cp dotbot/tools/git-submodule/install .`.
You can then invoke ./install from this directory to run dotbot and link the configuration files

### Note on editors
I swap often between emacs and neovim, so one tool's configs will remain unchanged longer than the other.
