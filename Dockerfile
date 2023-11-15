FROM ubuntu:latest

# Instal paket-paket yang diperlukan
RUN apt-get update && \
    apt-get install -y \
        qemu-system-x86 \
        sudo \
        nano \
        curl \
        systemd \
        iputils-ping \
        net-tools \
        openssh-server \
        supervisor && \
    rm -rf /var/lib/apt/lists/*

# apt install systemctl && apt install ufw (Install ini ketika sudah didalam terminal)
# apt upgrade && apt update
# anda bisa menambahkan instalasi package secara manual / bisa by script Dockerfile

# Buat direktori yang diperlukan untuk SSH
RUN mkdir /var/run/sshd

# Copy berkas kunci publik ke dalam kontainer
COPY id_rsa.pub /root/.ssh/authorized_keys

# Set permission untuk berkas authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

# Copy file konfigurasi Supervisor
COPY supervisord.conf /etc/supervisor/supervisord.conf

# CMD yang akan dijalankan saat kontainer dijalankan
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
