<?php

$post = file_get_contents('php://input');
$data = (json_decode($post, true));
if (
    array_key_exists('serial_no', $data) &&
    array_key_exists('crawl_url', $data) &&
    array_key_exists('keyword', $data) &&
//    array_key_exists('tracking_id', $data) &&
    array_key_exists('pages', $data)
)
    $fp = fopen('.\jsonFiles\\' . $data['serial_no'] . '.json', 'w');
fwrite($fp, json_encode($data));
fclose($fp);

$inp = file_get_contents('.\jsonFiles\\crawlList.json');

$tempArray = array();
if(json_decode($inp)!=null){
    $tempArray = json_decode($inp);
}

array_push($tempArray, $data['crawl_url'] );
$jsonData = json_encode($tempArray);
file_put_contents('.\jsonFiles\\crawlList.json', $jsonData);

$serial = $data['serial_no'];


exec("python ./crawlRunner/crawler" . $serial . ".py" , $output);


header('Content-type: application/json');
echo json_encode("JSON GENERATED");


?>