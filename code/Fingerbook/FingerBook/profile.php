<?php
include_once("db_connect.php");

$output = '<table class="pro_txt" id="member">';

if(isset($_COOKIE['user_Name'])){
    
    $user_name = $_COOKIE['user_Name'];
    
    $query1 = "select * from member where user_name='$user_name'";
    $result1 = mysqli_query($con, $query1);
    while($row = mysqli_fetch_array($result1)){
        $user_Id = $row["user_id"];
        $email = $row["user_email"];
        $phone = $row["user_phone"];
        $alarm = $row["alarm_yn"];
          
            $output .= '
                        <tr class="pro_id">
                            <td>아이디</td>
                            <td>'.$user_Id.'</td>
                        </tr>
                        <tr class="pro_hp">
                            <td>H.P</td>
                            <td>'.$phone.'</td>
                        </tr>
                        <tr class="pro_mail">
                            <td>E-MAIL</td>
                            <td>'.$email.'</td>
                        </tr>
                      ';
        
    }//받아온 id 값을 넣음

    
  }else{//계정없을경우
      $output .= '<tr colspan="2"><td>로그인이 필요합니다</td></tr>';
}

$output .= '</table>';

echo  $output;
//echo $user_Id.'|'.$phone.'|'.$emali.'|'.$start_day.'|'.$end_day.'|'.$start_time.'|'.$end_time;


?>

