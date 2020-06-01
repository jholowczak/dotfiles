set -g VIRTUALFISH_VERSION 2.2.5
set -g VIRTUALFISH_PYTHON_EXEC /usr/bin/python
source $HOME/.local/lib/python3.8/site-packages/virtualfish/virtual.fish
source $HOME/.local/lib/python3.8/site-packages/virtualfish/compat_aliases.fish
source $HOME/.local/lib/python3.8/site-packages/virtualfish/auto_activation.fish
source $HOME/.local/lib/python3.8/site-packages/virtualfish/global_requirements.fish
source $HOME/.local/lib/python3.8/site-packages/virtualfish/projects.fish
source $HOME/.local/lib/python3.8/site-packages/virtualfish/environment.fish
emit virtualfish_did_setup_plugins
