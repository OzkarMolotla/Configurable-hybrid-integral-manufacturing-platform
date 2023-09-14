#*************************** Prototipo MASH 01 ***************************
#************* Programa de Sistema Electrónico Embebido 01 ***************
#*************************** Oscar Molotla G. ****************************
#*************************** Fecha 26/05/2022 ****************************
#S 2,T 35 ......870 70 378

#***************************Librerias****************************
from kukavarproxy import * 
from array import array
from random import random
import time
from time import sleep

robot = KUKA('172.31.2.147')
X = 0;
Y = 0;
Z = 0;

linedatos = 'datos.txt'
#***************************INICIO DE PROGRAMA****************************

while(1):
  print("Opcion 1....velocidad y corriente del spindle \n")
  print("Opcion 2....cambiar velocidad del spindle \n")
  print("Opcion 3....Mandar a HOME al robot \n")
  print("Opcion 4....Ingresar coordenada de inicio \n")
  print("Opcion 5....Realizar manufactura de cuadrado \n")
  print("Opcion 6....Realizar manufactura de circulo \n")
  print("Opcion 7....Finalizar manufactura \n")
  
  opcion = int(input("Elige una opcion: "))
  print("\n")

#******************Comunicación ESP8266 WEMOS D1 mini*********************

  if opcion == 1: 
    with open(linedatos) as f_obj:
       lines = f_obj.readlines()

    for line in lines: 
       line.rstrip()

    print("Velocidad y corriente del Spindle \r")
    print("\rRPM = ",lines[0],"Ampers = ",lines[1],"\n")

  if opcion == 2:
    vel = int(input("Ingresa la nueva velocidad del spindle: "))
    cam = int(input("Ingresa un uno para sentido horario y un cero para antihorario: \n"))
     
    with open('DatosIn.txt', 'w') as f:
      f.write(str(vel))
      f.write('\r')
      f.write(str(cam))

#********************** Comunicación Robot KUKA ************************
    
  if opcion == 3:
    print("Iniciando proceso....\n")
    robot.write("A",1)
    sleep(8)

  if opcion == 4:
      X = int(input("Infresar coordenada de inicio en X = \n"))
      Y = int(input("Ingresar coordenada de inicio en Y = \n"))
      Z = int(input("Ingresar coordenada de inicio en Z = \n"))

        
  if opcion == 5:
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

  if opcion == 6:
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

  if opcion == 7:
      print("Regresar a HOME......\n")
      robot.write("D",1)

#  else:
#      print("error \n")      
        

