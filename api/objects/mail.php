<?php
class Mail{
 
    // database connection and table name
    private $conn;
    private $table_name = "emails";
 
    // object properties
    public $id;
    public $user_id;
    public $from;
  //  public $to;
    public $subject;
    public $body;
    public $read;
 
    // constructor with $db as database connection
    public function __construct($db){
        $this->conn = $db;
    }
	
	 function read(){
	   //  echo $this->email;
		// select all query
		$query = "SELECT
					id,mail_to,mail_from,mail_subject,mail_body,read_status,parent_id,created,updated 
				FROM
					" . $this->table_name . " 
			    WHERE mail_to = '". $this->email ."' and deleted='0' and spam='0'		
				ORDER BY
					 created DESC";
	 
		// prepare query statement
		 // echo $query ;
		$stmt = $this->conn->prepare($query);
	 
		// execute query
		$stmt->execute();
	 
		return $stmt;
	   }
	   function readSpam(){
	   //  echo $this->email;
		// select all query
		$query = "SELECT
					id,mail_to,mail_from,mail_subject,mail_body,read_status,parent_id,created,updated 
				FROM
					" . $this->table_name . " 
			    WHERE mail_to = '". $this->email ."' and spam='1'		
				ORDER BY
					 created DESC";
	 
		// prepare query statement
		  //echo $query ;
		$stmt = $this->conn->prepare($query);
	 
		// execute query
		$stmt->execute();
	 
		return $stmt;
	   }
	   
	   
	   function sent(){
	   //  echo $this->email;
		// select all query
		$query = "SELECT
					id,mail_to,mail_from,mail_subject,mail_body,read_status,parent_id,created,updated 
				FROM
					" . $this->table_name . " 
			    WHERE mail_from = '". $this->email ."'		
				ORDER BY
					 created DESC";
		$stmt = $this->conn->prepare($query);
	 
		// execute query
		$stmt->execute();
	 
		return $stmt;
	   }
	   
	   function trash(){
	   //  echo $this->email;
		// select all query
		$query = "SELECT
					id,mail_to,mail_from,mail_subject,mail_body,read_status,parent_id,created,updated 
				FROM
					" . $this->table_name . " 
			    WHERE (mail_from = '". $this->email ."'	or 	mail_to = '". $this->email ."') AND deleted=1
				ORDER BY
					 created DESC";
		$stmt = $this->conn->prepare($query);
	 
		// execute query
		$stmt->execute();
		return $stmt;
	   }
	   
	   
	   function action(){
	    switch($this->actionItem){
			
			case "delete":{
				$query = "UPDATE " . $this->table_name . " SET deleted='1'
			    WHERE  id = '". $this->id ."' ";
		       break; 
			}
			case "spam":{
				$query = "UPDATE " . $this->table_name . " SET spam='1'
			    WHERE  id = '". $this->id ."' ";
		         break;
			}
			default:
		}
		//echo $this->actionItem;
	//	 echo $query ;
			$stmt = $this->conn->prepare($query);
	   
		        $stmt->execute();
				return $stmt;
		}
		 
	   
	 // create email
		function create(){
		 
			// query to insert record
			$query = "INSERT INTO
						 " . $this->table_name . " 
					(mail_to,mail_from,mail_subject,mail_body,read_status,parent_id )values(:mail_to,:mail_from,:mail_subject,:mail_body,:read_status,:parent_id )
						    ";
		 
			 
			$stmt = $this->conn->prepare($query);
		//  echo $this->from;
			// sanitize
			//$this->user_id=htmlspecialchars(strip_tags($this->user_id));
			$this->mail_to=htmlspecialchars(strip_tags($this->to));
			$this->mail_from=htmlspecialchars(strip_tags($this->from));
			$this->mail_subject=htmlspecialchars(strip_tags($this->subject));
			$this->mail_body=htmlspecialchars(strip_tags($this->body));
		 	$this->read_status=$this->read_status;
		 	$this->parent_id= isset($this->parent_id)? $this->parent_id:'null' ;
		 
		 
			$stmt->bindParam(":mail_to", $this->mail_to);
			$stmt->bindParam(":mail_from", $this->mail_from);
			$stmt->bindParam(":mail_subject", $this->mail_subject);
		 	$stmt->bindParam(":mail_body", $this->mail_body);
	 	 	$stmt->bindParam(":read_status", $this->read_status);
	 	 	$stmt->bindParam(":parent_id", $this->parent_id);
	//  print_r($stmt);
			// execute query
			if($stmt->execute()){
				return true;
			}
		    // print_r($stmt->errorInfo());
			return false;
			 
		}  
	   
	   
	function readOneEmail(){
		$id = $_GET["id"] ;
		$parent_id = $_GET["parent_id"] ;
		
		$update_read_flag_query="UPDATE 
				" . $this->table_name . " SET read_status='1' WHERE id= '$id'";
		
		//echo $update_read_flag_query;
		
		$update_read_flag_stmt = $this->conn->prepare($update_read_flag_query);

		$update_read_flag_stmt->execute();
		
		 
		// select main query
		$main_mail_query = "SELECT
				id,mail_to,mail_from,mail_subject,mail_body,read_status,parent_id,created,updated 
			FROM
				" . $this->table_name . " WHERE id= $id";
		
		$main_query_stmt = $this->conn->prepare($main_mail_query);

		$main_query_stmt->execute();

	    $num = $main_query_stmt->rowCount();
		$mails_arr=array();
		$mails_arr["main_record"]=array();
		$mails_arr["replay_record"]=array();
		
	   if($num>0){
          
			while ($row = $main_query_stmt->fetch(PDO::FETCH_ASSOC)){
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
					"parent_id" => $parent_id
				);

				array_push($mails_arr["main_record"], $mail_item);
				 array_push($mails_arr["replay_record"], $mail_item);
			} 
	   }
 
	//$parent_id =  $mails_arr["main_record"][0]['parent_id'];
	
	$replay_query = "SELECT
				id,mail_to,mail_from,mail_subject,mail_body,read_status,created,updated 
			FROM
				" . $this->table_name . " WHERE parent_id= $parent_id   
			ORDER BY created DESC";		 
	 
	 
	$replay_query_stmt = $this->conn->prepare($replay_query);

	$replay_query_stmt->execute();
	$num = $replay_query_stmt->rowCount();   


	if($num>0){
     

		while ($row = $replay_query_stmt->fetch(PDO::FETCH_ASSOC)){
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
				"read" => $read_status
			);

			array_push($mails_arr["replay_record"], $mail_item);
		   } 
	}
	 
	return $mails_arr;
  }
   
}