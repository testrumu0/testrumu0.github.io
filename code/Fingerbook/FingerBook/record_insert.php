<?php
include_once("db_connect.php");

$user_Id = '';

$dateString = date("Y-m-d", time()); //echo $dateString; //출처: https://offbyone.tistory.com/38 [쉬고 싶은 개발자]

$title= $_POST['title'];
$content = $_POST['content'];

//$link = $_POST["link"];

// $num = '';

// if($link != ""){
//     $num = substr($link, 5);
// }


if(isset($_COOKIE['user_Name'])){
    
    $user_name = $_COOKIE['user_Name'];

    $query1 = "select user_id, user_name from member where user_name='$user_name'";
    $result1 = mysqli_query($con, $query1);
    while($row = mysqli_fetch_array($result1)){
        $user_Id = $row["user_id"];
    }//받아온 id 값을 넣음
    
    if($user_Id == "" || $title == "" || $content == ""){
        echo "none";
    }else{
               $query = "insert into book_record (user_id, date, title, content) values ('$user_Id','$dateString','$title','$content')";
       
               $result = mysqli_query($con, $query);
        
               echo "<script>alert('글이 등록되었습니다');location.href='../Web/book_record.html';</script>";
    }
    

}
?>