<?php
include_once("db_connect.php");

$user_Id = '';
$output = '
            <tr>
				<th width="20%">NUMBER</th>
        		<th width="50%">TITLE</th>
				<th width="30%">DATE</th>				
            </tr>
        ';

if(isset($_COOKIE['user_Name'])){

    $user_name = $_COOKIE['user_Name'];
    
    $query1 = "select user_id, user_name from member where user_name='$user_name'";
    $result1 = mysqli_query($con, $query1);
    while($row = mysqli_fetch_array($result1)){
        $user_Id = $row["user_id"];
    }//받아온 id 값을 넣음
  
    $query2 = "select * from book_record where user_id='$user_Id' order by num desc";
    $result2 = mysqli_query($con, $query2);
    while($row = mysqli_fetch_array($result2)){
        $output .= '
          			   <tr>
            				<td id="num">'.$row["num"].'</td>
            				<td><a href="../Web/record_view.html?num='.$row["num"].'">'.$row["title"].'</a></td>
            				<td>'.$row["date"].'</td>
            			</tr>
                    ';
    }

    
    
}else{
    $output .= '<tr><td colspan="5">게시글이 없습니다.</td></tr>';
}

echo $output;

?>