FROM itherz/webapp-tiny:a7

RUN  apk update && \
     apk add openssh sudo nodejs && \
     rc-update add sshd sysinit && \
     umask 002 && \
     sed -i 's/#PubkeyAuthentication.*/PubkeyAuthentication yes/ig' /etc/ssh/sshd_config && \
     sed -i 's/#RSAAuthentication.*/RSAAuthentication yes/ig' /etc/ssh/sshd_config && \
     npm install -g bower

ADD 03-apply_key.start /etc/local.d

VOLUME /var/www/html

EXPOSE 22 9000
