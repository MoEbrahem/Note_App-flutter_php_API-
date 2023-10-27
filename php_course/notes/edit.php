
<?php


include "../connect.php";


        $noteid     = filterRequest("id") ;           
        $content    = filterRequest("content") ;
        $title      = filterRequest("title");
        $imagename  = filterRequest("imagename");

        if(isset($_FILES['file']))
        {
            delete_image('../upload',$imagename);
            
            $imagename=imageUpload("file");
         
        }
    
            $stmt = $conn ->prepare("UPDATE `notes` 
            SET `note_title`='$title',`note_content`='$content' ,`note_image` = '$imagename'
            WHERE `note_id`='$noteid';" );
            $stmt->execute();
            $count = $stmt->rowCount();
            

            if($count > 0){
                echo json_encode(array('status'=>"success"));

            }else{
                echo json_encode(array('status'=>"Fail"));

            }
  
?>
