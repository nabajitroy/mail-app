<?php
// required headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
 
// get database connection
include_once '../config/database.php';
 
// instantiate product object
include_once '../objects/mail.php';
 
$database = new Database();
$db = $database->getConnection();
 
$mail = new Mail($db);

// get posted data
$data = json_decode(file_get_contents("php://input"));
// print_r($data);
//$mail->user_id = $data->user_id;
$mail->id = $data->id;
$mail->actionItem = $data->action;
 
 
// create the product
if($mail->action()){
    echo '{';
        echo '"message": "email  "   ';
    echo '}';
}
 
// if unable to create the email, tell the user
else{
    echo '{';
      echo '"message": "Unable to create product."';
     //   echo '"message":'. $data;
    echo '}';
}
?>