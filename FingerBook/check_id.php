<?php
    include_once("db_connect.php");
    
    if(!isset($_POST['check_id'])) exit;
      
    $check_id = $_POST['check_id'];
    
    $sql = "select * from member where user_id='$check_id'";
    
    $result = mysqli_query($con, $sql);
    
    $count = mysqli_num_rows($result);
    
    if($count > 0){
        echo "overlap";
    }else{
        echo "check";
    }


?>