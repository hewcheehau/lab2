<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];

//$str=rand(); 
//$newpass = sha1($str); 


function str_generate($chars) 
{
  $data = '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcefghijklmnopqrstuvwxyz';
  return substr(str_shuffle($data), 0, $chars);
}
$code = str_generate(6);


$sql = "UPDATE USER SET CODE='$code' WHERE EMAIL = '$email' ";
$sqls = "SELECT * FROM USER WHERE EMAIL = '$email'AND VERIFY ='1'";
$veri = $conn->query($sqls);

if($conn -> query($sql)===TRUE && $veri->num_rows>0 ){
    sendCode($email,$code);
    
echo "Code send to your email";
    
}
else{
    echo "fail to send";
}


function sendCode($useremail,$pw) {
    $to      = $useremail; 
    $subject = 'Reset password request for MyRecycle'; 
    $message = 'Your verification code:'.$pw. "\nPlease use this code for resetting your password."; 
    $headers = 'From: noreply@myrecycle.com.my' . "\r\n" . 
    'Reply-To: '.$useremail . "\r\n" . 
    'X-Mailer: PHP/' . phpversion(); 
    mail($to, $subject, $message, $headers); 
}

?>