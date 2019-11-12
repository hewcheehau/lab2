<?php
include_once('dbconnect.php');
    
$email = $_POST['email'];
$password = sha1($_POST['password']);

$sql = "UPDATE USER SET CODE= '0', PASSWORD='$password' WHERE EMAIL='$email'";

if($conn->query($sql)===TRUE){
    
    echo 'Passwords changed';
}
else{
    
    echo 'Failed to change password';
}


?>