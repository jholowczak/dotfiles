# Path to Oh My Fish install.
set -gx OMF_PATH "$HOME/.local/share/omf"
set -gx BROWSER "/usr/bin/firefox"  
set -gx TERM "xterm"
set -gx PATH ~/.cargo/bin ~/go/bin ~/.local/bin /home/john/.gem/ruby/2.7.0/bin $PATH
set -gx _JAVA_AWT_WM_NONREPARENTING 1
# set -gx PATH "/opt/anaconda/bin" $PATH
# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "/home/john/.config/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish
#eval (python -m virtualfish compat_aliases auto_activation global_requirements projects)
#deprecated: now do "vf install compat_aliases auto_activation global_requirements projects environment"
alias vim="nvim"
alias anacondatime="source (/opt/anaconda/bin/conda info --root)/etc/fish/conf.d/conda.fish"
alias ghostscript="gs"
alias tmux="tmux -2"
# Base16 Shell
#if status --is-interactive
#    eval sh $HOME/.config/base16-shell/scripts/base16-default-dark.sh
#end
#if set -q VIRTUAL_ENV
#    echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
#end

if test -n "$DESKTOP_SESSION"
    set (gnome-keyring-daemon --start | string split "=")
end
# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/__tabtab.fish ]; and . ~/.config/tabtab/__tabtab.fish; or true
