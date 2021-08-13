<?php
include_once ("db_connect.php");

$link = $_REQUEST['link'];
//echo $link;//?isbn=%209788972756194

$isbn = substr($link, 9); // isbn만 추출
//echo $isbn;

$active = $_POST["is_ajax"]; //추가에 들어갈건지 책갈피에 들어갈건지 구분

$user_Id = '';

$book_title ='';
$book_authors = '';

if(isset($_COOKIE['user_Name'])){

    $user_name = $_COOKIE['user_Name'];

    $query1 = "select user_id, user_name from member where user_name='$user_name'";
    $result1 = mysqli_query($con, $query1);
    while($row = mysqli_fetch_array($result1)){
        $user_Id = $row["user_id"];
    }//받아온 id 값을 넣음

    $query2 = "select bookname, authors, isbn13 from book_list where isbn13 LIKE '%$isbn%'";
    $result2 = mysqli_query($con, $query2);
    while($row = mysqli_fetch_array($result2)){
        $book_title = $row["bookname"];
        $book_authors = $row["authors"];
    }
    
    if($user_Id == "" || $book_title == "" || $book_authors == "" || $isbn == ""){
        echo "none";
    }else{
        if($active == 1){//isbn 앞공백필수 1은 추가한책에 추가 2는 책갈피에 추가
            $query = "insert into book_add (user_id, isbn13, book_title, book_authors) values ('$user_Id',' $isbn','$book_title','$book_authors')";
        }else if($active == 2){
            $query = "insert into book_reading (user_id, isbn13, book_title, book_authors) values ('$user_Id',' $isbn','$book_title','$book_authors')";
        }
        
        $result = mysqli_query($con, $query);
        
        echo "success";
    }
    //echo $book_title;
   }




?>