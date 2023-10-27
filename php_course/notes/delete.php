
<?php


include "../connect.php";
    
     $noteid    = filterRequest("id");
     $imagename = filterRequest("imagename");

    
     $stmt = $conn ->prepare("DELETE FROM `notes` WHERE `note_id` = $noteid");
     $stmt->execute();

     $count = $stmt->rowCount();

     if($count > 0){
         delete_image("../upload", $imagename);
         echo json_encode(array('status'=>"success"));

     }else{
         echo json_encode(array('status'=>"Fail"));

     }
  
?>
