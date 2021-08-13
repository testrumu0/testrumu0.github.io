<?php
include_once ("db_connect.php");

$user_Id = '';

$link = $_POST["link"];

$dateString = date("Y-m-d", time());

$num = '';

$output = '			<form method="post" id="record_form" action="../FingerBook/record_insert.php">
						<table class="table_wrap" >
                        <tr><th>DATE</th><td class="write_input">'.$dateString.'</td></tr>
                        <tr>
							<th>TITLE</th>
							<td class="write_input"><input type="text" id="title" name="title"
								maxlength="80"></td>
						</tr>
						<tr>
							<th>CONTENT</th>
							<td class="write_input"><textarea id="content" name="content" rows="10"></textarea></td>
						</tr>
				    </table>
						<div class="record_btn">
							<button id="add" type="submit">등록</button>
							<button id="back" type="button" value="back"
								onClick="history.back()">취소</button>
						</div>
					</form>
                ';

if ($link != "") {
    $num = substr($link, 5);
}

// echo $num;

if (isset($_COOKIE['user_Name'])) {

    $user_name = $_COOKIE['user_Name'];

    $query1 = "select user_id, user_name from member where user_name='$user_name'";
    $result1 = mysqli_query($con, $query1);
    while ($row = mysqli_fetch_array($result1)) {
        $user_Id = $row["user_id"];
    } // 받아온 id 값을 넣음

    if (isset($num)) { // num이 있음
        $query = "select * from book_record where num='$num' AND user_id='$user_Id'";
        $result = mysqli_query($con, $query);

        while ($row = mysqli_fetch_array($result)) {
            $output = '
					 <form method="post" id="record_form" action="../FingerBook/record_update.php?num='.$row["num"].'">
					   <table class="table_wrap" id="upd_table">
                        <tr><th>DATE</th><td class="write_input">' . $row["date"] . '</td></tr>
                        <tr>
							<th>TITLE</th>
							<td class="write_input"><input type="text" id="title" name="title"
								maxlength="80" value="' . $row["title"] . '"></td>
						</tr>
						<tr>
							<th>CONTENT</th>
							<td class="write_input"><textarea id="content" name="content" rows="10">' . $row["content"] . '</textarea></td>
						</tr>
						</table>
						<div class="record_btn">
							<button id="upd" type="submit">수정</button>
							<button id="back" type="button" value="back"
								onClick="history.back()">취소</button>
						</div>
					</form>
                      ';
        }
    }
} // cookie

echo $output;
?>