#!/bin/bash
installExt(){
   code --install-extension $1
}

installExt adpyke.codesnap
installExt christian-kohler.path-intellisense
installExt dbaeumer.vscode-eslint
installExt eamodio.gitlens
installExt esbenp.prettier-vscode
installExt iocave.customize-ui
installExt iocave.monkey-patch
installExt mhutchie.git-graph
installExt PKief.material-icon-theme
installExt redhat.vscode-yaml
installExt zhuangtongfa.material-theme

mkdir -p ~/.config/Code/User/
cp ./configs/vscode/settings.json ~/.config/Code/User/
