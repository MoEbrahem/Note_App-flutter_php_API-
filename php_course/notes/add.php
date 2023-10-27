
<?php


include "../connect.php";
    

        $title     = filterRequest("title") ;           
        $content   = filterRequest("content") ;
        $userid    = filterRequest("id");
        $imagename = imageUpload("file");


    if($imagename != 'fail')
    {
        $stmt = $conn ->prepare("INSERT INTO `notes` ( `note_title`, `note_content`, `note_image`, `note_users`) 
        VALUES ('$title', '$content', '$imagename', '$userid'); ");
     
     
        $stmt -> execute();

        $count = $stmt->rowCount();

        if($count > 0){
            echo json_encode(array('status'=>"success"));
            
        }else{
            echo json_encode(array('status'=>"Fail"));
        }
    }else{
        echo json_encode(array('status'=>"Fail"));
    }
?>
