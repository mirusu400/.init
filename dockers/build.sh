#!/bin/bash

# 파라미터로 버전을 받거나 입력받기
if [ $# -eq 1 ]; then
    UBUNTU_VERSION=$1
else
    read -p "Ubuntu 버전을 입력하세요 (예: 1604, 1804, 2004): " UBUNTU_VERSION
fi

# 입력값 검증
if [[ ! $UBUNTU_VERSION =~ ^[0-9]{4}$ ]]; then
    echo "올바른 버전 형식이 아닙니다. 4자리 숫자를 입력하세요 (예: 1604, 1804, 2004)"
    exit 1
fi

# Dockerfile 경로 확인
DOCKERFILE_PATH="Dockerfile_${UBUNTU_VERSION}"
if [ ! -f "$DOCKERFILE_PATH" ]; then
    echo "해당 버전의 Dockerfile이 존재하지 않습니다: $DOCKERFILE_PATH"
    exit 1
fi

# 이미지 이름과 태그 설정
IMAGE_NAME="pwn_${UBUNTU_VERSION}"
IMAGE_TAG="latest"

# 현재 디렉토리 경로 저장
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Docker 이미지 빌드
echo "Docker 이미지 빌드 중... (Ubuntu ${UBUNTU_VERSION})"
docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -f ${SCRIPT_DIR}/${DOCKERFILE_PATH} ${SCRIPT_DIR}

# 빌드 성공 여부 확인
if [ $? -ne 0 ]; then
    echo "이미지 빌드 실패"
    exit 1
fi

echo "이미지 빌드 완료"

# 컨테이너 실행
echo "컨테이너 실행 중..."
docker run -it --rm \
    --name pwn_${UBUNTU_VERSION}_container \
    --hostname pwn_${UBUNTU_VERSION} \
    -v ${SCRIPT_DIR}/../:/workspace \
    ${IMAGE_NAME}:${IMAGE_TAG} \
    /bin/zsh 