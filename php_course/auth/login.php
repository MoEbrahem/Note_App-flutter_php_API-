
<?php

// header("Access-Control-Allow-Origin: *");
// header("Access-Control-Allow-Origin: header");
// header("Access-Control-Allow-Methods: POST, GET, OPTIONS, PUT, DELETE");
// header("Access-Control-Allow-Headers: X-Requested-With");
// header("Access-Control-Allow-Headers: Content-Type, X-Auth-Token, Origin, Authorization");

include "../connect.php";
    
$email = filterRequest("email") ;           
$password =filterRequest("password");

    
$stmt = $conn ->prepare("SELECT * FROM `users` WHERE `email`= ? AND `password`= ? ;");
// $stmt = $conn ->prepare("SELECT 'oh, hai' 
//   FROM users
//  WHERE email = $email
//    AND `password` = $password");

$stmt -> execute(array($email,$password));

$data=$stmt->fetch(PDO::FETCH_ASSOC) ;

$count = $stmt->rowCount() ;

if($count > 0){
    echo json_encode(array('status'=>"success","data"=>$data));

}else{
    echo json_encode(array('status'=>"Fail"));

}

?>
