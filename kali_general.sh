

sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y
sudo apt update
sudo apt-get install -y wget
sudo apt-get install -y fcitx-hangul
sudo apt-get install -y fcitx-lib*
sudo apt-get install -y fonts-nanum*
sudo apt-get install -y python3.11-venv 
sudo apt-get install -y burpsuite
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

# Set feroxbuster alias
grep -qF 'alias feroxbuster=' ~/.zshrc || echo "alias feroxbuster='feroxbuster --filter-status=404,403 --timeout=10 --rate-limit 3'" >> ~/.zshrc


# python3 -m venv venv
# source venv/bin/activate

# Instead install pwncat-cs I'll install pwncat-lv cause its better
# pip3 install pwncat-cs
# sudo apt install pipx
# pipx ensurepath
# pipx install git+https://github.com/Chocapikk/pwncat-vl

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

# Install uvx for installing subsurfer
curl -LsSf https://astral.sh/uv/install.sh | sh


# Install rust
cd ~
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. "$HOME/.cargo/env"

git clone https://github.com/RustScan/RustScan
cd RustScan
cargo build --release
sudo cp ~/RustScan/target/release/rustscan /usr/bin/rustscan
sudo chmod +x /usr/bin/rustscan


# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh


# Install subsurfer


# Install enum4linux-ng
uv tool install git+https://github.com/cddmp/enum4linux-ng

# Install pwncat-vl
# uv tool install git+https://github.com/Chocapikk/pwncat-vl --python 3.10
mkdir -p ~/.pwncat-env
cd ~/.pwncat-env

uv venv --python 3.10
source .venv/bin/activate
uv pip install setuptools git+https://github.com/Chocapikk/pwncat-vl
uv pip install --force-reinstall ZODB ZEO zope.interface zope.proxy zodburi
uv pip install "setuptools<70.0.0"
deactivate
ln -sf ~/.pwncat-env/.venv/bin/pwncat-vl ~/.local/bin/pwncat-vl

sudo tar -xvf /usr/share/seclists/Passwords/Leaked-Databases/rockyou.txt.tar -C /usr/share/seclists/Passwords/Leaked-Databases/


mkdir -p ~/.subsurfer-env
cd ~/.subsurfer-env

uv venv --python 3.10
source .venv/bin/activate
uv pip install setuptools git+https://github.com/mirusu400/SubSurfer.git
uv pip install "setuptools<70.0.0"
deactivate
ln -sf ~/.subsurfer-env/.venv/bin/subsurfer ~/.local/bin/subsurfer

sudo tar -xvf /usr/share/seclists/Passwords/Leaked-Databases/rockyou.txt.tar -C /usr/share/seclists/Passwords/Leaked-Databases/

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

    echo "export PATH=/home/`whoami`/.local/bin:$PATH\n" >> ~/.zshrc
    . ~/.zshrc

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


# Make no sleep
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/blank-on-ac -n -t int -s 0
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-ac-sleep -n -t int -s 0
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-ac-off -n -t int -s 0
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/lock-screen-suspend-hibernate -n -t bool -s false

# Xfce Screensaver
xfconf-query -c xfce4-screensaver -p /saver/enabled -n -t bool -s false
xfconf-query -c xfce4-screensaver -p /lock/enabled -n -t bool -s false

# Disable DPMS (Display Power Management Signaling)
xset s off
xset s noblank
xset -dpms


# Change keyboard to hangul (Experimental!)
# 2. Generate and Set Locale to UTF-8 (Crucial step to prevent crashes)
sudo locale-gen ko_KR.UTF-8
sudo update-locale LANG=ko_KR.UTF-8

# 3. Set Input Method to Fcitx (Non-interactive)
im-config -n fcitx

# 4. Create Environment Variables (Using printf to avoid encoding issues)
cat <<EOF > ~/.xprofile
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
EOF

# 5. Initialize Fcitx Config Directories
mkdir -p ~/.config/fcitx

# 6. Set Input Method Order (English first, then Hangul)
# Note: "hangul" is the internal name, no actual Korean characters used here.
cat <<EOF > ~/.config/fcitx/profile
[Profile]
EnabledIMList=fcitx-keyboard-us:True,hangul:True
DefaultIM=fcitx-keyboard-us
EOF

# 7. Set 'Shift+Space' as the Toggle Key
cat <<EOF > ~/.config/fcitx/config
[Hotkey]
TriggerKey=SHIFT_SPACE
SwitchKey=
EOF

# install bloodhound (kali-only)
sudo apt-get install -y bloodhound
sudo bloodhound-setup


