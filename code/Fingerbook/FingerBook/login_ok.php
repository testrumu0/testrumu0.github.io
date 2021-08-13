<?php 
    include_once("db_connect.php");

    if(!isset($_POST['is_ajax'])) exit;
    if(!isset($_POST['user_id'])) exit;
    if(!isset($_POST['user_pw'])) exit;
    
    $is_ajax=$_POST['is_ajax'];
    $user_id = $_POST['user_id'];
    $user_pw = $_POST['user_pw'];
    
    $output = '';
    
    if($user_id == "" || $user_pw == ""){
        $output = "<p style='color:red'>아이디와 비밀번호를 모두 입력하세요.</p>";
    }else{
        
        
        $query = "select * from member where user_id='$user_id' AND user_pw='$user_pw'";
        
        $result = mysqli_query($con, $query);
        
        $count = mysqli_num_rows($result);
        
        $members = mysqli_fetch_array($result,MYSQLI_ASSOC);
        
        if($count == 1){//받아온 값이 있으면
            setcookie('user_Name',$members['user_name'],time()+3600,'/');
            
            echo "<script>location.href='../Web/main.html';</script>";

            
        }else{
            $output = "<p style='color:red'>아이디 또는 비밀번호가 잘못되었습니다.</p>";
        }
        
    }//else
    echo $output;

?>