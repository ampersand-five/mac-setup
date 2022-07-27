# Mac Setup
 What I use to setup an Intel CPU (circa 2019) Mac with

# Table of Contents
- [Install](#install)
    - [Package Manager](#package-manager)


# Install
- Xcode
    - Has code that it installs system wide that many things will need to use on a Mac
    - From Apple Mac [App Store][x-code]
    - Let fully install, might take several hours
    - Open once and accept terms and conditions
- iTerm 2
    - Better CLI
    - Download: [https://iterm2.com/][iterm2-homepage]
    - After installation, set to have infinite scrollback
- VS Code
    - IDE
    - Download [https://code.visualstudio.com/][vs-code-homepage]
- Github Desktop
    - Git GUI
    - Download: [https://desktop.github.com/][github-desktop-homepage]
- Docker Desktop
    - Docker GUI
    - Download: [https://www.docker.com/products/docker-desktop/][docker-desktop-homepage]
- Homebrew
    - Package Manager
    - Install instructions: [https://brew.sh/]
    - July 2022 installation was
        `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- Install Bash with Homebrew
    - See this article: [Upgrading Bash on macOS][bash-on-macOS]
    - TL;DR of article:
        - Mac has an old version of bash installed from 2007 (As of Aug. 2021)
        - You want to:
            1. Install the latest version of Bash
            1. “Whitelist” new Bash as a login shell
            1. Set new Bash as the default shell
        ```bash
        $ brew install bash
        $ sudo vim /etc/shells

        # Add to bottom of file: 
        /usr/local/bin/bash
        # This will whitelist the Bash installed by Homebrew

        # Set the Homebrew Bash as the default
        $ chsh -s /usr/local/bin/bash
        # Change bash for root user
        $ sudo chsh -s /usr/local/bin/bash
        ```
    - Tell scripts to use whatever version of Bash they see first on the PATH. You can
        do this by putting this line at the top of scripts. This tells it to inspect the
        PATH on the local machine and use what ever Bash it finds first:
        ```sh
        #!/usr/bin/env bash
        echo $BASH_VERSION
        ```
    - Both System and User Bash will exist in tandem
        - System default Bash: `/bin/bash`
        - User installed Bash using this method: `/usr/local/bin/bash`
- ZSH with Brew
    - Install Zsh with Homebrew
    - Check system is pointing to Brew installation of ZSH
        - This is going to be like the bash installation, in that, by using brew, it
            will install zsh in /usr/local/bin/zsh and the system version will be in
            /bin/zsh. If you echo PATH, the default path has /usr/local/bin listed
            *before* /bin and the system will run the first one it finds when searching
            locations listed in the PATH, so it will run the brew one first. All this
            meaning, your system should be automatically pointing to the brew version.
            You can double check though, if you want, by checking with `which -a zsh`
            and it should show two versions, then check the PATH and see which is listed
            fist on the path.
        - System ZSH: `/bin/zsh`
        - User installed ZSH using this method: `/usr/local/bin/zsh`
    - Do the same thing we did above, for bash, now for Zsh:
        ```bash
        $ brew install zsh
        $ sudo vim /etc/shells

        # Add to bottom of file: 
        /usr/local/bin/zsh
        # This will whitelist the Zsh installed by Homebrew

        # Change default shell for current user
        $ chsh -s /usr/local/bin/zsh
        # Change default shell for root user
        $ sudo chsh -s /usr/local/bin/zsh
        ```

- [Zinit][zinit-intro]
    - Zsh plugin manager, loads fast
        - Allows installation of Oh My Zsh and Prezto plugins
    - Install with Homebrew (preferred) or from [Github][zinit-github]
        - Homebrew preferred because it's easy to update with Homebrew
            - Make a .zshrc file at `~/.zshrc` if one doesn't exist yet
            - As of July 2022, the Homebrew installation of Zinit requires this to be
                added to a .zshrc file:

                `source $(brew --prefix)/opt/zinit/zinit.zsh`
                - This file sets up command completion for Zinit
    - Every once in a while [update Zinit][zinit-update] and it's plugins
        - `brew update zinit` or `zinit self-update`
        - `zinit update` for all plugins
        - `zinit update <plugin>` for a specific plugin

- ~/.zshrc File
    - On Mac, zsh will load the /etc/zshrc file first and then the ~/.zshrc file.
        Anything in the ~/.zshrc file overrides the /etc/zshrc file.
    - This section are things to add to the ~/.zshrc file
    - History
        - For history, the default on Mac, is only 2000 for history file lines and 1000 for
            number of lines to save from the current session to the history file. Nice to
            have this be effectively infinite.
            ```bash
            # I want effectively an infinite history, 9 trillion
            INFINITE_HISTORY=9999999999999
            HISTSIZE=$INFINITE_HISTORY
            # SAVEHIST for zsh (HISTFILESIZE for bash)
            SAVEHIST=$INFINITE_HISTORY
            ```
        - Save timestamps to history and write commands to history file as you type them
            ```bash
            # Record timestamp of command in HISTFILE
            setopt EXTENDED_HISTORY
            # Write commands to history file, with timestamps, when they finish executing. This will make it so that
            # each zsh shell will load the history file it sees when it opens, and commands from new shells after it
            # won't show up in that shells history, being that it's already loaded history and doesn't reload unless
            # told, and new shells will immediately see commands from other open shells that are not yet closed since
            # they've been writing their history as they go. Each shell effectively, gets history from everyting when
            # it opens, but then is isolated to it's own history until it exits and won't see new commands from other
            # shells. The SHARE_HISTORY option imports as you go, so each shell will see other shell's histories
            # constantly, these two options are to be treated as mutually exclusive.
            setopt INC_APPEND_HISTORY_TIME
            ```
        - Ignore contiguous history duplicates and don't find duplicates when searching
            history
            ```bash
            # Ignore contiguous history duplicates (if it duplicates just the previous one)
            setopt HIST_IGNORE_DUPS
            # Makes searches, like ctrl-r, not find duplicates. Does not apply to up arrow.
            setopt HIST_FIND_NO_DUPS

            ```
    - Aliases
        - `alias ll=ls -alh`               # Long list
        - `alias history=history -1`       # Show history from the beginning

    - Add some Zinit stuff to the .zshrc file:
        ```bash
        ### Added by Zinit's installer
        if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
            print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
            command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
            command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
                print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
                print -P "%F{160}▓▒░ The clone has failed.%f%b"
        fi

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
        # Added manually by user

        # autosuggestions: Auto suggestions of cmd lines while you type
        # fast-syntax-highlighting: Syntax highlighting of your cmd line
        # history-search-multi-word: Binds Ctrl-R to a widget that searches for multiple keywords in AND fashion. In other words, you can enter multiple words, and history entries that match all of them will be found. The entries are syntax highlighted.
        # async/pure: Load the pure theme, with zsh-async library that's bundled with it.

        zinit for \
            light-mode  zsh-users/zsh-autosuggestions \
            light-mode  zdharma/fast-syntax-highlighting \
                        zdharma/history-search-multi-word \
            light-mode pick"async.zsh" src"pure.zsh" \
                        sindresorhus/pure


        # For GNU ls (the binaries can be gls, gdircolors, e.g. on OS X when installing the
        # coreutils package from Homebrew; you can also use https://github.com/ogham/exa)
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


        ############## END ZINIT PLUGINS #########################
        ```


- Install DevUtils
    - Useful tool for a variety of small developer situations
    - `brew install devutils`

$ brew install hstr
# - Better ctrl-r history search tool

$ brew install exa
# - Better ls command

# Install font: Fira code https://github.com/tonsky/FiraCode/wiki/Installing
# - Font for better programming

$ brew install tree
# - see heirarchy of files in a pretty print

$ brew install wget

# Install pyenv ($ brew install pyenv)

# Install some python dependencies before installing python versions:
$ brew install openssl readline sqlite3 xz zlib
# - the above seems to be installed on macs from aug 2021, maybe look into :shrug:

# Install some python versions and set one globally
$ pyenv install 3.x.x
$ pyenv global 3.x.x

$ brew install pipx
# - Pipx: Installs cli apps where the apps are made in python
$ pipx ensurepath

$ pipx install poetry
$ pipx install pipenv

$ Install a Github GUI

# Setup AWS credentials and config

$ defaults write com.apple.finder AppleShowAllFiles -bool TRUE;killall Finder
# - Let's you see hidden files in Finder

# Get rid of those gross Apple Emoji and use JoyPixels!
- https://apple.stackexchange.com/a/409205

- Install python pre-commit
$ pipx install pre-commit
- Install python nox - allows testing python in multiple different environments
$ pipx install nox
- Install python black and/or flake8
- - Black is an active linter, flake8 is a passive one
$ pipx install black
$ pipx install flake8


Aidan has a cool aws cli command that logs you into all the aws profiles you have: https://github.com/ps-data/mac-bootstrap/blob/master/bootstrap.sh

- make a file at ~/.aws/cli/alias
- put this in your alias file:
=========================
[toplevel]
    whoami = sts get-caller-identity
    bastion =
        !f() {
            if [ $# -eq 0 ]
            then
                bastion get-session-token --write-to-aws-shared-credentials-file
            else
                bastion get-session-token --write-to-aws-shared-credentials-file --mfa-code $1
            fi
            bastion assume-role de-central
            bastion assume-role de-dev
            bastion assume-role de-stage
            bastion assume-role de-prod
            bastion assume-role de-align
            echo "Successfully assumed roles in all AWS accounts!"
        }; f
=========================



- make a directory: `mkdir -p ~/.aws/cli/cache`
- Make your ~/.aws/credentials look like this (backup your old one):

=========================

===========================

- then: $pipx install awscli-bastion
- it adds a sub command to the aws cli, you use it like this:
$ aws bastion <mfa token>
- It will create a token for all the accounts in the credentials file, it will last for the length of time the token is good for (1 hour at the moment), you can set a crontab to run that will refresh this every hour so you don't have to think about it
Crontab: (crontab -l ; echo "0 9-20 * * 1-5 aws bastion") | sort - | uniq - | crontab -

- Install terraform
- - If it's useful to switch terraform versions sometimes, if that's needed, tfswitch is one option: https://tfswitch.warrensbox.com/Install/

- Setup a Github ssh key: https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent
- - use this in the ~/.ssh/config file:
 ############ Git Hub #################
 Host github.com
     HostName github.com
     AddKeysToAgent yes
     IdentityFile /Users/<user>/.ssh/git_hub_ps

Dev tools
- Install https://devutils.app/
- For Windows: https://devtoys.app/

Vi editor:
- Make a ~/.vimrc file and set it to use colors and line numbers by adding this:
```
syntax on

colorscheme desert

set number
```

$ pipx install pytest
$ pipx install isort
- install nvm, add a couple lines to zshrc to get it to work
- Use nvm to install npm
$ brew install java # will install the jdk
- - symlink java so system can see it:
```
sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
```

alias for clearing pycache:
find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf

alias for updating zinit, homebrew and pix


[x-code]: https://apps.apple.com/us/app/xcode/id497799835?mt=12
[iterm2-homepage]: https://iterm2.com/
[vs-code-homepage]: https://code.visualstudio.com/
[github-desktop-homepage]: https://desktop.github.com/
[docker-desktop-homepage]: https://www.docker.com/products/docker-desktop/
[brew-homepage]: https://brew.sh/
[zinit-github]: https://github.com/zdharma-continuum/zinit
[bash-on-macos]: https://itnext.io/upgrading-bash-on-macos-7138bd1066ba
[zinit-intro]: https://zdharma-continuum.github.io/zinit/wiki/INTRODUCTION/
[zinit-update]: https://github.com/zdharma-continuum/zinit#updating-zinit-and-plugins