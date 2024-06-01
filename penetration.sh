


# Korean support
echo "deb-src http://ftp.harukasan.org/kali kali-rolling main non-free contrib" | sudo tee -a /etc/apt/sources.list
echo "deb http://ftp.harukasan.org/kali kali-rolling main non-free contrib"| sudo tee -a /etc/apt/sources.list

sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y && sudo apt-get clean
sudo apt update
sudo apt-get install fcitx-hangul -y
sudo apt-get install fcitx-lib* -y
sudo apt-get install fonts-nanum* -y
sudo apt-get install python3.11-venv -y
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

# Install volatility2
sudo apt install -y python2 python2.7-dev libpython2-dev
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
sudo python2 get-pip.py
sudo python2 -m pip install -U setuptools wheel

python2 -m pip install -U  yara pycrypto pillow openpyxl ujson pytz ipython capstone
pip2 install distorm3==3.3.4
sudo python2 -m pip install yara
sudo ln -s /usr/local/lib/python2.7/dist-packages/usr/lib/libyara.so /usr/lib/libyara.so
python2 -m pip install -U git+https://github.com/volatilityfoundation/volatility.git



# install volatility3
sudo apt install -y python3 python3-dev libpython3-dev python3-pip python3-setuptools python3-wheel

python3 -m pip install -U distorm3 yara pycrypto pillow openpyxl ujson pytz ipython capstone
python3 -m pip install -U git+https://github.com/volatilityfoundation/volatility3.git

echo "export PATH=/home/`whoami`/.local/bin:$PATH\n" >> ~/.bashrc
. ~/.bashrc



