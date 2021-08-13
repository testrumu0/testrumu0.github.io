<?php
include_once("db_connect.php");

$s_date =  $_POST['start_date'];
$e_date = $_POST['end_date'];
$s_time = $_POST['start_time'];
$e_time = $_POST['end_time'];

//echo $s_date.$e_date.$s_time.$e_time;

if(isset($_COOKIE['user_Name'])){
    
    $user_name = $_COOKIE['user_Name'];
    
    $query1 = "select user_id, user_name, alarm_yn from member where user_name='$user_name'";
    $result1 = mysqli_query($con, $query1);
    while($row = mysqli_fetch_array($result1)){
        $user_Id = $row["user_id"];
        $alarm = $row["alarm_yn"];
    }//받아온 id 값을 넣음
    
    if($alarm == "y"){
        $query = "insert into mem_alarm values ('$user_Id','$s_date','$e_date','$s_time','$e_time')";
        
        $result = mysqli_query($con, $query);
        
        
        //header("Location:../Web/book_alarm.html");
        echo 'success';
        
    }else{
        
        //header("Location:../Web/book_alarm.html");
        echo 'false';
    }
    
}


?>