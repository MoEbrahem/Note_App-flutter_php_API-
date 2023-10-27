<?php 

$host = "mysql:host=localhost;dbname=noteapp;";

// $dbname = "noteapp";

$user = "root";

$pass = "";

//$option = array(PDO::MYSQL_ATTR_INIT_COMMAND =>"SET NAMES 'UTF8'");
//charset=utf8mb4;
try{
     $conn = new PDO("mysql:host=localhost;dbname=noteapp;charset=utf8",$user,$pass);
     //$conn= new PDO($host, $user, $pass,$option);
    
    $conn->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
    
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin");
    header("Access-Control-Allow-Methods: POST, OPTIONS , GET");
    
    include "functions.php";
    checkAuthenticate();

} 
catch(PDOException $e) {

    echo "Connection failed: " . $e->getMessage();
}
?>