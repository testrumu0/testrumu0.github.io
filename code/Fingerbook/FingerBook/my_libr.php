<?php
include_once("db_connect.php");

$output = '<table>';

$user_Id = '';

$count= 1;

$active = $_POST["is_ajax"];

//echo $active;
if(isset($_COOKIE['user_Name'])){
    
    $user_name = $_COOKIE['user_Name'];
    
    $query1 = "select user_id, user_name from member where user_name='$user_name'";
    $result1 = mysqli_query($con, $query1);
    while($row = mysqli_fetch_array($result1)){
        $user_Id = $row["user_id"];
    }//받아온 id 값을 넣음
    
//    $query = "select book_read.*, book_list.* from book_read join book_list on book_read.book_authors=book_list.authors where book_read.user_id='$user_Id'";
    
    if($active == 1){
       $query = "select book_read.*, book_list.* from book_read join book_list on book_read.isbn13=book_list.isbn13 where book_read.user_id='$user_Id'";
    }else if($active == 2){
        $query = "select book_add.*, book_list.* from book_add join book_list on book_add.isbn13=book_list.isbn13 where book_add.user_id='$user_Id'";
    }else if($active == 3){
        $query = "select book_reading.*, book_list.* from book_reading join book_list on book_reading.isbn13=book_list.isbn13 where book_reading.user_id='$user_Id'";
    }
    
    $result = mysqli_query($con, $query);
    
    while($row = mysqli_fetch_array($result)){
        if ($count%5 == 1){
            $output .= '
                            </tr>
                            <tr class ="tr_wrap">
                              <td>
                                    <table class="book_wrap" align="center">
                                        <tr>
                                        <td class="bookli_img"><a href="book_add_sub.html?isbn='.$row["isbn13"].'"><img src="'.$row["bookImageURL"].'"></a></td>
                                        </tr>
                                        <tr>
                                        <td class="bookli_title">' . $row["book_title"] . '</td>
                                        </tr>
                                        <tr>
                                        <td class="bookli_txt">
                                           '.$row["book_authors"].'
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
                                        <td class="bookli_img"><a href="book_add_sub.html?isbn='.$row["isbn13"].'"><img src="'.$row["bookImageURL"].'"></a></td>
                                        </tr>
                                        <tr>
                                        <td class="bookli_title">' . $row["book_title"] . '</td>
                                        </tr>
                                        <tr>
                                        <td class="bookli_txt">
                                          '.$row["book_authors"].'
                                        </td>
                                        </tr>
                                  </table>
                              </td>
                        ';
        }
        $count++;
    }//WHILE END
    
}

$output .= '</table>';

echo $output;



?>