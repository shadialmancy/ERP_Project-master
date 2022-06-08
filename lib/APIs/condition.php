<?php

// API file to send data from the application to the Database server
$servername = "127.0.0.1";
$username = "root";
$passeword = "";
$dbname = "erp";

header('Conrent-Type: application/json');
header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");

// create connection
$conn = new mysqli($servername, $username, $passeword, $dbname);

$sql = "$_POST["command"]";

$result = mysqli_query($conn,$sql);
$count = mysqli_num_rows($result);

if($count == 1){
    echo json_encode('Success');
}else{
    echo json_encode('Error');
}

?>