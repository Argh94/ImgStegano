from stegano import lsb
import os
import sys
import time
import datetime

dt = datetime.datetime.now()
new_img = f"{dt.year}{dt.strftime('%m')}{dt.day}_{dt.hour}{dt.minute}{dt.second}.png"

def ensure_folder():
    try:
        os.makedirs('/sdcard/DCIM/ImgStegano', exist_ok=True)
    except Exception as e:
        print(f"Error creating folder: {e}")
        sys.exit(1)

def hide():
    try:
        input('Press Enter to choose Image File: ')
        os.system('termux-storage-get image.png')
        time.sleep(2)
        while not os.path.isfile('image.png'):
            print("Image Loading Error. Trying Again...")
            time.sleep(2)
            os.system('termux-storage-get image.png')
        msg = input("Enter Message: ")
        lsb.hide('image.png', msg).save(new_img)
        print("Message Hidden Successfully! Moving to Gallery...")
        os.system(f"mv {new_img} /sdcard/DCIM/ImgStegano")
        os.system('rm -f image.png')
    except Exception as e:
        print(f"Error: {e}")
    input("Press Enter to continue...")

def reveal():
    try:
        input('Press Enter to choose Image File: ')
        os.system('termux-storage-get Emaze.png')
        time.sleep(2)
        while not os.path.isfile('Emaze.png'):
            print("Image Loading Error. Trying Again...")
            time.sleep(2)
            os.system('termux-storage-get Emaze.png')
        msg = lsb.reveal('Emaze.png')
        print("Hidden Message:", msg)
        os.system('rm -f Emaze.png')
    except Exception as e:
        print(f"Error: {e}")
    input("Press Enter to continue...")

if __name__ == "__main__":
    ensure_folder()
    if len(sys.argv) > 1:
        if...

Something went wrong, please refresh to reconnect or try again.
