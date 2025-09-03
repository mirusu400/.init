# Working on kali-linux-2025.2-installer-arm64.iso

sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y && sudo apt-get clean
sudo apt update
sudo apt --fix-broken install
sudo apt-get install -y wget
sudo apt-get install -y fonts-nanum*
sudo apt install -y fastfetch
sudo apt-get install -y fcitx-hangul
sudo apt-get install -y fcitx-lib*

sudo apt-get install -y python3.13-venv 
# Install golang
sudo apt-get install -y golang-go

# Install feroxbuster
sudo apt install -y feroxbuster

sudo apt-get install -y fzf

# Install gobuster
go install github.com/OJ/gobuster/v3@latest
mv ./go/bin/gobuster /usr/local/bin

# Update pip
python3 -m pip install --upgrade pip --break-system-packages


# Maybe pwncat-cs is deprecated? :(
# python3 -m venv venv
# source venv/bin/activate
# pip3 install 
# pip3 install pwncat-cs


# Install rust, Rustscan, Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
git clone https://github.com/RustScan/RustScan
cd RustScan
cargo build --release
sudo cp ~/RustScan/target/release/rustscan /usr/bin/rustscan
sudo chmod +x /usr/bin/rustscan
cargo install rustcat

# Install volatility2
# sudo apt install -y python2 python2.7-dev libpython2-dev
# curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
# sudo python2 get-pip.py
# sudo python2 -m pip install -U setuptools wheel

# python2 -m pip install -U  yara pycrypto pillow openpyxl ujson pytz ipython capstone
# pip2 install distorm3==3.3.4
# sudo python2 -m pip install yara
# sudo ln -s /usr/local/lib/python2.7/dist-packages/usr/lib/libyara.so /usr/lib/libyara.so
# python2 -m pip install -U git+https://github.com/volatilityfoundation/volatility.git



# install volatility3
# sudo apt install -y python3 python3-dev libpython3-dev python3-pip python3-setuptools python3-wheel

# python3 -m pip install -U distorm3 yara pycrypto pillow openpyxl ujson pytz ipython capstone
# python3 -m pip install -U git+https://github.com/volatilityfoundation/volatility3.git

# echo "export PATH=/home/`whoami`/.local/bin:$PATH\n" >> ~/.bashrc
# . ~/.bashrc



# install mullvad ~lenny~
# wget -O mullvad_vpn.deb https://mullvad.net/en/download/app/deb/latest
# sudo dpkg -i mullvad_vpn.deb
# rm -rf mullvad_vpn.deb

# wget -O mullvad.tar.gz https://mullvad.net/en/download/browser/linux-x86_64/latest
# tar -xvf mullvad.tar.gz


# # Install custom scripts
# mkdir -p ~/scripts
# cp scripts/xfreerdp3.sh ~/scripts/xfreerdp3.sh
# chmod +x ~/scripts/xfreerdp3.sh

# cp scripts/feroxbuster.sh ~/scripts/feroxbuster.sh
# chmod +x ~/scripts/feroxbuster.sh


# Install vmtools
sudo apt install -y --reinstall open-vm-tools-desktop fuse

# install bloodhound (kali-only)
sudo apt-get install -y bloodhound
sudo bloodhound-setup



