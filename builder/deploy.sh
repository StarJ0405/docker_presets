#!/bin/bash
set -e # 명령어 실행 중 오류 발생 시 즉시 종료
# 권한설정
# sudo chown root:root /home/아이디/deploy.sh
# sudo chmod 500 /home/아이디/deploy.sh

# 0. 환경변수 설정
HOME="$1"
IMAGE_FULL_TAG="$2"
DOCKER_USERNAME="$3"
REGISTRY_URL="$4"
DOCKER_TOKEN="$5"
CONTAINER_NAME="$6"
VOLUME_PATH="$7"

#1. Docker 로그인
echo "${DOCKER_TOKEN}" | sudo docker login ${REGISTRY_URL} -username "${DOCKER_USERNAME}" --password-stdin

#2. Docker pull
sudo docker pull "${IMAGE_FULL_TAG}"

#3. Dokcer 로그아웃
sudo docker logout ${REGISTRY_URL}
#4. 기존 폴더 삭제 및 재생성
sudo rm -rf ${VOLUME_PATH}
sudo mkdir -p ${VOLUME_PATH}

#5. 기존 컨테이너 중지 및 제거
if docker ps -qf "name=${CONTAINER_NAME}" | grep -q .; then
    docker stop "${CONTAINER_NAME}"
    docker rm -f "${CONTAINER_NAME}"
else
    # 실행 중이지 않지만 존재하는 컨테이너도 제거 (선택 사항)
    if docker ps -aqf "name=${CONTAINER_NAME}" | grep -q .; then
        docker rm -f "${CONTAINER_NAME}"
    fi
fi

#6. 새 컨테이너 실행
docker run -d \
    -v "${VOLUME_PATH}":/share \
    --name "${CONTAINER_NAME}" \
    "${IMAGE_FULL_TAG}"