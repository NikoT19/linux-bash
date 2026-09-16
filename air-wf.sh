#!/bin/bash

echo "Ускоряем Wi-Fi на Chromebook..."
echo "==================================="

# Определяем Wi-Fi интерфейс
WIFI_IF=$(iw dev | awk '$1=="Interface"{print $2}')
echo "🔌 Используемый Wi-Fi интерфейс: $WIFI_IF"

# Отключаем QoS (ограничивает приоритет других клиентов)
echo "Отключаем QoS..."
sudo iw dev "$WIFI_IF" set txpower fixed 30

# Ограничиваем скорость других пользователей (устанавливаем приоритет на свою машину)
echo "Ограничиваем скорость других клиентов..."
sudo tc qdisc add dev "$WIFI_IF" root handle 1: htb default 10
sudo tc class add dev "$WIFI_IF" parent 1: classid 1:1 htb rate 50mbit
sudo tc class add dev "$WIFI_IF" parent 1:1 classid 1:10 htb rate 1mbit ceil 2mbit

echo "Теперь у тебя максимальная скорость Wi-Fi!"
