
<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Origin: header");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS, PUT, DELETE");
header("Access-Control-Allow-Headers: X-Requested-With");
header("Access-Control-Allow-Headers: Content-Type, X-Auth-Token, Origin, Authorization");

include "../connect.php";
    

        $email = filterRequest("email") ;           
        $username =filterRequest("username") ;
        $password =filterRequest("password");

    
     $stmt = $conn ->prepare("INSERT INTO `users` ( `username`, `email`, `password`) 
     VALUES ('$username', '$email', '$password'); 
     ");
     $stmt -> execute();

     $count = $stmt->rowCount();

     if($count > 0){
         echo json_encode(array('status'=>"success"));

     }else{
         echo json_encode(array('status'=>"Fail"));

     }
  
?>
