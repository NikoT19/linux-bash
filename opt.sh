#!/bin/bash

echo "Оптимизация Chromebook..."
echo "==================================="

# Освобождение кеша памяти
echo "Очищаем кеш..."
sync; echo 3 | sudo tee /proc/sys/vm/drop_caches

# Завершаем ненужные процессы (Google Drive, Chrome Helper и др.)
echo "Завершаем ненужные фоновые процессы..."
killall -q drivefs
killall -q google-chrome
killall -q "chrome"

# Отключаем анимации системы (ускорение интерфейса)
echo "Отключаем анимации..."
gsettings set org.gnome.desktop.interface enable-animations false

# Уменьшаем нагрузку на CPU (ограничиваем частоту процессора)
echo "🌡 Ограничиваем нагрузку на процессор..."
sudo cpufreq-set -g powersave

# Отключаем автообновление Chrome OS (чтобы избежать тормозов)
echo "Отключаем автообновление..."
sudo stop update-engine

echo "Оптимизация завершена! Chromebook работает быстрее 🚀"
