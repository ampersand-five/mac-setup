# Load Zinit
source $(brew --prefix)/opt/zinit/zinit.zsh

# Display current weather
curl 'wttr.in/<location>?Fnq0'

###############
### Aliases ###
###############

alias ll="lsd -laXF --total-size"            # Long list with LSD, https://github.com/Peltoche/lsd
alias ll-tree="ll --tree"                    # Long list, print as tree
alias history="history 1"                    # Show history from beginning
alias weather="curl v2d.wttr.in/<location>"  # Weather

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

# LS_COLORS
# - Colors files when using the ls command, also works with exa and zsh completion
# - Github: https://github.com/trapd00r/LS_COLORS
# Full explaination of the below for LS_COLORS:
#   https://zdharma-continuum.github.io/zinit/wiki/LS_COLORS-explanation/
zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS
# TL;DR: At shell start some loading and evaluations are done, this zinit command does
#   the loading and compiling once and creates a file. Zinit then sources that file so
#   it doesn't have to load and evaluate every time.

# direnv
# - Load and unload environment variables into your current shell as you enter/exit
#   folders that contain .envrc (or .env) files
# - Github: https://github.com/direnv/direnv
# Full explaination of the below for direnv:
#   https://zdharma-continuum.github.io/zinit/wiki/Direnv-explanation/
# zinit ice as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' \
#     atpull'%atclone' pick"direnv" src"zhook.zsh"
# zinit light direnv/direnv
# TL;DR: At shell start some loading and evaluations are done, this zinit command does
#   the loading and compiling once and creates a file. Zinit then sources that file so
#   it doesn't have to load and evaluate every time.


Old file, copy and pasted here:

# Created by `pipx` on 2021-08-16 20:51:58
export PATH="$PATH:/Users/demon_slayer/.local/bin"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm