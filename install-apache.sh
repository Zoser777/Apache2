#/bin/bash
##
#Made by Z0s3r
##
#Este porgrama sirve para instalar y configurar un VirtualHost sencillo en Apache.


#Comprueba que eres root
if [ $(whoami) != "root" ]; then


	echo " --------------------------------- ";
	echo "Tienes que ser root para ejecutar este script";
	echo "Ejecuta "sudo -i" y vuelve a ejecutar el archivo";
	echo "Cuidado con lo que ejecutas";
	echo " -------------------------------- ";
	exit 1

else

	echo " ---------------------------------";
	echo " Iniciando programa ";
	echo " ---------------------------------";


fi

echo " ";
echo " ------------------------- ";
echo " Limpiando Apache corrupto ";
echo " ------------------------- ";
echo " ";


sudo apt remove apache2 -y 
sudo apt autopurge apache2 -y 

echo " ";
echo " ------------------------- ";
echo " Se ha limpiado el apache corrupto";
echo " ------------------------- ";
echo " ";

sleep 3;


#Ejecutamos un update
sudo apt update -y 

sleep 3;

echo " ";
echo " ------------------------- ";
echo " Instalando Net-tools ";
echo " ------------------------- ";
echo " ";

#Descargamos net-tools
sudo apt install net-tools -y


sleep 3;

echo " ";
echo " ------------------------- ";
echo " Instalando Apache2 ";
echo " ------------------------- ";
echo " ";


#Descargamos apache2
sudo apt install apache2 -y 



#Comprobamos status apache
sleep 2;

echo " ";
echo " ------------------------- ";

api=$(service apache2 status | grep "Active" |  cut -d ":" -f2 | cut -d " " -f3);
if [ $api == "(running)" ]
then

	echo "Apache está corriendo";

fi

echo " ------------------------- ";
echo " ";

ipred=$(hostname -I);

sleep 3;

echo " ";
echo " ------------------------- ";
echo "Tú IP de red es $ipred y la local es 127.0.0.1";
echo " ------------------------- ";
echo " ";

wget http://127.0.0.1
comp=$(ls| grep index.html);
if [ $? -eq 0 ]
then

rm index.html

sleep 3;

echo " ";
echo " ------------------------- ";
echo "En un principio, si introduces en tu navegador http://127.0.0.1";
echo "tendría que resolverte con la pagina de apache, de lo contrario ejecuta systemctl status apache2, para ver que ocurre";
echo " ------------------------- ";
echo " ";


else

echo " -------------------------- ";
echo " Comprueba el output del comando que hay arriba, que archivo está descargando o sino tiene nada";
echo " -------------------------- ";
exit 1

fi


echo " ";
echo " ------------------------- ";
read -p " Quieres que se te configure un VirtualHost sencillo?(si o no): " res ;
echo " ------------------------- ";
echo " ";

if [ $res == "si" ]
then

	echo " ";
	echo " ";
	echo " ------------------------- ";
	echo "Configurando un VirtualHost";
	echo " ------------------------- ";
	echo " ";
else

	echo " ";
	echo " ------------------------- ";
	echo " Fin del programa ";
	echo " ------------------------- ";
	echo " ";
	exit 0;
fi



# COnfiguración de un VirtualHost en apache


echo " ";
echo " ------------------------- ";
read -p " Introduce el nombre del host (sin .com): " host;
echo " ------------------------- ";
echo " ";
echo " ------------------------- ";
read -p " Seguro que quieres que sea '$host' ? (si o no): " ch;
echo " ------------------------- ";
echo " ";

sleep 3;

echo " ";
echo " ------------------------- ";


if [ $ch == "si" ]
then
	echo "Perfecto, configurando virtualhost";
else
	echo read -p "Cual es el nombre?: " host2;
	host=host2;
fi

echo " ------------------------- ";
echo " ";

echo "  ";
echo " ------------------------- ";
echo " Configurando .... ";
echo " ------------------------- ";
echo " ";
sleep 4;

sudo mkdir /var/www/$host ;
sudo chown -R $USER:$USER /var/www/$host;
sudo chmod -R 755 /var/www/$host;
sudo echo "<html><head><title> $host </title></head><body><h1>Este tu host, de nombre $host! </h1></br><h3>Recuerda que los archivos los modificas en /var/www/$host </h3></br><h3> Tu archivo de configuración está en /etc/apache/sites-available/$host.conf </h3></body></html>" > /var/www/$host/index.html;





sudo echo "<VirtualHost *:80>" > /etc/apache2/sites-available/$host.conf;
sudo echo "ServerAdmin webmaster@localhost" >> /etc/apache2/sites-available/$host.conf;
sudo echo "ServerName $host.com" >> /etc/apache2/sites-available/$host.conf;
sudo echo "ServerAlias www.$host.com" >> /etc/apache2/sites-available/$host.conf;
sudo echo "DocumentRoot /var/www/$host" >> /etc/apache2/sites-available/$host.conf;
sudo echo "ErrorLog /var/log/apache2/error.log" >> /etc/apache2/sites-available/$host.conf;
sudo echo "CustomLog /var/log/apache2/access.log combined" >> /etc/apache2/sites-available/$host.conf;
sudo echo "</VirtualHost>" >> /etc/apache2/sites-available/$host.conf;


sudo a2dissite 000-default.conf &>/dev/null;
sudo a2ensite $host.conf &>/dev/null;
sudo apache2ctl &>/dev/null;
sudo systemctl restart apache2 &>/dev/null;

if [ $? == 0 ]
then

	echo " -----------------------------";
	echo " Se ha montado el nuevo VirtualHost ";
	echo " -----------------------------";
	

	
fi


sed -i "1i 127.0.0.1	$host.com" /etc/hosts;



echo " ";
echo " --------------------------";
echo " Listo, en un principio deberias abrir una pestaña en tu navegador en incognito e introducir http://$host.com ";
echo " --------------------------";
echo " ";
