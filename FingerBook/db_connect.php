<?php
    $con = mysqli_connect('localhost','root','0000','book_info');
    if(!$con){
        die("ERROR:".mysqli_error($con));
    }
?>