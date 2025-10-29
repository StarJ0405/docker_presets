# 프로젝트 설정하는 방법
1. 서버 설정
  - /etc/sudoers.d 위치에 deploy_script 내용 추가
     - 아이디는 실제로 서버에 접속할때 사용하는 아이디를 기입
     - HOME은 해당 스크립트가 존재할 위치를 써야하며, 절대경로로 기입
  - deploy.sh 생성
    - deploy_script에 설정한 위치
    - 기본적으로 파일은 수정할 필요 없음
    - 파일의 수정 권한을 관리자 계정으로 변경
      - 그룹설정) sudo chown root:root ./deploy.sh
      - 권한설정) chmod 500 ./deploy.sh
2. GitHub 설정
  - Setting --> Security --> Secrets and variables --> Actions --> New repository secret 으로 아래 내용 추가
    - BACK_ENV : 백엔드 운영용 환경변수
    - FRONT_ENV : 프론트 운영용 환경변수
    - HOST : 서버주소
    - USERNAME : 서버 계정명
    - KEY : 개인 키(private Key) 내용 ---BEIN 포함 전체
    - PORT : 포트
    - HOME : 작동할 폴더위치. 단, USERNAME으로 제공한 계정이 쓰기권한이 있는 폴더
    - DOCKER_USERNAME : 도커 계정명
    - DOCKER_TOKEN : 도커 ACCESS_TOKEN ( Account Setting --> Personal access tokens 에서 발급 가능)
    - DOCKER_REPO : 도커 허브 레포지터리
    - DOCKER_TAG : 태그 구분용(프로젝트별로 다르게 사용할 것)
3. 프로젝트 설정
  - Dockerfile 생성
    - 최상단에 위치
    - 사용하는 프론트, 백엔드 내용에 따라 수정 필요
  - copy.sh 생성
    - 최상단에 위치해야하며, 수정 불필요
  - CD.yml 설정(workflow)
    - .github/workflows/CD.yml 생성 (파일명은 변경되어도 무관)
    - name은 변경해도 상관없으나 나머지는 기본적으로 수정 금지
