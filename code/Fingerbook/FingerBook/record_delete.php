<?php
include_once("db_connect.php");

$user_Id = '';

$link = $_SERVER['QUERY_STRING']; // ?num=17

$num = substr($link, 4);

//echo $num;

if (isset($_COOKIE['user_Name'])) {
    
    $user_name = $_COOKIE['user_Name'];
    
    $query1 = "select user_id, user_name from member where user_name='$user_name'";
    $result1 = mysqli_query($con, $query1);
    while ($row = mysqli_fetch_array($result1)) {
        $user_Id = $row["user_id"];
    } // 받아온 id 값을 넣음
    
    if (isset($num)) { // update
        $query = "delete from book_record where num='$num' AND user_id='$user_Id'";
        
        $result = mysqli_query($con, $query);
        
        echo "<script>alert('글이 삭제되었습니다');</script>";
        header("Location:../Web/book_record.html");
    }
} 