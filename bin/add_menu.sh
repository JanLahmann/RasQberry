#!/bin/bash
#
# Modifing the main menu

# Add Categories in Menu
sudo sed -i '/<Merge type="menus"\/>/a \\t\t<Menuname>HD Demos</Menuname>' ~/../../etc/xdg/menus/lxde-pi-applications.menu 
sudo sed -i '/<Merge type="menus"\/>/a \\t\t<Menuname>Demos</Menuname>' ~/../../etc/xdg/menus/lxde-pi-applications.menu 
sudo sed -i '/<Merge type="menus"\/>/a \\t\t<Separator/>' ~/../../etc/xdg/menus/lxde-pi-applications.menu 

# Add HD Demos Category
sudo sed -i '/<\/Menu> <!-- End Other -->/a \\t\t</Menu> <!-- End HD Demos -->' ~/../../etc/xdg/menus/lxde-pi-applications.men$
sudo sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t</Include>' ~/../../etc/xdg/menus/lxde-pi-applications.menu 
sudo sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t\t</And>' ~/../../etc/xdg/menus/lxde-pi-applications.menu 
sudo sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t\t\t<Category>HDDemos</Category>' ~/../../etc/xdg/menus/lxde-pi-application$
sudo sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t\t<And>' ~/../../etc/xdg/menus/lxde-pi-applications.menu
sudo sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t<Include>' ~/../../etc/xdg/menus/lxde-pi-applications.menu  
sudo sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t<Directory>hd_demos.directory</Directory>' ~/../../etc/xdg/menus/lxde-pi-ap$
sudo sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t<Name>HD Demos</Name>' ~/../../etc/xdg/menus/lxde-pi-applications.menu
sudo sed -i '/<\/Menu> <!-- End Other -->/a \\t\t<Menu>' ~/../../etc/xdg/menus/lxde-pi-applications.menu 
sudo sed -i '/<\/Menu> <!-- End Other -->/a \\t<!--HD Demos -->' ~/../../etc/xdg/menus/lxde-pi-applications.menu
sudo sed -i '/<\/Menu> <!-- End Other -->/a \\t ' ~/../../etc/xdg/menus/lxde-pi-applications.menu 

# Add Demos Category
sudo sed -i '/<\/Menu> <!-- End Other -->/a \\t\t</Menu> <!-- End Demos -->' ~/../../etc/xdg/menus/lxde-pi-applications.menu 
sudo sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t</Include>' ~/../../etc/xdg/menus/lxde-pi-applications.menu
sudo sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t\t</And>' ~/../../etc/xdg/menus/lxde-pi-applications.menu 
sudo sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t\t\t<Category>Demos</Category>' ~/../../etc/xdg/menus/lxde-pi-applications.$
sudo sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t\t<And>' ~/../../etc/xdg/menus/lxde-pi-applications.menu
sudo sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t<Include>' ~/../../etc/xdg/menus/lxde-pi-applications.menu  
sudo sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t<Directory>demos.directory</Directory>' ~/../../etc/xdg/menus/lxde-pi-appli$
sudo sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t<Name>Demos</Name>' ~/../../etc/xdg/menus/lxde-pi-applications.menu
sudo sed -i '/<\/Menu> <!-- End Other -->/a \\t\t<Menu>' ~/../../etc/xdg/menus/lxde-pi-applications.menu 
sudo sed -i '/<\/Menu> <!-- End Other -->/a \\t<!--Demos -->' ~/../../etc/xdg/menus/lxde-pi-applications.menu 
sudo sed -i '/<\/Menu> <!-- End Other -->/a \\t ' ~/../../etc/xdg/menus/lxde-pi-applications.menu 