<?php

include_once('dbconnect.php');
$email= $_POST['email'];
$code = $_POST['code'];

$sql = "SELECT * FROM USER WHERE CODE='$code' AND EMAIL = '$email'";
$result = $conn->query($sql);

if($result->num_rows>0){
    
    echo "code verified";
}
else {
    
    echo"invalid code";
}