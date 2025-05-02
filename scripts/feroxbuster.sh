#!/bin/bash

# 기본 워드리스트 경로
DEFAULT_WORDLIST="/usr/share/wordlists/seclists/Discovery/Web-Content/raft-small-words.txt"

# URL 입력
read -p "대상 URL 입력 (예: http://example.com): " URL

# 워드리스트 입력 (탭 자동완성 가능, 기본값은 엔터 시 적용)
echo "워드리스트 경로 입력 (엔터 시 기본값 사용: $DEFAULT_WORDLIST)"
read -e WORDLIST

# 비어 있으면 기본값 적용
if [ -z "$WORDLIST" ]; then
    WORDLIST="$DEFAULT_WORDLIST"
    echo "기본 워드리스트 사용: $WORDLIST"
fi

echo "feroxbuster -u $URL -w $WORDLIST -t 40 -x php,html,txt,json -o result_$(date +%s).txt"
# feroxbuster 실행
feroxbuster -u "$URL" -w "$WORDLIST" -t 40 -x php,html,txt,json -o result_$(date +%s).txt
