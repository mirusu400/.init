#!/bin/bash

# 사용자에게 입력 받기
read -p "IP Address: " IP
read -p "Username: " USER
read -s -p "Password: " PASSWORD
echo

# 접속 명령 실행
xfreerdp /v:$IP /u:$USER /p:$PASSWORD +clipboard /cert:ignore /dynamic-resolution
