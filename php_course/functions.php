<?php 


define('MB',1048576);
function filterRequest($requestname){
    
    return htmlspecialchars(strip_tags($_POST[$requestname]));
    
}


function imageUpload($imageRequest){
    global $error ;
    $imagename = rand(1000,10000).$_FILES[$imageRequest]['name'];
    $imagetmp  = $_FILES[$imageRequest]['tmp_name'];
    $imagesize = $_FILES[$imageRequest]['size'] ;

    $allowExt  = array('png','jpg','gif','pdf');
    $strtoarr  = explode('.',$imagename);
    $ext       = end($strtoarr);
    $ext       = strtolower($ext);

    if(!empty($imagename) && !in_array($ext ,$allowExt))
    {
        $error[] = 'Ext';
    }
    if($imagesize > 3*MB)
    {
        $error[]= 'Size Error';
    }
  if(empty($error))
  {
      move_uploaded_file($imagetmp , '../upload/' . $imagename);
      return $imagename ;

  }else{
      return 'Fail image';
      // print_r($error);
  }
}

function delete_image($dir,$imagename){
    if(file_exists($dir . "/" . $imagename)){
        unlink($dir . "/". $imagename);
    }
}

function checkAuthenticate(){
    if (isset($_SERVER['PHP_AUTH_USER'])  && isset($_SERVER['PHP_AUTH_PW'])) {

        if ($_SERVER['PHP_AUTH_USER'] != "Mohamed" ||  $_SERVER['PHP_AUTH_PW'] != "M.I472001M.I"){
            header('WWW-Authenticate: Basic realm="My Realm"');
            header('HTTP/1.0 401 Unauthorized');
            echo 'Page Not Found';
            exit;
        }
    } else {
        exit;
    }
}




?>