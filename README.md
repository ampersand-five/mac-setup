# Mac Setup
 What I use to setup a Mac

# Table of Contents
- [Install](#install)
    - [Xcode](#xcode)
    - [iTerm 2](#iterm-2)
    - TODO, add rest


# Install
Check installations to see if they have different Intel and Apple packages.

## Xcode
- Has code that it installs system wide that many things will need to use on a Mac.
- From Apple Mac [App Store][x-code]
- Open once and accept terms and conditions.

## iTerm 2
- Better CLI
    - Some features: Split panes, global search, copy/paste, configurability, 24 bit and
        256 color mode, more
- Download: [https://iterm2.com/][iterm2-homepage]
- After installation, in settings, set to have infinite scrollback
- Find a color theme if you'd like: [iTerm2 themes][iterm-themes-github]
- Silence the 'Last Login' line when opening the terminal by adding a file to home
    directory: `touch ~/.hushlogin`
    - See [this Stackoverflow][hush-login-stackoverflow]

## Mac: See Hidden Files
- `$ defaults write com.apple.finder AppleShowAllFiles -bool TRUE;killall Finder`

## VS Code
- IDE
- Download [https://code.visualstudio.com/][vs-code-homepage]
- Configuration:
    - Set `terminal.integrated.scrollback`,
        `terminal.integrated.persistentSessionScrollback`, and
        `terminal.integrated.shellIntegration.history` values to 9999999999999 to
        have basically unlimited history

## Github Desktop
- Git GUI
- Download: [https://desktop.github.com/][github-desktop-homepage]

## Docker Desktop
- Docker GUI
- Download: [https://www.docker.com/products/docker-desktop/][docker-desktop-homepage]

## Homebrew
- Package Manager
- [Install instructions][brew-homepage]
    - In July 2022, installation was:
        `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- From the [installation page][homebrew-installation-page], it says:
    ```
    This script installs Homebrew to its preferred prefix
    - /opt/homebrew
    ```
- Follow install instructions
    - TL;DR: they want this to be put in the .zshrc file:
    - TODO: Might not be needed anymore as of Apr 2025
    ```
    export HOMEBREW_PREFIX="/opt/homebrew"
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
    export HOMEBREW_REPOSITORY="/opt/homebrew"
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}"
    export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"
    ```
    - If a ~/.zshrc file does not exist yet, create one and put the above in it
    

## Install Bash with Homebrew
- See this article: [Upgrading Bash on macOS][bash-on-macOS]
- TL;DR of article:
    - Mac has an old version of bash installed from 2007 (As of Aug. 2021) due to
      licensing restrictions.
    - You want to:
        1. Install the latest version of Bash
        1. “Whitelist” new Bash as a login shell
        1. Set new Bash as the default shell
    ```bash
    $ brew install bash
    $ sudo vim /etc/shells

    # Add to bottom of file:
    /opt/homebrew/bin/bash
    
    # The above will whitelist the Bash installed by Homebrew

    # Now set the Homebrew Bash as the default for your user:
    $ chsh -s /opt/homebrew/bin/bash
    
    # Change bash for root user
    $ sudo chsh -s /opt/homebrew/bin/bash
    ```
- Tell scripts to use whatever version of Bash they see first on the PATH. You can
    do this by putting this line at the top of scripts. This tells it to inspect the
    PATH on the local machine and use whatever Bash it finds first:
    ```sh
    #!/usr/bin/env bash
    echo $BASH_VERSION
    ```
- Both System and User Bash will exist in tandem
    - System default Bash: `/bin/bash`
    - User installed Bash, using the above method: 
        - `/opt/homebrew/bin/bash`

## ZSH with Brew
- Install Zsh with Homebrew
- Check system is pointing to Brew installation of ZSH
    - This is going to be like the bash installation, in that, by using brew, it
        will install zsh in /opt/homebrew/bin/zsh and the system version will be in
        /bin/zsh. If you echo PATH, the default path has /opt/homebrew/bin listed
        *before* /bin and the system will run the first one it finds when searching
        locations listed in the PATH, so it will run the brew one first. All this
        meaning, your system should be automatically pointing to the brew version.
        You can double check though, if you want, by checking with `which -a zsh`
        and it should show two versions, then check the PATH and see which is listed
        fist on the path.
    - System ZSH: `/bin/zsh`
    - User installed ZSH using this method: `/opt/homebrew/bin/zsh`
- Do the same thing we did above, for bash, now for Zsh:
    ```bash
    $ brew install zsh
    $ sudo vim /etc/shells
    
    # Add to bottom of file:
    /opt/homebrew/bin/zsh
    
    # The above will whitelist the Zsh installed by Homebrew

    # Now set the Homebrew Zsh as the default:
    $ chsh -s /opt/homebrew/bin/zsh
    
    # Change bash for root user
    $ sudo chsh -s /opt/homebrew/bin/zsh
    ```
- Set IDE to use the Homebrew ZSH for its integrated terminal, if it has one
    - VS Code: Code -> Preferences -> Settings, open settings, search for
        `terminal.integrated.defaultProfile`, set the value to be the Homebrew ZSH
        for your operating system

## Font
- Many programmer friendly, open source, fonts exist
    - Look at some examples: [NerdFonts Example Page][nerd-fonts-download]
    - Great one with ligatures: [FiraCode][fira-code-github]
1. Find a preferred font
1. With the preferred font, we can patch it to add programmer glyphs using
[Nerd Fonts][nerd-fonts-github]
    - Nerd Fonts has a script that can patch fonts to add the Nerd Fonts glyphs to a
        font
    - Many fonts are already patched ready for download, like [Fira Code pathed with
    Nerd Font][fira-code-nerd-font]
1. Check README on current installation instructions, but read the bottom of it
    - Make sure to install the patched fonts. In the example FiraCode, the readme
        is copied from FiraCode, verbatim, and then, has new instructions at the
        bottom added to it that are specific to patched Nerd Fonts.
        [This][firacode-nerd-font-instructions] is a link to the FiraCode section
        to read and follow.
    - TL;DR: For FiraCode, don't click the download link in the README, that's the
        direct link to FiraCode original (not patched with Nerd Fonts). You need
        to go into each of the folders at the top and download a font from there.
        [Quick link example][firacode-nerdfont-regular]
3. Configure apps to use font (instructions below for Macs):
    - iTerm2: iTerm2 -> Preferences -> Profiles -> Text, set Font to the font and
        tick the checkbox for 'Use ligatures'
    - VS Code: Code -> Preferences -> Settings, open settings
        - Search `editor.fontLigatures`, set `true`
        - Change the base font for VS Code with `editor.fontFamily` which also
            applies to the integrated terminal, or just change the font family for
            the integrated terminal with `terminal.integrated.fontFamily`
            - The value for the default font says something like
                `Menlo, Monaco, 'Courier New', monospace`. Add the font to the front
                of that list, example: 
                `'FiraCode Nerd Font', Menlo, Monaco, 'Courier New', monospace`
            - Evaluates fonts in order and applies the first one it finds installed
        

## [Zinit][zinit-intro]
- Zsh plugin manager, loads fast
    - Allows installation of Oh My Zsh and Prezto plugins
    - zshrc file referenced in next steps has some things in it that use zinit
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

## ~/.vimrc File
- See [vimrc file][vimrc-file]

## ~/.p10k.zsh File
- Personal preference, if you have a [.p10k.zsh][p10k-file] file, put it in your
    home folder now before we do the .zshrc file in the next step as it will
    install and use p10k and try to configure it, or use the one you have if
    it is put in the home directory now.

## ~/.zshrc File
- On Mac, zsh will load the /etc/zshrc file first and then the ~/.zshrc file.
    Anything in the ~/.zshrc file overrides the /etc/zshrc file.
- See the [zshrc][zshrc-file] file in this repo

## Github CLI
- `brew install gh`
- `gh auth login`
- Copilot:
    - `gh extension install github/gh-copilot`
    - `gh copilot config` - Set usage analytics to no.

## LSD
- `$ ls` command replacement. Has glyphs from [Nerd Fonts][nerd-fonts-github].
- [Github Link][lsd-github]
- `brew install lsd`

## Fun
- Command Line
    - [Pipes Screensaver][pipes-github]
    - [CMatrix Screensaver][cmatrix-github]

## DevUtils
- Useful tool for a variety of small developer situations
- [Website][devutils-website]
- Homebrew or download
- For Windows: https://devtoys.app/

## HTTPie
- Nicer curl for API's and URL's
- [Website][httpie-website]
- Homebrew, have a Desktop UI incoming, but not available as of mid 2022

## Beekeeper Studio
- DB client
- [Website][beekeeper-studio]

## pyenv
- Python version management
- [Github][pyenv-github]
- Homebrew
- Add to .zshrc:
    ```bash
    # pyenv
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init - zsh)"
    ```
- After installing, check that you have the
    [recommended build environment][pyenv-build-env]
    - 🍎 Apple silicon, as of Sept. 2022, xz was not installed, had to `brew install xz`
        to get it. All the other ones were pre-installed (zlib, readline, tcl-tk, etc.)
- Install some python versions and set one globally
    - `$ pyenv install -l`
    - `$ pyenv install 3.x.x`
    - `$ pyenv global 3.x.x`

## Poetry
- Python package, dependency, environment management
- [Website][poetry-website]
- [Installation][poetry-install]
    - Add Poetry install location to your PATH in .zshrc file:
        - `export PATH="$HOME/.local/bin:${PATH}"`
- Poetry defaults to create virtual environments in a central location, to create inside
    the project in a .venv folder, set `poetry config virtualenvs.in-project true`

## Commands
- Clear python pycache:
`$ find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf`

# Data Science Additionals

## Package Manager

### Micromamba
- Conda, from Anaconda, is a package installer. Poetry is another package installer,
but Poetry is only Python. Conda can do python and non-python packages which is what
data science needs because there are some packages that are not python that are used
in data science. Mamba is a replacement for Conda as it is faster.
- Install Micromamba, which a small self-contained mamba without conda bloat.
    - brew install, or from their docs: `"${SHELL}" <(curl -L micro.mamba.pm/install.sh)`
    - https://aseifert.com/p/python-environments/ Good explaination of env tools
- Create a `~/.mambarc` file to use conda-forge instead of `defaults` for licensing
reasons (this can also go in an environment file in a repo):
```yaml
channels:
    - conda-forge
```

### Poetry
- Another option is to use Poetry.
- When using Poetry with Data Science libraries, some libraries or functions, like
ARIMA, will rely on XGBoost. XGBoost relies on OpenMP for parallel processing. On
macOS, the OpenMP runtime library (libomp.dylib) isn't installed by default. Install
it with: `brew install libomp`

###
## Jupyter
Use Jupyter in VS Code.



# Other, Not Organized

## Change Apple Emoji for JoyPixels
- https://apple.stackexchange.com/a/409205

## Packages for Python Projects:
black, isort, pytest, pytest-cov, pre-commit
- Black is an active linter, flake8 is a passive one

[x-code]: https://apps.apple.com/us/app/xcode/id497799835?mt=12
[iterm2-homepage]: https://iterm2.com/
[iterm-themes-github]: https://github.com/mbadolato/iTerm2-Color-Schemes
[vs-code-homepage]: https://code.visualstudio.com/
[github-desktop-homepage]: https://desktop.github.com/
[docker-desktop-homepage]: https://www.docker.com/products/docker-desktop/
[brew-homepage]: https://brew.sh/
[homebrew-installation-page]: https://docs.brew.sh/Installation
[zinit-github]: https://github.com/zdharma-continuum/zinit
[bash-on-macos]: https://itnext.io/upgrading-bash-on-macos-7138bd1066ba
[zinit-intro]: https://zdharma-continuum.github.io/zinit/wiki/INTRODUCTION/
[zinit-update]: https://github.com/zdharma-continuum/zinit#updating-zinit-and-plugins
[nerd-fonts-download]: https://www.nerdfonts.com/font-downloads
[fira-code-github]: https://github.com/tonsky/FiraCode
[nerd-fonts-github]: https://github.com/ryanoasis/nerd-fonts
[fira-code-nerd-font]: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode
[firacode-nerd-font-instructions]: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode#which-font
[firacode-nerdfont-regular]: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode/Regular/complete
[vimrc-file]: https://github.com/ampersand-five/mac-setup/blob/main/.vimrc
[p10k-file]: https://github.com/ampersand-five/mac-setup/blob/main/.p10k.zsh
[zshrc-file]: https://github.com/ampersand-five/mac-setup/blob/main/.zshrc
[lsd-github]: https://github.com/Peltoche/lsd
[iterm2-themes-github]: https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/README.md
[pipes-github]: https://github.com/pipeseroni/pipes.sh
[cmatrix-github]: https://github.com/abishekvashok/cmatrix/
[hush-login-stackoverflow]: https://stackoverflow.com/questions/15769615/remove-last-login-message-for-new-tabs-in-terminal
[devutils-website]: https://devutils.com/
[httpie-website]: https://httpie.io/
[beekeeper-studio]: https://www.beekeeperstudio.io/
[pyenv-github]: https://github.com/pyenv/pyenv
[pyenv-build-env]: https://github.com/pyenv/pyenv#install-python-build-dependencies
[poetry-website]: https://python-poetry.org/
[poetry-install]: https://python-poetry.org/docs/master/#installing-with-the-official-installer
