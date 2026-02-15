


# Korean support
echo "deb-src http://ftp.harukasan.org/kali kali-rolling main non-free contrib" | sudo tee -a /etc/apt/sources.list
echo "deb http://ftp.harukasan.org/kali kali-rolling main non-free contrib"| sudo tee -a /etc/apt/sources.list

sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y && sudo apt-get clean
sudo apt update
sudo apt-get install -y wget
sudo apt-get install -y fcitx-hangul
sudo apt-get install -y fcitx-lib*
sudo apt-get install -y fonts-nanum*
sudo apt-get install -y python3.11-venv 
# Install golang
sudo apt-get install -y golang-go

# Install feroxbuster
sudo apt install -y feroxbuster

sudo apt-get install -y fzf

# Install gobuster
go install github.com/OJ/gobuster/v3@latest
mv ./go/bin/gobuster /usr/local/bin

# Update pip
python3 -m pip install --upgrade pip
pip3 install 


# python3 -m venv venv
# source venv/bin/activate

# Instead install pwncat-cs I'll install pwncat-lv cause its better
# pip3 install pwncat-cs
sudo apt install pipx
pipx ensurepath
pipx install git+https://github.com/Chocapikk/pwncat-vl

# Install pwncat-cs with python 3.11
# Install python 3.11
sudo apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
cd /tmp
wget https://www.python.org/ftp/python/3.11.9/Python-3.11.9.tgz
tar -xf Python-3.11.9.tgz
cd Python-3.11.9
./configure --enable-optimizations
make -j$(nproc)
sudo make altinstall

# Install pwncat-cs
# It doesnt work fy
# pipx install git+https://github.com/Chocapikk/pwncat-vl --python $(which python3.11)

# Install uvx for installing subsurfer
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install rust
cd ~
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

git clone https://github.com/RustScan/RustScan
cd RustScan
cargo build --release
sudo cp ~/RustScan/target/release/rustscan /usr/bin/rustscan
sudo chmod +x /usr/bin/rustscan


# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh


# Install enum4linux-ng
uv tool install git+https://github.com/cddmp/enum4linux-ng

# Install pwncat-vl
uv tool install git+https://github.com/Chocapikk/pwncat-vl --python 3.10

###################################
# x86_64 specific installations
###################################

if [ "$ARCH" = "x86_64" ]; then
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

    # install mullvad ~lenny~
    wget -O mullvad_vpn.deb https://mullvad.net/en/download/app/deb/latest
    sudo dpkg -i mullvad_vpn.deb
    rm -rf mullvad_vpn.deb

    wget -O mullvad.tar.gz https://mullvad.net/en/download/browser/linux-x86_64/latest
    tar -xvf mullvad.tar.gz

elif [ "$ARCH" = "aarch64" ]; then
    # Install vmtools
    sudo apt install -y --reinstall open-vm-tools-desktop fuse

fi


# Install custom scripts
mkdir -p ~/scripts
cp scripts/xfreerdp3.sh ~/scripts/xfreerdp3.sh
chmod +x ~/scripts/xfreerdp3.sh

cp scripts/feroxbuster.sh ~/scripts/feroxbuster.sh
chmod +x ~/scripts/feroxbuster.sh


# install bloodhound (kali-only)
sudo apt-get install -y bloodhound
sudo bloodhound-setup


