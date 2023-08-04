from pprint import pprint
import os
import shutil


xampp_release = "xampp-8.2.4"
xampp_control = "xampp-control"


curr = os.path.dirname(__file__)
removed_dir = os.path.join(curr, "removed")


def move(srcpath, destpath):
    remove(destpath)
    print("Move:", srcpath, "to", destpath)
    shutil.move(srcpath, destpath)


def copy(srcpath, destpath):
    remove(destpath)
    print("Copy:", srcpath, "to", destpath)
    if os.path.isdir(srcpath):
        shutil.copytree(srcpath, destpath)
    else:
        shutil.copy(srcpath, destpath)


def remove(path):
    print("Remove:", path)
    if os.path.exists(path):
        if os.path.isdir(path):
            shutil.rmtree(path)
        else:
            os.unlink(path)

        
#
#
# XAMPP
#
#
xampp_dir = os.path.join(curr, xampp_release)
files = [file for file in os.listdir(xampp_dir)]
# pprint(files)

to_keep = [
    'apache',
    'apache_start.bat',
    'apache_stop.bat',
    # 'catalina_service.bat',
    # 'catalina_start.bat',
    # 'catalina_stop.bat',
    # 'cgi-bin',
    # 'contrib',
    # 'FileZillaFTP',
    'htdocs',
    'install',
    # 'licenses',
    'locale',
    # 'MercuryMail',
    'mysql',
    'mysql_start.bat',
    'mysql_stop.bat',
    'passwords.txt',
    # 'perl',
    'php',
    'phpMyAdmin',
    'readme_de.txt',
    'readme_en.txt',
    # 'sendmail',
    'setup_xampp.bat',
    'test_php.bat',
    'tmp',
    # 'tomcat',
    # 'webalizer',
    # 'webdav',
    # 'xampp-control.exe',
    # 'xampp-control.ini',
    'xampp_start.exe',
    'xampp_stop.exe'
]
for file in os.listdir(xampp_dir):
    if file in to_keep:
        continue
    filepath = os.path.join(xampp_dir, file)
    destpath = os.path.join(removed_dir, file)
    move(filepath, destpath)


#
#
# xampp-control-panel
#
#
xampp_control_dir = os.path.join(curr, xampp_control)
to_copy = [
    "xampp_control3.exe",
    "xampp_control3.ini",
    "xampp_control3.log",
    "locale"
]
for file in to_copy:
    filepath = os.path.join(xampp_control_dir, file)
    destpath = os.path.join(xampp_dir, file)
    copy(filepath, destpath)


#
#
# php-ext
#
#
ext_src_dir = os.path.join(curr, 'php-ext')
ext_dest_dir = os.path.join(xampp_dir, 'php', "ext")
for file in os.listdir(ext_src_dir):
    srcpath = os.path.join(ext_src_dir, file)
    destpath = os.path.join(ext_dest_dir, file)
    copy(srcpath, destpath)


#
#
# htdocs
#
#
htdocs_src_dir = os.path.join(curr, 'htdocs')
htdocs_dest_dir = os.path.join(xampp_dir, 'htdocs')

for file in os.listdir(htdocs_dest_dir):
    remove(os.path.join(htdocs_dest_dir, file))

for file in os.listdir(htdocs_src_dir):
    srcpath = os.path.join(htdocs_src_dir, file)
    destpath = os.path.join(htdocs_dest_dir, file)
    copy(srcpath, destpath)


#
#
# dbdump
#
#
dbdump_src_dir = os.path.join(curr, 'dbdump')
dbdump_dest_dir = os.path.join(xampp_dir, 'dbdump')
copy(dbdump_src_dir, dbdump_dest_dir)


#
#
# config files
#
#
config_files = {
    'httpd-xampp.conf': os.path.join(xampp_dir, 'apache', 'conf', 'extra', 'httpd-xampp.conf')
}
config_src_dir = os.path.join(curr, 'config')
for file, dest_path in config_files.items():
    config_src_path = os.path.join(config_src_dir, file)
    config_dest_path = dest_path
    copy(config_src_path, config_dest_path)