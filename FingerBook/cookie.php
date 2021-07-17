<?php
$output = '';

if(!isset($_COOKIE['user_Name'])){
    $output = "<li><a href='../Web/login_form.html'>LOGIN</a></li>";
}else{
    $user_name = $_COOKIE['user_Name'];
    $output = '<li>';
    $output .= $user_name;
    $output .= '님 WELCOME! <a href ="../FingerBook/logout.php">&nbspLOGOUT</a></li>';
}

echo $output;
?>