#!/usr/bin/env bash

# تنظیمات اولیه
PROJECT_DIR="$HOME/ImgStegano"
OUTPUT_DIR="/sdcard/DCIM/ImgStegano"

# نصب پیش‌نیازها
echo "Installing requirements..."
pkg update && pkg upgrade -y
pkg install git python python-pip figlet -y || { echo "Failed to install packages"; exit 1; }
pip install stegano || { echo "Failed to install stegano"; exit 1; }

# تنظیم دسترسی به حافظه
termux-setup-storage

# ایجاد پوشه‌ها
mkdir -p "$PROJECT_DIR"
mkdir -p "$OUTPUT_DIR"

# دانلود فایل‌های پروژه
curl -s -o "$PROJECT_DIR/img.sh" "https://raw.githubusercontent.com/Argh94/ImgStegano/main/img.sh" || { echo "Failed to download img.sh"; exit 1; }
curl -s -o "$PROJECT_DIR/img.py" "https://raw.githubusercontent.com/Argh94/ImgStegano/main/img.py" || { echo "Failed to download img.py"; exit 1; }

# تنظیم مجوزها
chmod +x "$PROJECT_DIR/img.sh"

# تنظیم alias برای اجرای سریع
if ! grep -q "alias img=" ~/.bashrc; then
    echo "alias img='bash $PROJECT_DIR/img.sh'" >> ~/.bashrc
    echo "Alias 'img' created. Run 'source ~/.bashrc' to use it."
fi

# اجرای اسکریپت اصلی
bash "$PROJECT_DIR/img.sh"
