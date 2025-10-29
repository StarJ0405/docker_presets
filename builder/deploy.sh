#!/bin/bash
set -e # 명령어 실행 중 오류 발생 시 즉시 종료
# 권한설정
# sudo chown root:root /home/아이디/deploy
# sudo chmod 555 /home/아이디/deploy.sh

LOC=/home/아이디
# 1. Docker 이미지 로드 및 삭제
docker load -i "${LOC}/app_image.tar"
rm -f "${LOC}/app_image.tar"

# 2. 기존 컨테이너 중지 및 제거
CONTAINER_NAME="builder"

# 실행 중인 컨테이너가 있으면 중지 및 제거
if docker ps -qf "name=${CONTAINER_NAME}" | grep -q .; then
    docker stop "${CONTAINER_NAME}"
    docker rm -f "${CONTAINER_NAME}"
else
    # 실행 중이지 않지만 존재하는 컨테이너도 제거 (선택 사항)
    if docker ps -aqf "name=${CONTAINER_NAME}" | grep -q .; then
        docker rm -f "${CONTAINER_NAME}"
    fi
fi

# 4. 새 컨테이너 실행
# 볼륨 경로를 변수로 명확히 사용
VOLUME_PATH="${LOC}/builder"

docker run -d \
    -v "${VOLUME_PATH}":/share \
    --name "${CONTAINER_NAME}" \
    local-app:latest