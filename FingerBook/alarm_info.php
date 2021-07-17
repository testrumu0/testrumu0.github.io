<?php
include_once("db_connect.php");

$output2 = '<table id= "alarm_info">
			<tr class="pro_alarm_cont">
			 <td>독서알림</td>
			</tr>
           ';


if(isset($_COOKIE['user_Name'])){
    
    $user_name = $_COOKIE['user_Name'];
    
    $query1 = "select user_id, user_name, alarm_yn from member where user_name='$user_name'";
    $result1 = mysqli_query($con, $query1);
    while($row = mysqli_fetch_array($result1)){
        $user_Id = $row["user_id"];
        $alarm = $row["alarm_yn"];
    }//받아온 id 값을 넣음

        if($alarm == "y"){
            $query = "select * from mem_alarm where user_id='$user_Id'";
            
            $result = mysqli_query($con, $query);
            
            while($row = mysqli_fetch_array($result)){
                $output2 .= '       						
									<tr class="pro_alarm_cont" id="user_alarm">
										<td>시작</td>
									    <td><b>DATE</b>&nbsp | &nbsp'.$row["start_day"].'&nbsp&nbsp&nbsp</td>
                                        <td><b>TIME</b>&nbsp | &nbsp'.$row["start_time"].'</td>
									</tr>
									<tr class="pro_alarm_cont">
										<td>종료</td>
									    <td><b>DATE</b>&nbsp | &nbsp'.$row["end_day"].'&nbsp&nbsp&nbsp</td>
                                        <td><b>TIME</b>&nbsp | &nbsp'.$row["end_time"].'</td>
									</tr>
                             ';
            }
            
            
        }
        else if($alarm == "n"){
            $output2  .= '<tr><td>알림을 설정하세요</td></tr>';
        }

}else{
    $output2  .= '<tr><td>로그인이 필요합니다</td></tr>';
}

$output2 .= '</table>';
echo $output2;
?>