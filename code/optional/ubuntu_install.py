################################################################################
# Description:
#   Script to install some packages/apps later of main installation by individual way
#
################################################################################
# Autor: Frank Junior <frankcbjunior@gmail.com>
# Desde: 02-10-2020
################################################################################

import os

# menu lib doc: https://pypi.org/project/simple-term-menu/
from simple_term_menu import TerminalMenu

def main():
  # link: http://patorjk.com/software/taag/#p=display&c=bash&f=Slant&t=Ubuntu%20Install
  header = """
   __  ____                __           ____           __        ____
  / / / / /_  __  ______  / /___  __   /  _/___  _____/ /_____ _/ / /
 / / / / __ \/ / / / __ \/ __/ / / /   / // __ \/ ___/ __/ __ `/ / /
/ /_/ / /_/ / /_/ / / / / /_/ /_/ /  _/ // / / (__  ) /_/ /_/ / / /
\____/_.___/\__,_/_/ /_/\__/\__,_/  /___/_/ /_/____/\__/\__,_/_/_/
                                        Developed by Frank Junior
"""
  # package list
  menu_items_package = [
    "Telegram", "Transmission", "Postman", "VirtualBox-6.1", "Docker"
    ]

  # menu config
  separator = "========================================================="
  title = "PACKAGE MENU".center(len(separator))
  main_menu_title = separator + "\n" + title + "\n" + separator

  main_menu_cursor = ">> "
  main_menu_cursor_style = ("fg_green", "bold")
  main_menu_style = ("bg_gray", "fg_black")
  main_menu = TerminalMenu(menu_entries=menu_items_package,
                            title=main_menu_title,
                            menu_cursor=main_menu_cursor,
                            menu_cursor_style=main_menu_cursor_style,
                            menu_highlight_style=main_menu_style,
                            cycle_cursor=True)

  # show header
  os.system("clear")
  print(header)

  # show menu
  selected_item = main_menu.show()

  # selection handle
  if selected_item != None:
    package = menu_items_package[selected_item]

    command = None
    if os.path.isfile(f"{package}/installer.yaml"):
      command = f"ansible-playbook --ask-become-pass {package}/installer.yaml"
    elif os.path.isfile(f"{package}/installer.sh"):
      command = f"sudo ./{package}/installer.sh"

    # execute selected package installer
    if command != None:
      os.system(command)

if __name__ == "__main__":
    main()
