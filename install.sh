#!/usr/bin/env bash

# تنظیمات اولیه
PROJECT_DIR="$HOME/ImgStegano"
OUTPUT_DIR="/sdcard/DCIM/ImgStegano"

# تمیز کردن حافظه موقت
echo "Cleaning temporary files..."
rm -rf /data/data/com.termux/files/usr/tmp/*

# پیکربندی مخزن Termux
echo "Configuring Termux repository..."
echo "deb https://packages.termux.dev/apt/termux-main stable main" > $PREFIX/etc/apt/sources.list
pkg update || { echo "Failed to update package lists"; exit 1; }

# نصب پیش‌نیازها
echo "Installing requirements..."
pkg upgrade -y || { echo "Failed to upgrade packages"; exit 1; }
pkg install git python python-pip figlet -y || { echo "Failed to install packages"; exit 1; }
pip install --no-build-isolation setuptools==68.2.2 || { echo "Failed to install setuptools"; exit 1; }
pip install --no-build-isolation wheel==0.43.0 || { echo "Failed to install wheel"; exit 1; }
pip install --no-build-isolation stepic==0.5.0 || { echo "Failed to install stepic"; exit 1; }

# تنظیم دسترسی به حافظه
echo "Setting up storage access..."
termux-setup-storage

# ایجاد پوشه‌ها
echo "Creating project directories..."
mkdir -p "$PROJECT_DIR"
mkdir -p "$OUTPUT_DIR"

# دانلود فایل‌های پروژه
echo "Downloading project files..."
curl -s -o "$PROJECT_DIR/img.sh" "https://raw.githubusercontent.com/Argh94/ImgStegano/main/img.sh" || { echo "Failed to download img.sh"; exit 1; }
curl -s -o "$PROJECT_DIR/img.py" "https://raw.githubusercontent.com/Argh94/ImgStegano/main/img.py" || { echo "Failed to download img.py"; exit 1; }

# تنظیم مجوزها
chmod +x "$PROJECT_DIR/img.sh"

# تنظیم alias برای اجرای سریع
if ! grep -q "alias img=" ~/.bashrc; then
    echo "alias img='bash $PROJECT_DIR/img.sh'" >> ~/.bashrc
    echo "Alias 'img' created. Run 'source ~/.bashrc' to use it."
    source ~/.bashrc
fi

# اجرای اسکریپت اصلی
echo "Starting ImgStegano..."
bash "$PROJECT_DIR/img.sh"
