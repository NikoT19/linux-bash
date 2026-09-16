#!/bin/bash

echo "📡 Проверка интернет-соединения..."
echo "======================================="

# Проверка доступности интернета
ping -c 2 8.8.8.8 &>/dev/null && echo " Интернет доступен" || echo " Нет соединения"

# Локальный IP-адрес
echo "Локальный IP: $(hostname -I | awk '{print $1}')"

# Внешний IP-адрес
echo "🛰 Внешний IP: $(curl -s ifconfig.me)"

# Сетевые интерфейсы
echo "🔌 Активные сетевые интерфейсы:"
ip -br addr show | grep UP

# Информация о шлюзе
echo "🛜 Шлюз по умолчанию: $(ip r | grep default | awk '{print $3}')"

# DNS сервера
echo "🛜 DNS сервера:"
cat /etc/resolv.conf | grep nameserver

# Проверка скорости пинга
echo "Проверка скорости пинга (Google)..."
ping -c 3 google.com

echo "======================================="

echo "Подключенные устройства к Wi-Fi:"
arp -a | grep -v "incomplete"

echo "======================================="

echo "Анализ трафика пользователей..."
echo "(Требуются права администратора)"
sudo iftop -P -n -t -s 5
