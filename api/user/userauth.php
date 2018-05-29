<?php 
 
/**
 * Description: User authentication
 
 */
 header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
//include database connection file
include_once '../config/database.php';
 
$database = new Database();
$db = $database->getConnection();
 
$stmt = $db->prepare("SELECT id,email,password,full_name from  users WHERE 
email='".$_POST['username']."' && password='".   $_POST['password'] ."'");
 
$stmt->execute();
 
$row = $stmt->rowCount();
  $user_arr=array();
  $user_arr["records"]=array();
if ($row > 0){    
    
	
	while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
        // extract row
        // this will make $row['name'] to
        // just $name only
        extract($row);
 
        $user_item=array(
            "full_name" => $full_name,
            "email" => $email,
            "id" => $id,
			"status" =>"correct"
            
        );
 
        array_push($user_arr["records"], $user_item);
    }
 
	
} else{ 

    $user_item=array(
            "full_name" => null,
            "email" => null,
            "id" => null,
			"status" =>"wrong"
            
        );
    array_push($user_arr["records"], $user_item);

     
}
 echo json_encode($user_item);
?>