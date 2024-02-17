


# Korean support
echo "deb-src http://ftp.harukasan.org/kali kali-rolling main non-free contrib" | sudo tee -a /etc/apt/sources.list
echo "deb http://ftp.harukasan.org/kali kali-rolling main non-free contrib"| sudo tee -a /etc/apt/sources.list

sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade && sudo apt-get autoremove && sudo apt-get clean
sudo apt update
sudo apt-get install fcitx-hangul -y
sudo apt-get install fcitx-lib* -y
sudo apt-get install fonts-nanum* -y
sudo apt-get install python3.11-venv
# Install golang
sudo apt-get install golang-go -y

# Install feroxbuster
sudo apt install -y feroxbuster

sudo apt-get install -y fzf

# Install gobuster
go install github.com/OJ/gobuster/v3@latest
mv ./go/bin/gobuster /usr/local/bin

# Update pip
python3 -m pip install --upgrade pip

python3 -m venv venv
source venv/bin/activate
pip3 install pwncat-cs

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
git clone https://github.com/RustScan/RustScan
cd RustScan
cargo build --release
sudo ln -s ~/RustScan/target/release/rustscan /usr/bin/rustscan




