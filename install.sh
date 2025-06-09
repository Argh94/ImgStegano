#!/usr/bin/env bash

PROJECT_DIR="$HOME/ImgStegano"
REPO_URL="https://github.com/Argh94/ImgStegano.git"

# ایجاد پوشه پروژه
mkdir -p "$PROJECT_DIR"

# دانلود فایل‌های img.sh و img.py
curl -s -o "$PROJECT_DIR/img.sh" "https://raw.githubusercontent.com/Argh94/ImgStegano/main/img.sh"
curl -s -o "$PROJECT_DIR/img.py" "https://raw.githubusercontent.com/Argh94/ImgStegano/main/img.py"

# تنظیم مجوزها
chmod +x "$PROJECT_DIR/img.sh"

# اجرای اسکریپت اصلی
bash "$PROJECT_DIR/img.sh"
