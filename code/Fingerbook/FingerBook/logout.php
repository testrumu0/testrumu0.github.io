<?php
//logout
setcookie('user_Name', '', time()-3600, '/');

$output = '<script>history.back();</script>';

echo $output;
?>