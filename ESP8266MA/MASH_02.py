#*************************** Prototipo MASH 02 ***************************
#************* Programa de Sistema Electrónico Embebido 02 ***************
#******************Manufactura aditiva prototipo 00***********************
#*************************** Oscar Molotla G. ****************************
#*************************** Fecha 29/12/2022 ****************************
#S 2,T 35 ......870 70 378

#***************************Librerias****************************
#from kukavarproxy import * 
from array import array
from random import random
import time
from time import sleep

#robot = KUKA('172.31.2.147')
X = 0;
Y = 0;
Z = 0;
tem = 200;
ext = 4;

linedatos = 'datos.txt'
#***************************INICIO DE PROGRAMA****************************

while(1):
  print("Opcion 1....Temperatuta y error del control PID en el sensor \n")
  print("Opcion 2....Cambiar temperatura de referencia \n")
  print("Opcion 3....Activar extrucsión \n")
  print("Opcion 4....Mandar a HOME al robot \n")
  print("Opcion 5....Ingresar coordenada de inicio \n")
  print("Opcion 6....Realizar manufactura de cuadrado \n")
  print("Opcion 7....Realizar manufactura de circulo \n")
  print("Opcion 8....Finalizar manufactura \n")
  
  opcion = int(input("Elige una opcion: "))
  print("\n")

#******************Comunicación ESP8266 WEMOS D1 mini*********************

  if opcion == 1: 
    with open(linedatos) as f_obj:
       lines = f_obj.readlines()

    for line in lines: 
       line.rstrip()

    print("Temperatura y error del control PID en el sensor \r")
    print("\rCentígrados = ",lines[0],"Error = ",lines[1],"\n")

  if opcion == 2:
    tem = int(input("Ingresa la nueva temperatura de referencia: "))
    #cam = int(input("Ingresa un uno para extrusión y un cero para retracción: \n"))
     
    with open('Datosentrada.txt', 'w') as f:
      f.write(str(tem))
      f.write(str(ext))
      f.write(str(opcion))
      f.write('\r')

  if opcion == 3:
    #vel = int(input("Ingresa la nueva temperatura de referencia: "))
    ext = int(input("Ingresa uno para extrusión y cero para retracción: \n"))
     
    with open('Datosentrada.txt', 'w') as f:
      f.write(str(tem))
      f.write(str(ext))
      f.write(str(opcion))
      f.write('\r')

#********************** Comunicación Robot KUKA ************************
    
  if opcion == 4:
    print("Iniciando proceso....\n")
    robot.write("A",1)
    sleep(2)

  if opcion == 5:
      X = int(input("Infresar coordenada de inicio en X = \n"))
      Y = int(input("Ingresar coordenada de inicio en Y = \n"))
      Z = int(input("Ingresar coordenada de inicio en Z = \n"))

        
  if opcion == 6:
      print ("Realizando manufactura de cuadrado....\n")
      print ("Posicion en x", X,"mm")
      print ("Posicion en y", Y,"mm")
      print ("Posicion en Z", Z,"mm ......")  #350
      sleep(2)
      robot.write("INTERCONEXION.X",X)
      robot.write("INTERCONEXION.Y",Y)
      robot.write("INTERCONEXION.Z",Z)
      sleep(2)
      robot.write("B",1)
      sleep(2)
      print("......\n")

  if opcion == 7:
      print ("Realizando manufactura de circulo....\n")
      print ("Posicion en x", X,"mm")
      print ("Posicion en y", Y,"mm")
      print ("Posicion en Z", Z,"mm ......")  #350
      sleep(2)
      robot.write("INTERCONEXION.X",X)
      robot.write("INTERCONEXION.Y",Y)
      robot.write("INTERCONEXION.Z",Z)
      sleep(2)
      robot.write("C",1)
      sleep(2)
      print("......\n")

  if opcion == 8:
      print("Regresar a HOME......\n")
      robot.write("D",1)
