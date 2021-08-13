<?php

if(isset($_POST["action"])){

    include_once("db_connect.php");

    
    $output='
        			<table class="table_wrap" id="library_list">
						<tr class="lib_li_title">
							<th width="10%">지역</th>
							<th width="15%">기관명</th>
							<th width="15%">전화번호</th>
							<th width="25%">휴관일</th>
							<th width="12%">분류</th>
							<th width="23%">홈페이지</th>
						</tr>
    ';
    
        $s_key = $_REQUEST["s_key"];
        $s_value = $_REQUEST["s_value"];
        
        if($s_key && $s_value){
            $query = "select * from library where $s_key like '%$s_value%' order by book_id limit 10";
        }else{
            $query = "select * from library order by book_id limit 5";
        }
              
        $result = mysqli_query($con, $query);
        
        if(mysqli_num_rows($result)>0){//받아온 데이터가 있음
//             while ($row = mysqli_query($con, $query)) 
            while ($row = mysqli_fetch_array($result))  {
                $output .= '
                           <tr>
							<td>'.$row["location2"].'</td>
                            <td>'.$row["libr_name"].'</td>
                            <td>'.$row["libr_ph"].'</td>
                            <td>'.$row["libr_close"].'</td>
                            <td>'.$row["libr_type"].'</td>
                            <td>'.$row["libr_web"].'</td>
                           </tr>
                ';
            }//whileEND
            
        }//세번째if
        else{
            $output .= '<tr><td colspan="6">정보가 없습니다.</tr>';
        }
        
        $output .= '</table>';
        
        echo $output;
    
}//첫번째if
?>