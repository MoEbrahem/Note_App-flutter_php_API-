
<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Origin: header");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS, PUT, DELETE");
header("Access-Control-Allow-Headers: X-Requested-With");
header("Access-Control-Allow-Headers: Content-Type, X-Auth-Token, Origin, Authorization");


include "../connect.php";
    

        $userid = filterRequest("id") ;           

    
     $stmt = $conn ->prepare("SELECT * FROM `notes` WHERE `note_users` = '$userid' ;"); 
     $stmt -> execute();
     $data=$stmt->fetchAll(PDO::FETCH_ASSOC);

     $count = $stmt->rowCount();

     if($count > 0){
         echo json_encode(array('status'=>"success","data"=>$data));

     }else{
         echo json_encode(array('status'=>"Fail"));

     }
  
?>
