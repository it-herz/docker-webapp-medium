FROM itherz/webapp-tiny:a7

RUN  apk update && \
     apk add openssh sudo nodejs rsync git curl && \
     rc-update add sshd sysinit && \
     umask 002 && \
     sed -i 's/#PubkeyAuthentication.*/PubkeyAuthentication yes/ig' /etc/ssh/sshd_config && \
     sed -i 's/#RSAAuthentication.*/RSAAuthentication yes/ig' /etc/ssh/sshd_config && \
     npm install -g bower && \
     # Dirty hack to share envs for ssh
     sed -i '1s/^/mkdir -p \/var\/www\/html\/.ssh \&\& env | grep _ >> \/var\/www\/html\/.ssh\/environment\n/' /root/rc && \
     sed -i 's/#\(PermitUserEnvironment\) no/\1 yes/g' /etc/ssh/sshd_config

ADD 03-apply_key.start /etc/local.d/

VOLUME /var/www/html

EXPOSE 22 9000
