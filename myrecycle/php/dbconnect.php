<?php
$servername = "localhost";
$username ="lawlieta_myrecycleuser";
$password = "hew0176161885cc";
$dbname ="lawlieta_myrecycle";

$conn = new mysqli($servername,$username,$password,$dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}


?>