<?php
    $servername = "127.0.0.1";
    $username = "root";
    $passeword = "";
    $dbname = "erp";
    
    header('Conrent-Type: application/json');
    header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Methods: POST, OPTIONS");
    
    // create connection
    $conn = mysqli_connect($servername, $username, $passeword, $dbname);

    // get sql command and fire sql query

     $sql = $_POST["command"];

     $queryResult = mysqli_query($conn,$sql);

    // assign the result to an array then return it
    $result = array();
    while($row = mysqli_fetch_assoc($queryResult)){
        array_push($result, $row);
    }
    echo json_encode($result);
?> 