<?php
    include_once("db_connect.php");
    
    if(!isset($_POST['is_ajax'])) exit;
    if(!isset($_POST['user_id'])) exit;
    if(!isset($_POST['user_pw'])) exit;
    if(!isset($_POST['user_name'])) exit;
    if(!isset($_POST['user_email'])) exit;
    if(!isset($_POST['user_ph'])) exit;
    
    $is_ajax= $_POST['is_ajax'];
    $user_id = $_POST['user_id'];
    $user_pw = $_POST['user_pw'];
    $user_name = $_POST['user_name'];
    $user_email = $_POST['user_email'];
    $user_ph = $_POST['user_ph'];
    $alarm_yn = $_POST['alarm_yn'];
    
    if($user_id == "" || $user_pw == "" || $user_name == "" || $user_email == "" || $user_ph == "" || $alarm_yn == ""){
        echo "none";
    }else{
        
        $sql = "insert into member (user_id, user_pw, user_name, user_email, user_phone, alarm_yn) values ('$user_id','$user_pw','$user_name','$user_email','$user_ph','$alarm_yn')";
        
        $result = mysqli_query($con, $sql);
        
        echo "success";
    }


?>