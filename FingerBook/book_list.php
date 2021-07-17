<?php

include_once("db_connect.php");

$output1='<table>';

$count= 1;

$query = "select * from book_list order by no limit 0, 15";
$result = mysqli_query($con, $query);

while($row = mysqli_fetch_array($result)){
//     $isbn13 = substr($row["isbn13"],1);
    $isbn13 = $row["isbn13"];
    if ($count%5 == 1){
            $output1 .= '
                            </tr>
                            <tr class ="tr_wrap">
                              <td>
                                    <table class="book_wrap" align="center">
                                        <tr>
                                        <td class="bookli_img"><a href="book_add_sub.html?isbn='.$isbn13.'"><img src="'.$row["bookImageURL"].'"></a></td>
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
            $output1 .= '
                               <td>
                                    <table class="book_wrap" align="center">
                                        <tr>
                                        <td class="bookli_img"><a href="book_add_sub.html?isbn='.$isbn13.'"><img src="'.$row["bookImageURL"].'"></a></td>
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
$output1 .= '</table>';

echo $output1;


?>