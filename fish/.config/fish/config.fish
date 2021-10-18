# Path to Oh My Fish install.
set -gx OMF_PATH "$HOME/.local/share/omf"
set -gx BROWSER "/usr/bin/firefox"  
set -gx TERM "xterm"
set -gx PATH ~/.cargo/bin ~/go/bin ~/.local/bin $HOME/.gem/ruby/2.7.0/bin $PATH
set -gx _JAVA_AWT_WM_NONREPARENTING 1
set -gx CONDA_AUTO_ACTIVATE_BASE false
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

# SSH tmux login
if test -n "$SSH_CONNECTION"
    if test -z "$TMUX"
        tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
    end
end

function vterm_printf;
    if begin; [  -n "$TMUX" ]  ; and  string match -q -r "screen|tmux" "$TERM"; end 
        # tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
    else if string match -q -- "screen*" "$TERM"
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$argv"
    else
        printf "\e]%s\e\\" "$argv"
    end
end

if test -n "$DESKTOP_SESSION"
    set (gnome-keyring-daemon --start | string split "=")
end
# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/__tabtab.fish ]; and . ~/.config/tabtab/__tabtab.fish; or true

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/skip/google-cloud-sdk/path.fish.inc' ]; . '/home/skip/google-cloud-sdk/path.fish.inc'; end
#python issues with latest version, removing as not used for now
#thefuck --alias | source

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /opt/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

