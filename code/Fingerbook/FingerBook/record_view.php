<?php
include_once("db_connect.php");

$user_Id = '';

$output ='<table class="table_wrap">';

$link= $_POST['link'];

$num = substr($link, 5);

//echo $num;

if(isset($_COOKIE['user_Name'])){
    
    $user_name = $_COOKIE['user_Name'];
    
    $query1 = "select user_id, user_name from member where user_name='$user_name'";
    $result1 = mysqli_query($con, $query1);
    while($row = mysqli_fetch_array($result1)){
        $user_Id = $row["user_id"];
    }//받아온 id 값을 넣음

    $query = "select * from book_record where num='$num' AND user_id='$user_Id'";
    $result = mysqli_query($con, $query);
    while($row = mysqli_fetch_array($result)){
        $output .= '
                        <tr><th>DATE</th><td>'.$row["date"].'</td></tr>
                        <tr><th>TITLE</th><td>'.$row["title"].'</td></tr>
                        <tr><th>CONTENT</th><td>'.$row["content"].'</td></tr>
                     </table>
                     <div class="record_btn">
                          <a href="book_record.html"><button id="back" type="button">목록</button></a>
                          <a href="record_write.html?num='.$row["num"].'"><button id="upd" type="button">수정</button></a>
                          <a href="../../FingerBook/record_delete.php?num='.$row["num"].'"><button id="del" type="button">삭제</button></a>
                     </div>
                    ';
    }
    
}

echo $output;
?>