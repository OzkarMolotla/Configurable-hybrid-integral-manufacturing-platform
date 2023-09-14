<?php
     //Crea un archivo de texto para guardar los datos que envíara el ESP8266
     if (!file_exists("datos.txt")){
         // si no existe el archivo, lo creamos
         file_put_contents("datos.txt", "0.0\r\n0.0"); 
     }

     // Si se recibe datos con el método GET, los procesamos 
     if (isset($_GET['CON']) && isset($_GET['INC'])){
         $var3 = $_GET['CON'];
         $var4 = $_GET['INC'];
         $fileContent = $var3 . "\r\n" . $var4;
         $fileSave = file_put_contents("datos.txt", $fileContent);
     }

     //Leemos los datos del archivo para guardarlos en variables 
     $fileStr = file_get_contents("datos.txt");
     $pos1 = strpos($fileStr, "\r\n");
     $var1 = substr($fileStr, 0, $pos1);
     $var2 = substr($fileStr, $pos1 + 1); // de la pos1 +1 hasta el final
      
     //Leemos los datos del archivo para guardarlos en variables 
     $fileStr = file_get_contents("Datosentrada.txt");
     $pos2 = strpos($fileStr, "\r");
     $var3 = substr($fileStr, 0, 3);
     //$pos3 = strpos($fileStr, 3, 3);    
     $var4 = substr($fileStr, 3, 1);
     $var5 = substr($fileStr, 4, 1); 
     $var6 = substr($fileStr, 5, 1);
     echo "REF-1";
     echo "$var3,";
     echo "$var4,";
     echo "$var5,";
     echo "$var6";
     // dormir durante 1 segundo
     sleep(2);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="refresh" content="1">
    <title>EJEMPLO</title>
    
</head> 
    <style>
        h1{
            color:antiquewhite;
            background-color: dodgerblue;
            text-align: center;    
        }
    </style>
<body>
    <header>
          <h1>Servidor local para Manufactura Aditiva</h1>
    </header>
    
    <section>
        <h3> Temperatura del Hotend en grados centigrados: <?php echo $var1; ?>° </h3>
        <h3> Error del control PID de temperatura: <?php echo $var2; ?></h3>   
        <h3> Nueva referencia de temperatura: <?php echo $var3; ?>°</h3>
        <h3> Extruir o retraer filamento: <?php echo $var4; ?></h3> 
    </section>     
</body>    
</html>    