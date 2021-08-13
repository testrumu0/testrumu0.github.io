<?php
include_once ("db_connect.php");

$output = '<table>';
$count= 1;

if (isset($_POST["action"])) {

    $s_key = $_REQUEST["s_key"];
    $s_value = $_REQUEST["s_value"];


    if($s_key && $s_value) {
        $query = "select * from book_list where $s_key like '%$s_value%' order by no";
    }else{
        $query = "select * from book_list order by no limit 0, 15";
    }
    

    $result = mysqli_query($con, $query);
    
    if(mysqli_num_rows($result)>0){//받아온 데이터가 있음
    while($row = mysqli_fetch_array($result)){
        $isbn13 = $row["isbn13"];
        $isbn = substr($isbn13, 1);
        if ($count%5 == 1){
            $output .= '
                            </tr>
                            <tr class ="tr_wrap">
                              <td>
                                    <table class="book_wrap" align="center">
                                        <tr>
                                        <td class="bookli_img"><a href="book_add_sub.html?isbn='.$isbn.'"><img src="'.$row["bookImageURL"].'"></a></td>
                                        </tr>
                                        <tr>
                                        <td class="bookli_title">' . $row["bookname"] . '</td>
                                        </tr>
                                        <tr>
                                        <td class="bookli_txt">
                                           '.$row["authors"].' | '.$row["publisher"].'
                                        </td>
                                        </tr>
                                  </table>
                              </td>
                                               
                        ';
        }else{
            $output .= '
                               <td>
                                    <table class="book_wrap" align="center">
                                        <tr>
                                        <td class="bookli_img"><a href="book_add_sub.html?isbn="'.$isbn.'"><img src="'.$row["bookImageURL"].'"></a></td>
                                        </tr>
                                        <tr>
                                        <td class="bookli_title">' . $row["bookname"] . '</td>
                                        </tr>
                                        <tr>
                                        <td class="bookli_txt">
                                           '.$row["authors"].' | '.$row["publisher"].'
                                        </td>
                                        </tr>
                                  </table>
                              </td>
                        ';
        }
        $count++;
    }//WHILE END
    }else{
        $output .= '<tr><td colspan="5">검색하신 정보를 찾을 수 없습니다.</tr>';
    }
    $output .= '</table>';
    echo $output;
   
}

?>