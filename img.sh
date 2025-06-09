#!/usr/bin/env bash

# تنظیمات اولیه
PROJECT_DIR="$HOME/ImgStegano"
REPO_URL="https://github.com/Argh94/ImgStegano.git"
UPDATE_FILE="$PROJECT_DIR/update.flag"
OUTPUT_DIR="/sdcard/DCIM/ImgStegano"

# تابع بررسی و آپدیت پروژه
update_project() {
    echo "Checking for updates..."
    if [ -d "$PROJECT_DIR/.git" ]; then
        cd "$PROJECT_DIR"
        git pull origin main || { echo "Failed to update project"; exit 1; }
        echo "Project updated."
    else
        echo "Cloning project..."
        git clone "$REPO_URL" "$PROJECT_DIR" || { echo "Failed to clone project"; exit 1; }
        cd "$PROJECT_DIR"
    fi
    touch "$UPDATE_FILE"
}

# تابع حذف پروژه
delete_project() {
    echo "Are you sure you want to delete the project? (y/n)"
    read confirm
    if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
        rm -rf "$PROJECT_DIR"
        rm -rf "$OUTPUT_DIR"
        sed -i '/alias img=/d' ~/.bashrc
        echo "Project deleted. Alias removed."
        exit 0
    else
        echo "Deletion canceled."
    fi
}

# تابع نمایش منو
show_menu() {
    clear
    if command -v figlet >/dev/null 2>&1; then
        figlet -f slant "ImgStegano"
    else
        echo "ImgStegano"
    fi
    echo "Welcome to ImgStegano!"
    echo "1. Hide Text in Image"
    echo "2. Reveal Text from Image"
    echo "3. Delete Project and Exit"
    echo "Enter your choice (1-3):"
    read choice
    case $choice in
        1) cd "$PROJECT_DIR" && python3 img.py hide ;;
        2) cd "$PROJECT_DIR" && python3 img.py reveal ;;
        3) delete_project ;;
        *) echo "Invalid choice. Press Enter to try again..."; read; show_menu ;;
    esac
}

# بررسی نصب اولیه
if [ ! -f "$UPDATE_FILE" ]; then
    update_project
fi

# اجرای منو
cd "$PROJECT_DIR"
show_menu
