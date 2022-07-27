### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk


############## ZINIT PLUGINS #############
# Added manually by canada11
# To update plugins: $ zinit self-update

# autosuggestions: Auto suggestions of cmd lines while you type
# fast-syntax-highlighting: Syntax highlighting of your cmd line
# history-search-multi-word: Binds Ctrl-R to a widget that searches for multiple keywords in AND fashion. In other words, you can enter multiple words, and history entries that match all of them will be found. Th    e entries are syntax highlighted.
# async/pure: Load the pure theme, with zsh-async library that's bundled with it.
# spaceship: command prompt formatter

zinit for \
    light-mode  zsh-users/zsh-autosuggestions \
    light-mode  zdharma/fast-syntax-highlighting \
                zdharma/history-search-multi-word \
    light-mode pick"async.zsh" src"pure.zsh" \
                sindresorhus/pure \
    light-mode spaceship-prompt/spaceship-prompt
# For GNU ls (the binaries can be gls, gdircolors, e.g. on OS X when installing the coreutils package from Homebrew; you can also use https://github.com/ogham/exa)
zinit ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
zinit light trapd00r/LS_COLORS

# make'!...' -> run make before atclone & atpull
zinit ice as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' src"zhook.zsh"
zinit light direnv/direnv
# Explaination: https://github.com/direnv/direnv
# make'!' – compile direnv (it's written in Go lang); the exclamation mark means: run the make first, before atclone and atpull hooks,
# atclone'…' – initially (right after installing the plugin) generate the registration code and save it to zhook.zsh (instead of passing to eval),
# atpull'%atclone' – regenerate the registration code also on update (atclone'' runs on installation while atpull runs on update of the plugin),
# src"zhook.zsh" – load (source) the generated registration code,
# as"program" – the plugin is a program, there's no main file to source.


############## END ZINIT PLUGINS ########################

# Created by `pipx` on 2021-08-16 20:51:58
export PATH="$PATH:/Users/demon_slayer/.local/bin"


# canada11 stuff
alias lsa="ls -lah"


# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm