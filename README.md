# Configurable-hybrid-integral-manufacturing-platform
 Configurable  hybrid integral manufacturing platform: subtractive-additive process with industrial robot arm, proof of concept results.
 
![DiagramaSis_04](https://github.com/OzkarMolotla/Configurable-hybrid-integral-manufacturing-platform/assets/145061621/7da5e037-9c11-45d6-b842-1670383b37c3)

Recursos y documentación extra para el proyecto “Configurable  hybrid integral manufacturing platform: 
subtractive-additive process with industrial robot arm, proof of concept results”. El código está 
organizado por el tipo de programa utilizado en cada uno de los sistemas, que forman parte de la plataforma.

1.-DriverMA_01 y DriverMs_01, en MicroC pro for PIC:

      i.- DriverMA_01.mcpds programa cargado en el dsPIc para el módulo aditivo.
      ii.- Prueba_00.mcpds  programa cargado en el dsPIc para el módulo sustractivo.

![SEE_MA](https://github.com/OzkarMolotla/Configurable-hybrid-integral-manufacturing-platform/assets/145061621/75116db0-5443-4c7d-8031-19c97d6c63f5)

2.-ESP8266_MA y ESP8266_MS, programas implementados en el IDE de arduino

      i.- ESP8862_MA programa cargado en el ESP8266 para establecer tanto la comunicación 
          con dsPIC como con la página web para el módulo aditivo.
      ii.- ESP8862_MA programa cargado en el ESP8266 para establecer tanto la comunicación 
           con dsPIC como con la página web para el módulo sustractivo. 


3.- ESP8266MA, programas implementados en el Python, HTML y PHP, para modulo aditivo.

     i.- MASH_02 programa desarrollado en Python, donde se genera la interfaz de usuario,
         se estable la comunicación con la página web y se genera la interconexión con el robot KUKA. 
     i.- indexMA.php programa desarrollado en HTML y PHP, donde se genera la página web  
         dinámica. 

4.- ESP8266MS, programas implementados en el Python, HTML y PHP, para el módulo sustractivo.

     i.- MASH programa desarrollado en Python, donde se genera la interfaz de usuario, 
         se estable la comunicación con la página web y se genera la interconexión con 
         el robot KUKA. 
     ii.- index.php programa desarrollado en HTML y PHP, donde se genera la página web dinámica.      

5.- interconexion.src, programa implementado en el SMARTPAD de robot KUKA, que logra    
     establecer la interconexión con la interfaz generada en python y realizar la siguiente toma de  
     decisiones 

    i.- Mandar a home al robot
    2.- Hacer el llamado al programa de manufactura sustractiva 
    3.- Hacer el llamado al programa de manufactura aditiva 
    4.- Terminar los procesos de manufactura 

6.- CIRCULO10X10_00.src, Programa de manufactura aditiva generado a través del software Robotmaster, donde se
    establecen la configuración final de parámetros de manufactura y en Mastercam se genera el diseño de la 
    pieza a desarrollar. 

![PruebaConcepto_05](https://github.com/OzkarMolotla/Configurable-hybrid-integral-manufacturing-platform/assets/145061621/f66030af-1156-4e62-94fd-032c5cd69603)
![DiseñoMA_01](https://github.com/OzkarMolotla/Configurable-hybrid-integral-manufacturing-platform/assets/145061621/a98f0792-5311-4012-82d1-7c8b5fd0ed0f)

7.- CIRCULO10X10_00.src, Programa de manufactura sustractiva generado a través del software Robotmaster, donde se
    establecen la configuración final de parámetros de manufactura y en Mastercam se genera el diseño de la pieza
    a desarrollar.
    
![PruebaConcepto_10](https://github.com/OzkarMolotla/Configurable-hybrid-integral-manufacturing-platform/assets/145061621/3c09c28b-2f9c-4116-b6b4-c728fb69ab29)

