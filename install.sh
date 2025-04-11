#!/bin/bash

zshrc() {
    echo "==========================================================="
    echo "             cloning zsh-autosuggestions                   "
    echo "-----------------------------------------------------------"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    echo "==========================================================="
    echo "             cloning zsh-syntax-highlighting               "
    echo "-----------------------------------------------------------"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    echo "==========================================================="
    echo "             cloning powerlevel10k                         "
    echo "-----------------------------------------------------------"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    echo "==========================================================="
    echo "             import zshrc                                  "
    echo "-----------------------------------------------------------"
    cat .zshrc > $HOME/.zshrc
    echo "==========================================================="
    echo "             import powerlevel10k                          "
    echo "-----------------------------------------------------------"
    cat .p10k.zsh > $HOME/.p10k.zsh
}

# change time zone
sudo ln -fs /usr/share/zoneinfo/Pacific/Auckland /etc/localtime
sudo dpkg-reconfigure --frontend noninteractive tzdata

zshrc

# make directly highlighting readable - needs to be after zshrc line
echo "" >> ~/.zshrc
echo "# remove ls and directory completion highlight color" >> ~/.zshrc
echo "_ls_colors=':ow=01;33'" >> ~/.zshrc
echo 'zstyle ":completion:*:default" list-colors "${(s.:.)_ls_colors}"' >> ~/.zshrc
echo 'LS_COLORS+=$_ls_colors' >> ~/.zshrc

# set gitconfig defaults
git config --global push.autoSetupRemote true
git config --global core.editor "code --wait"

## Wait for Visual Studio Code to be available
echo "Waiting for Visual Studio Code (code command) to be available..."
while ! command -v code &> /dev/null; do
    sleep 2
done
echo "Visual Studio Code is available. Proceeding with extension installation."

## Install extension

# Visual Studio Code :: Package list
pkglist=(
ms-vscode.cpptools
ms-python.python
vscodevim.vim
# kelvin.vscode-sshfs
letmaik.git-tree-compare
donjayamanne.githistory
eamodio.gitlens
# coenraads.bracket-pair-colorizer-2
vscode-icons-team.vscode-icons
equinusocio.vsc-material-theme-icons
yzane.markdown-pdf
# ics.japanese-proofreading
# platformio.platformio-ide
github.github-vscode-theme
# bbrakenhoff.solarized-light-custom
oderwat.indent-rainbow
# streetsidesoftware.code-spell-checker
christian-kohler.path-intellisense
mhutchie.git-graph
Gruntfuggly.todo-tree
hediet.vscode-drawio
github.vscode-pull-request-github
marp-team.marp-vscode
shd101wyy.markdown-preview-enhanced
shuworks.vscode-table-formatter
esbenp.prettier-vscode
davidanson.vscode-markdownlint
njpwerner.autodocstring
ms-python.vscode-pylance
ms-vscode-remote.remote-ssh
)

for i in ${pkglist[@]}; do
  code --install-extension $i
done
