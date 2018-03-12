# Audi store development env setup
# By Luis Nesi - luis.nesi@ibm.com
## ----------------------------------- START SETUP TOOLS -------------------------------- #
echo "Povision: START"

echo "Updating Kernel"
yum -y update

# ------------------------------------------------------------------------------------------ #

echo "Intalling  Common tools: START"
yum install -y yum-utils mc wget nano java-1.8.0-openjdk.x86_64 lsof epel-release
echo "Intalling  Common tools: COMPLETE"

# ------------------------------------------------------------------------------------------ #


#------------------------------------- APACHE ---------------------------------------------- #
echo "Installing Apache: START"
yum install -y httpd
systemctl enable httpd.service
systemctl start httpd.service
yum install -y openssl mod_ssl
systemctl restart httpd
echo "Installing Apache: COMPLETE"

# ------------------------------------------------------------------------------------------ #


# ---------------------------------------- MySQL ------------------------------------------- #
echo "Installing MySQL: START"
yum install -y http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
yum repolist enabled | grep "mysql.*-community.*"
yum install mysql-community-server -y
systemctl enable mysqld
systemctl start mysqld
mysql -uroot -e  "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '' WITH GRANT OPTION; FLUSH PRIVILEGES;"
systemctl restart mysqld
echo "Installing MySQL: COMPLETE"


# ------------------------------------------------------------------------------------------ #


# ------------------------------------ PHP ------------------------------------------------- #

#PHP
echo "Installing PHP: START"
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum  install -y php70w php70w-opcache
yum install -y php70w-cli php70w-devel php70w-mysqlnd php70w-pear php70w-mcrypt php70w-gd php70w-pecl-memcache php70w-pecl-memcached php70w-pecl-redis php70w-pecl-apcu php70w-soap php70w-mbstring php70w-intl php70w-bcmath
yum install -y phpunit
sed -i -r -e 's/display_errors = Off/display_errors = On/g' /etc/php.ini
sed -i -r -e 's/memory_limit = 128M/memory_limit = 512M/g' /etc/php.ini
#Composer
echo "Installing Composer"
cd /tmp
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
cd
echo "Installing PHP: COMPLETE"


# ------------------------------------------------------------------------------------------ #


# ------------------------------------- REDIS ---------------------------------------------- # 
echo "Installing Redis: START"
yum install -y redis
systemctl start redis
systemctl enable redis
echo "Installing Redis: COMPLETE"


# ------------------------------------------------------------------------------------------ #


# ------------------------------------- liquidbase ------------------------------------------#
echo "Installing Liquibase: START"
wget https://github.com/liquibase/liquibase/releases/download/liquibase-parent-3.5.5/liquibase-3.5.5-bin.tar.gz
mkdir /opt/liquibase
tar zxvf liquibase-3.5.5-bin.tar.gz -C /opt/liquibase
chmod +x /opt/liquibase/liquibase
ln -s  /opt/liquibase/liquibase /usr/local/bin/liquibase
echo "Installing Liquibase: COMPOLETE"
# ------------------------------------------------------------------------------------------ #




# ------------------------------------- USER Management FIX ------------------------------------- #
echo "User Management Setup: START"
sudo usermod -a -G apache vagrant
#FIX permision to keep simple disable selinux
sed -i 's/SELINUX=\(enforcing\|permissive\)/SELINUX=disabled/g' /etc/selinux/config
echo "User Management Setup: COMPLETE"
# ------------------------------------------------------------------------------------------ #


# ------------------------------------- CLEAN UP -------------------------------------------- #
yum clean all
rm -rf /var/cache/yum
rm -Rf /home/vagrant/*

# create magento user

echo "Povision: COMPLETE!!! :)"
## ---------------------------------- END of SETUP TOOLS ---------------------------------------- #


### ---------------------------------- SETUP ---------------------------------- #

mysql -uroot -e "CREATE DATABASE IF NOT EXISTS magento"

#EOF