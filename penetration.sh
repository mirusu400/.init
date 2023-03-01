
sudo apt-get update

# Install golang
sudo apt-get install golang-go -y

# Install feroxbuster
sudo apt install -y feroxbuster

# Install gobuster
go install github.com/OJ/gobuster/v3@latest
mv ./go/bin/gobuster /usr/local/bin

# Update pip
python3 -m pip install --upgrade pip

# Update pwncat-cs
pip3 install pwncat-cs

