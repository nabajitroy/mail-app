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
$mail->to = $data->to;
$mail->from = $data->from;
$mail->subject = $data->subject;
$mail->body = $data->body;
$mail->read_status = 0;
 
$mail->parent_id = $data->parent_id;	
 
//$mail->created = date('Y-m-d H:i:s');
//$mail->updated = date('Y-m-d H:i:s');
 
// create the product
if($mail->create()){
    echo '{';
        echo '"message": "Product was created."';
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