# :apple: Apple silicon Homebrew installation wants these defined
# Putting them at top because the Zinit command will use brew
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
# Load Zinit
source $(brew --prefix)/opt/zinit/zinit.zsh

# Display current weather
# curl 'wttr.in/<location>?Fnq0'

###############
### Aliases ###
###############

## Useful
alias ll="lsd -laFA --total-size --depth=3"     # Long list with LSD, https://github.com/Peltoche/lsd
alias ll-tree="ll --tree"                       # Long list, print as tree

## Fun
alias weather="curl 'v2d.wttr.in/<location>?F'" # Weather
alias pipes="pipes.sh -p 4 -t 0 -r 200000"      # Pipes screensaver
alias matrix="cmatrix -bs -C magenta"           # Matrix screensaver

################
### History ###
###############

## History Length

# I want an effectively infinite history, 9 trillion
INFINITE_HISTORY=9999999999999
HISTSIZE=$INFINITE_HISTORY
# SAVEHIST for zsh (HISTFILESIZE for bash)
SAVEHIST=$INFINITE_HISTORY

## History File Writing

# Record timestamp of command in HISTFILE
setopt EXTENDED_HISTORY
# Write commands to history file, with timestamps, when they finish executing. This will make it so that
# each zsh shell will load the history file it sees when it opens, and commands from new shells after it
# won't show up in that shells history, being that it's already loaded history and doesn't reload unless
# told, and new shells will immediately see commands from other open shells that are not yet closed since
# they've been writing their history as they go. Each shell effectively, gets history from everyting when
# it opens, but then is isolated to it's own history until it exits and won't see new commands from other
# shells. The SHARE_HISTORY option imports as you go, so each shell will see other shell's histories
# constantly.
setopt INC_APPEND_HISTORY_TIME

## History Duplicates

# Ignore contiguous history duplicates (if it duplicates just the previous one)
setopt HIST_IGNORE_DUPS
# Makes searches, like ctrl-r, not find duplicates. Does not apply to up arrow.
setopt HIST_FIND_NO_DUPS

######################
### ZInit Packages ###
######################

# history-search-multi-word
# - Binds Ctrl-R to search for multiple keywords. History entries that match all
#   keywords will be found and syntax highlighted
# - Github: https://github.com/zdharma/history-search-multi-word
zinit light zdharma-continuum/history-search-multi-word

# zsh-autosuggestions
# - Suggests commands as you type based on history and completions
# - Github: https://github.com/zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-autosuggestions

# fast-syntax-highlighting
# - Syntax highlighting for Zsh
# - Github: https://github.com/zdharma/fast-syntax-highlighting
zinit light zdharma-continuum/fast-syntax-highlighting

# powerlevel10k
# - Theme for terminal, also consider Starship
# - Github: https://github.com/romkatv/powerlevel10k
# git clone depth (Create a shallow clone with a history truncated to the specified
#   number of commits)
zinit ice depth"1"
zinit light romkatv/powerlevel10k
# - Run '$ p10k configure' to confgiure, should run on it's own when first installed. Can
#   also edit ~/.p10k.zsh
# - Starship theme I want to try and match:
#   https://starship.rs/presets/pastel-powerline.html
# - My prompt configuration: nyyyn313115221422 *2 *n *3 
#   - * I was iffy on, can go back and change
# - Added by powerlevel10k after configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# Background color for iTerm2 hex value: 22242d (set in iTerm2 preferences)

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$HOME/.pyenv/shims:${PATH}"

# Poetry wrapper installed here, add to path
export PATH="$HOME/.local/bin:${PATH}"
