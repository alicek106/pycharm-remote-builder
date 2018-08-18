FROM ubuntu:16.04
RUN apt update && \
  apt install openssh-server vim python3 python3-pip sudo -y && \
  echo "root:theoryofhappiness" | chpasswd && \
  mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN pip3 install virtualenv
WORKDIR /root
RUN virtualenv workspace && mkdir workspace/src && mkdir .pycharm_helpers && \ 
  /root/workspace/bin/python3 -m pip install --upgrade pip==9.0.3

ADD ["entrypoint.sh", "env_var.sh", "python_env.sh", "./"]
ENTRYPOINT ["./entrypoint.sh"]
