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

  # packages config, with package name and installation type
  menu_items = [
    {"app": "Telegram", "installer_type": "ansible"},
    {"app": "Transmission", "installer_type": "shell"},
    {"app": "Postman", "installer_type": "ansible"},
    {"app": "VirtualBox-6.1", "installer_type": "ansible"},
    {"app": "Docker", "installer_type": "ansible"}
  ]

  # get menu list itens
  menu_items_package = []
  for items in menu_items:
    menu_items_package.append(items["app"])

  # menu config
  main_menu_title = """=========================================================
                PACKAGE MENU
========================================================="""
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
    package = menu_items[selected_item]["app"]
    installer_type = menu_items[selected_item]["installer_type"]

    if installer_type == "ansible":
      command = f"ansible-playbook {package}/installer.yaml"
    elif installer_type == "shell":
      command = f"./{package}/installer.sh"

    # execute selected package installer
    os.system(command)

if __name__ == "__main__":
    main()
