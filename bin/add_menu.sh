#!/bin/bash
#
# Modifing the main menu

# Add Categories in Menu
sed -i '/<Merge type="menus"\/>/a \\t\t<Menuname>HD Demos</Menuname>' ~/../../etc/xdg/menus/lxde-pi-applications.menu 
sed -i '/<Merge type="menus"\/>/a \\t\t<Menuname>Demos</Menuname>' ~/../../etc/xdg/menus/lxde-pi-applications.menu 
sed -i '/<Merge type="menus"\/>/a \\t\t<Separator/>' ~/../../etc/xdg/menus/lxde-pi-applications.menu 

# Add HD Demos Category
sed -i '/<\/Menu> <!-- End Other -->/a \\t\t</Menu> <!-- End HD Demos -->' ~/../../etc/xdg/menus/lxde-pi-applications.men$
sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t</Include>' ~/../../etc/xdg/menus/lxde-pi-applications.menu 
sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t\t</And>' ~/../../etc/xdg/menus/lxde-pi-applications.menu 
sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t\t\t<Category>HDDemos</Category>' ~/../../etc/xdg/menus/lxde-pi-application$
sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t\t<And>' ~/../../etc/xdg/menus/lxde-pi-applications.menu
sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t<Include>' ~/../../etc/xdg/menus/lxde-pi-applications.menu  
sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t<Directory>hd_demos.directory</Directory>' ~/../../etc/xdg/menus/lxde-pi-ap$
sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t<Name>HD Demos</Name>' ~/../../etc/xdg/menus/lxde-pi-applications.menu
sed -i '/<\/Menu> <!-- End Other -->/a \\t\t<Menu>' ~/../../etc/xdg/menus/lxde-pi-applications.menu 
sed -i '/<\/Menu> <!-- End Other -->/a \\t<!--HD Demos -->' ~/../../etc/xdg/menus/lxde-pi-applications.menu
sed -i '/<\/Menu> <!-- End Other -->/a \\t ' ~/../../etc/xdg/menus/lxde-pi-applications.menu 

# Add Demos Category
sed -i '/<\/Menu> <!-- End Other -->/a \\t\t</Menu> <!-- End Demos -->' ~/../../etc/xdg/menus/lxde-pi-applications.menu 
sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t</Include>' ~/../../etc/xdg/menus/lxde-pi-applications.menu
sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t\t</And>' ~/../../etc/xdg/menus/lxde-pi-applications.menu 
sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t\t\t<Category>Demos</Category>' ~/../../etc/xdg/menus/lxde-pi-applications.$
sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t\t<And>' ~/../../etc/xdg/menus/lxde-pi-applications.menu
sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t<Include>' ~/../../etc/xdg/menus/lxde-pi-applications.menu  
sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t<Directory>demos.directory</Directory>' ~/../../etc/xdg/menus/lxde-pi-appli$
sed -i '/<\/Menu> <!-- End Other -->/a \\t\t\t<Name>Demos</Name>' ~/../../etc/xdg/menus/lxde-pi-applications.menu
sed -i '/<\/Menu> <!-- End Other -->/a \\t\t<Menu>' ~/../../etc/xdg/menus/lxde-pi-applications.menu 
sed -i '/<\/Menu> <!-- End Other -->/a \\t<!--Demos -->' ~/../../etc/xdg/menus/lxde-pi-applications.menu 
sed -i '/<\/Menu> <!-- End Other -->/a \\t ' ~/../../etc/xdg/menus/lxde-pi-applications.menu 