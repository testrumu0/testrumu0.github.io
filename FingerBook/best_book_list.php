<?php

include_once("db_connect.php");

$output='<div class="swiper-slide"><ul>';

$count= 1;

$query = "select * from best_book order by rank_no limit 0, 10";
$result = mysqli_query($con, $query);

while($row = mysqli_fetch_array($result)){
    if ($count == 6){
        $output .= '
                    </ul>
    				</div>
    				<div class="swiper-slide">
    						<ul>
    							<li>
                                <a href="book_add_sub.html?isbn='.$row["isbn13"].'"><img src="'.$row["bookImageURL"].'"></a>
                                <p><b>' . $row["bookname"] . '</b><br>'.$row["authors"].'<br>'.$row["publisher"].'</p>
                                </li>
                                               
                        ';
    }else{
        $output .= '
    							<li>
                                <a href="book_add_sub.html?isbn='.$row["isbn13"].'"><img src="'.$row["bookImageURL"].'"></a>
                                <p><b>' . $row["bookname"] . '</b><br>'.$row["authors"].'<br>'.$row["publisher"].'</p>
                                </li>

                      ';
    }
    $count++;
}//WHILE END
$output .= '</ul></div>';

echo $output;


?>