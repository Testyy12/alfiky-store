FROM node:20-bullseye

RUN apt-get update && apt-get install -y \
    python3 \
    ffmpeg \
    git \
    imagemagick \
    tree \
    unzip \
    python3-pip \
    neofetch \
    php \
    php-cli \
    php-fpm \
    golang-go \
    default-jdk-headless \
    ca-certificates \
    fonts-liberation \
    libasound2 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libxcb1 \
    libx11-6 \
    libxext6 \
  && pip3 install speedtest-cli \
  && npm install -g pm2 playwright \
  && npx playwright install --with-deps \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Buat user non-root
RUN useradd -m -d /home/container Bagas_Alfian_Host

# Copy dan set permission entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Switch ke non-root user
USER Bagas_Alfian_Host
ENV USER=Bagas_Alfian_Host
ENV HOME=/home/container
WORKDIR /home/container

# Entrypoint
ENTRYPOINT ["/entrypoint.sh"]
