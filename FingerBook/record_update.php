<?php
include_once ("db_connect.php");

$user_Id = '';

$dateString = date("Y-m-d", time()); // echo $dateString; //출처: https://offbyone.tistory.com/38 [쉬고 싶은 개발자]

$title = $_POST['title'];
$content = $_POST['content'];

$link = $_SERVER['QUERY_STRING']; // ?num=17

$num = substr($link, 4);

//echo $num;

// echo $_SERVER['QUERY_STRING'];

if (isset($_COOKIE['user_Name'])) {

    $user_name = $_COOKIE['user_Name'];

    $query1 = "select user_id, user_name from member where user_name='$user_name'";
    $result1 = mysqli_query($con, $query1);
    while ($row = mysqli_fetch_array($result1)) {
        $user_Id = $row["user_id"];
    } // 받아온 id 값을 넣음
    

        
        if (isset($num)) { // update
            $query = "update book_record set user_id='$user_Id', date='$dateString', title='$title', content='$content' where num='$num'";
            
            $result = mysqli_query($con, $query);
            
            // echo "<script>alert('글이 수정되었습니다');</script>";
            
            
            header("Location:../Web/record_view.html?num=$num");
        }
  

    
}

?>