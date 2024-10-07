#!/bin/bash

# Usage: ./setup_ec2.sh /path/to/key.pem ec2-user@ip.address

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 /path/to/key.pem ec2-user@ip.address"
    exit 1
fi

KEY_PATH=$1
EC2_ADDRESS=$2

# Function to run commands on EC2
run_on_ec2() {
    ssh -i "$KEY_PATH" "$EC2_ADDRESS" "$1"
}

# Install zsh and git
run_on_ec2 "sudo dnf install zsh git -y"

# Install Oh My Zsh
run_on_ec2 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'

# Change default shell to zsh
run_on_ec2 'sudo sed -i "s|$(whoami):/bin/bash|$(whoami):$(which zsh)|" /etc/passwd'

# Install zsh plugins
run_on_ec2 'git clone https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/autoswitch_virtualenv'
run_on_ec2 'git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use'

# Copy .zshrc file (assuming it's in the same directory as this script)
scp -i "$KEY_PATH" .zshrc "$EC2_ADDRESS:~/.zshrc"

# Source .zshrc and verify shell
run_on_ec2 'source ~/.zshrc && echo $SHELL'

echo "Setup complete. Please log out and log back in to use Zsh."