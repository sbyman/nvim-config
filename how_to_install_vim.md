# How to install nvim!

## Install basic dependencies
1.  ```
    sudo apt install neovim fzf fd-find jq maven zsh
    ```

## Install oh-my-zsh

    ```
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    ```

then copy the .zshrc on your home folder

NOTE: if you are on ubuntu there is need to add:
    ```
    alias fd=fdfind
    ```
## Install SDK manager
2.  ```
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    sdk install java 11.0.20-zulu
    sdk install java 20.0.2-zulu
    ```
## Install VIM Plug
3.  ```
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    ```
then import your .vimrc file in your home and then

## Use already existing .vimrc file
We have to tell nvim to import our existing .vimrc file

1. Open nvim
2. Run
    ```
    :help nvim
    ```
    And follow the instruction.

for help I'm gonna paste the instruction here:

    ```
    1. To start the transition, create your |init.vim| (user config) file: >vim

    :exe 'edit '.stdpath('config').'/init.vim'
    :write ++p

    2. Add these contents to the file: >vim

    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc

    3. Restart Nvim, your existing Vim config will be loaded.

    ```

now we can use our existing .vimrc file

```
    nvim .vimrc
```
```
    :PlugInstall
```

## Install your language server
```
    :LspInstallInfo
```

Look for ``jdtls`` and press ``i``

Now we are ready to use nvim as an ide for Java projects
