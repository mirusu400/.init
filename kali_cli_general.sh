#!/usr/bin/env bash
set -euo pipefail

ARCH="$(uname -m)"
USER_NAME="$(id -un)"
USER_HOME="${HOME}"

echo "[*] Updating system packages..."
sudo apt update
sudo apt full-upgrade -y
sudo apt autoremove -y

echo "[*] Installing base packages..."
sudo apt install -y \
    wget \
    curl \
    git \
    unzip \
    build-essential \
    zlib1g-dev \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libreadline-dev \
    libffi-dev \
    libsqlite3-dev \
    libbz2-dev \
    python3 \
    python3-pip \
    python3.11-venv \
    golang-go \
    feroxbuster \
    fzf \
    burpsuite

echo "[*] Upgrading pip..."
python3 -m pip install --upgrade pip

echo "[*] Installing gobuster..."
mkdir -p "${USER_HOME}/go/bin"
go install github.com/OJ/gobuster/v3@latest
if [ -f "${USER_HOME}/go/bin/gobuster" ]; then
    sudo install -m 0755 "${USER_HOME}/go/bin/gobuster" /usr/local/bin/gobuster
fi

echo "[*] Installing uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh

# Make sure local bin paths are available
grep -qF 'export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.local/share/uv/bin:$PATH"' "${USER_HOME}/.bashrc" || \
    echo 'export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.local/share/uv/bin:$PATH"' >> "${USER_HOME}/.bashrc"

grep -qF 'export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.local/share/uv/bin:$PATH"' "${USER_HOME}/.zshrc" 2>/dev/null || \
    echo 'export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.local/share/uv/bin:$PATH"' >> "${USER_HOME}/.zshrc"

echo "[*] Setting feroxbuster alias..."
grep -qF "alias feroxbuster='feroxbuster --filter-status=404,403 --timeout=10 --rate-limit 3'" "${USER_HOME}/.bashrc" || \
    echo "alias feroxbuster='feroxbuster --filter-status=404,403 --timeout=10 --rate-limit 3'" >> "${USER_HOME}/.bashrc"

grep -qF "alias feroxbuster='feroxbuster --filter-status=404,403 --timeout=10 --rate-limit 3'" "${USER_HOME}/.zshrc" 2>/dev/null || \
    echo "alias feroxbuster='feroxbuster --filter-status=404,403 --timeout=10 --rate-limit 3'" >> "${USER_HOME}/.zshrc"

echo "[*] Installing Python 3.11.9 from source..."
cd /tmp
wget -q https://www.python.org/ftp/python/3.11.9/Python-3.11.9.tgz
tar -xf Python-3.11.9.tgz
cd Python-3.11.9
./configure --enable-optimizations
make -j"$(nproc)"
sudo make altinstall

echo "[*] Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# shellcheck disable=SC1090
source "${USER_HOME}/.cargo/env"

echo "[*] Building RustScan..."
cd "${USER_HOME}"
if [ ! -d RustScan ]; then
    git clone https://github.com/RustScan/RustScan
fi
cd RustScan
cargo build --release
sudo install -m 0755 "${USER_HOME}/RustScan/target/release/rustscan" /usr/local/bin/rustscan

echo "[*] Installing enum4linux-ng..."
"${USER_HOME}/.local/bin/uv" tool install git+https://github.com/cddmp/enum4linux-ng || true

echo "[*] Installing pwncat-vl in isolated venv..."
mkdir -p "${USER_HOME}/.pwncat-env"
cd "${USER_HOME}/.pwncat-env"
"${USER_HOME}/.local/bin/uv" venv --python 3.10
# shellcheck disable=SC1091
source .venv/bin/activate
"${USER_HOME}/.local/bin/uv" pip install setuptools git+https://github.com/Chocapikk/pwncat-vl
"${USER_HOME}/.local/bin/uv" pip install --force-reinstall ZODB ZEO zope.interface zope.proxy zodburi
"${USER_HOME}/.local/bin/uv" pip install "setuptools<70.0.0"
deactivate
mkdir -p "${USER_HOME}/.local/bin"
ln -sf "${USER_HOME}/.pwncat-env/.venv/bin/pwncat-vl" "${USER_HOME}/.local/bin/pwncat-vl"

echo "[*] Installing SubSurfer in isolated venv..."
mkdir -p "${USER_HOME}/.subsurfer-env"
cd "${USER_HOME}/.subsurfer-env"
"${USER_HOME}/.local/bin/uv" venv --python 3.10
# shellcheck disable=SC1091
source .venv/bin/activate
"${USER_HOME}/.local/bin/uv" pip install setuptools git+https://github.com/mirusu400/SubSurfer.git
"${USER_HOME}/.local/bin/uv" pip install "setuptools<70.0.0"
deactivate
ln -sf "${USER_HOME}/.subsurfer-env/.venv/bin/subsurfer" "${USER_HOME}/.local/bin/subsurfer"

echo "[*] Extracting rockyou if present..."
if [ -f /usr/share/seclists/Passwords/Leaked-Databases/rockyou.txt.tar ]; then
    sudo tar -xf /usr/share/seclists/Passwords/Leaked-Databases/rockyou.txt.tar \
        -C /usr/share/seclists/Passwords/Leaked-Databases/
fi

echo "[*] Installing architecture-specific packages..."
if [ "${ARCH}" = "x86_64" ]; then
    echo "[*] x86_64 detected, installing Volatility 2/3..."

    sudo apt install -y python2 python2.7-dev libpython2-dev || true

    cd /tmp
    wget -q https://bootstrap.pypa.io/pip/2.7/get-pip.py -O get-pip.py
    sudo python2 get-pip.py || true
    sudo python2 -m pip install -U setuptools wheel || true
    python2 -m pip install -U yara pycrypto pillow openpyxl ujson pytz ipython capstone || true
    pip2 install distorm3==3.3.4 || true
    sudo python2 -m pip install yara || true
    python2 -m pip install -U git+https://github.com/volatilityfoundation/volatility.git || true

    sudo apt install -y python3-dev libpython3-dev python3-setuptools python3-wheel
    python3 -m pip install -U distorm3 yara pycrypto pillow openpyxl ujson pytz ipython capstone
    python3 -m pip install -U git+https://github.com/volatilityfoundation/volatility3.git

elif [ "${ARCH}" = "aarch64" ]; then
    echo "[*] aarch64 detected, skipping x86-only tooling..."
fi

echo "[*] Installing custom scripts if present..."
mkdir -p "${USER_HOME}/scripts"

if [ -f scripts/xfreerdp3.sh ]; then
    install -m 0755 scripts/xfreerdp3.sh "${USER_HOME}/scripts/xfreerdp3.sh"
fi

if [ -f scripts/feroxbuster.sh ]; then
    install -m 0755 scripts/feroxbuster.sh "${USER_HOME}/scripts/feroxbuster.sh"
fi

echo "[*] Done."
echo "[*] Re-login or run: source ~/.bashrc"
