sudo apt-get -y update
sudo snap install code
sudo snap install slack
sudo snap install discord
sudo apt-get -y install gnome-tweak-tool
sudo apt-get -y install neovim
sudo apt-get -y install ibus-hangul
sudo apt-get -y install git
sudo apt-get -y install curl
sudo apt-get -y install wget
git config --global user.name "mirusu400"
git config --global user.email "mirusu400@naver.com"

# install chrome
sudo apt-get install libxss1 libappindicator1 libindicator7
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome*.deb


# ubuntu github auto login
sudo mkdir -p -m 755 /etc/apt/keyrings && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y

gh auth login

