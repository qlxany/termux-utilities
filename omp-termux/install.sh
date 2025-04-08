#!/bin/bash

# Define a variable for the green color
GREEN='\033[0;32m'
# Define a variable to reset color
NC='\033[0m' # No Color

# Update and upgrade the system
echo -e "${GREEN}Updating repositories...${NC}"
apt update -y && apt upgrade -y

# Install necessary packages
echo -e "${GREEN}Installing dependencies...${NC}"
apt install zsh git wget oh-my-posh -y

# Install Oh My Zsh
echo -e "${GREEN}Installing Oh My Zsh...${NC}"
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
# Function to list and choose a theme
choose_theme() {
  echo -e "${GREEN}Available Oh My Posh themes:${NC}"
  themes=("aliens" "M365Princess" "agnoster" "amro" "atomic" "avit" "blue-owl" "bubbles" "catppuccin_frappe" "catppuccin_latte" "catppuccin_mocha" "catppuccin_macchiato" "cinnamon" "cobalt2" "dracula" "fish" "gruvbox" "honukai" "jandedobbeleer" "lambda" "material" "nordtron" "powerlevel10k_classic" "powerlevel10k_lean" "powerlevel10k_modern" "powerlevel10k_rainbow" "robbyrussell" "spaceship" "tokyonight_storm" "unicorn")
  select theme in "${themes[@]}"; do
    if [[ " ${themes[*]} " == *" $theme "* ]]; then
      echo -e "${GREEN}You have selected the theme: $theme${NC}"
      wget "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/${theme}.omp.json" -O ~/.chosen_theme.omp.json
      break
    else
      echo -e "${GREEN}Invalid selection, please try again.${NC}"
    fi
  done
}

# Call the theme selection function
choose_theme

# Add Oh My Posh initialization to .zshrc with the selected theme
echo -e "${GREEN}Configuring Oh My Posh...${NC}"
echo 'eval "$(oh-my-posh init zsh --config ~/.chosen_theme.omp.json)"' >>~/.zshrc

# Set Zsh as the default shell
echo -e "${GREEN}Setting Zsh as the default shell...${NC}"
chsh -s $(which zsh)

echo -e "${GREEN}Installation complete. Please restart your terminal or log out and back in to start using Zsh with Oh My Posh!${NC}"

# Start Zsh
zsh -y

# Exit script
exit 0
