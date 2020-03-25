FROM ubuntu:16.04
RUN apt update && \
  apt install openssh-server vim python3 python3-pip sudo locales -y && \
  apt clean autoclean && apt autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log} && \
  echo "root:theoryofhappiness" | chpasswd && \
  mkdir /var/run/sshd

# SSH setting
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

# Python Setting
RUN pip3 install virtualenv
WORKDIR /root
RUN virtualenv workspace && mkdir workspace/src && mkdir .pycharm_helpers && \
  /root/workspace/bin/python3 -m pip install --upgrade pip==9.0.3

# Language Setting
RUN locale-gen ko_KR.UTF-8
ENV LANG ko_KR.UTF-8
ENV LANGUAGE ko_KR:en
ENV LC_ALL ko_KR.UTF-8

ADD ["entrypoint.sh", "env_var.sh", "python_env.sh", "./"]
ENTRYPOINT ["./entrypoint.sh"]
