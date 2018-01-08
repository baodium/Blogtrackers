<?php


session_start();

$host = "localhost";
$user = "root";
$pass = "";
$db = "anol_project";
// Create connection
$conn = new mysqli($host, $user, $pass, $db);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
$post = file_get_contents('php://input');
$data = (json_decode($post,true));

if(array_key_exists('apiKey', $data) && array_key_exists('trackingIds', $data)){
    $ids = "'".(implode('\',\'',$data['trackingIds']))."'";

    if ($data['apiKey'] == "123456789ygviykvboguy") {
        $dataSql = "select * from websites WHERE tracking_id in  (".$ids.")";
        $dataResult = mysqli_query($conn, $dataSql) or die (mysqli_error($conn));

        $totalArray=array();

        if($dataResult->num_rows>0){
            foreach ($dataResult as $row) {
                array_push($totalArray,array(
                    "progress" => $row['crawl_progress'],
                    "trackingId" => $row['tracking_id'],
                ));
            };
        }

        header('Content-type: application/json');
        echo json_encode($totalArray);

    }
}

if(array_key_exists('trackingId', $data)){
    header('Content-type: application/json');
    echo json_encode($data);
}

?>