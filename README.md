# omz
Setup omz on a remote machine in one single command

## Usage

```bash
./setup.sh /path/to/key.pem ec2-user@ip.address
```

## Details

```bash
ssh -i /path/to/key.pem ec2-user@ip.address
sudo dnf install zsh git -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo sed -i "s|$(whoami):/bin/bash|$(whoami):$(which zsh)|" /etc/passwd
git clone https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/autoswitch_virtualenv
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
nano ~/.zshrc # copy .zshrc from this repo.
source ~/.zshrc # logout, login again to use zsh.
echo $SHELL # verify zsh is default shell.
```
