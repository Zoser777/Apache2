# Apache2

Este script sirve para instalar Apache2 y configurar (de manera opcional) un Site. 

# Uso del Script

Se debe ejecutar con permisos de superusuario. 

Hay que descargar el script "install-apache.sh" y desde la terminal, darle permisos para poder ejecutarse. ( chmod +x install-apache.sh)

# Que hace el script?

El script, de manera resumida hace lo siguiente:

  · Desisntala Apache2 (para asegurarse de que se instala Apache desde 0)
  · Instala Apache2.
  · Instala net-tools (herramineta de insterfaces inalambricas y redes del sistema)
  · Comprueba el estdo de Apache2 una vez instalado y hace una prueba con tal de comprobar que está sirviendo el archivo Index.html

  (Opcional)
  
  · Solicita al usuario si desea crear un Site y un nombre de Dominio.
  
# Conclusión

Es una herramienta que facilita y agiliza el trabajo de instalar o reinstalar Apache. Igualmente, si se va a trabajar con varios Apaches,
o es para un proyecto rapido, lo más recomendable es usar Docker, con una imagen de Apache. 
