<?php
// required headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
 
// include database and object files
include_once '../config/database.php';
include_once '../objects/mail.php';
 
// instantiate database and product object
$database = new Database();
$db = $database->getConnection();
 
// initialize object
$mail = new Mail($db);
 
// query products
$mail->email =  $_GET['email'];
$stmt = $mail->sent();
$num = $stmt->rowCount();
$data = json_decode(file_get_contents("php://input")); 

// check if more than 0 record found
if($num>0){
 
    // products array
    $mails_arr=array();
    $mails_arr["records"]=array();
 
    // retrieve our table contents
    // fetch() is faster than fetchAll()
    // http://stackoverflow.com/questions/2770630/pdofetchall-vs-pdofetch-in-a-loop
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
        // extract row
        // this will make $row['name'] to
        // just $name only
        extract($row);
 
        $mail_item=array(
            "id" => $id,
            "to" => $mail_to,
            "from" => $mail_from,
            "subject" => $mail_subject,
            "body" => html_entity_decode($mail_body),
            "created" => $created,
            "updated" => $updated,
            "read" => $read_status,
            "parent_id" => $parent_id,
        );
 
        array_push($mails_arr["records"], $mail_item);
    }
 
    echo json_encode($mails_arr);
}
 
else{
    echo json_encode(
        array("message" => "No products found.")
    );
}
?>