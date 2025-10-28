FROM ubuntu:24.04
WORKDIR /
# 기본설치
RUN apt update
RUN apt-get update
RUN apt-get install -y locales
RUN ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
RUN localedef -f UTF-8 -i ko_KR ko_KR.UTF-8
RUN locale-gen ko_KR.UTF-8
ENV LC_ALL=ko_KR.UTF-8
ENV LANGUAGE=ko_KR.UTF-8
ENV LANG=ko_KR.UTF-8

# Node.js가 필요한경우
RUN apt-get install -y nodejs npm
RUN npm install -g n
RUN hash -r

# JAVA가 필요한경우
# RUN apt-get install openjdk-21-jdk -y

# Python이 필요한경우
# RUN apt-get install pip -y
# RUN pip install pandas --break-system-packages
# RUN pip install scikit-surprise --break-system-packages
# RUN pip install --upgrade numpy==1.26.4 --break-system-packages


#우분투 환경을 체크하는 경우에만 사용
#COPY run.sh run.sh
#RUN chmod +x ./run.sh
#CMD ["/run.sh"]