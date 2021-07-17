<?php
include_once ("db_connect.php");

$link = $_REQUEST['link'];

$isbn = substr($link, 6); // isbn만 추출



// echo $isbn;

$url = "http://data4library.kr/api/srchDtlList";
$url .= "?authKey=de3c0337f18ffb84f21f7446a6193558f5e1de37b57505bd6883db5abdb7b6cd";
// $url .= "&searchDt=2020-11-20"; //실시간 급상승 도서
$url .= "&isbn13=$isbn"; // 추출한 isbn
$url .= "&format=json";

$ch = curl_init();

curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
$response = curl_exec($ch);
if (! $response) {
    exit("Error #" . curl_errno($ch) . ": " . curl_error($ch));
}

$data = json_decode($response, TRUE); // JSON -> PHP Array
                                      // print_r($php_array); // 가장 보기 쉽게 표시

// 출력할 값을 변수에 저장
$img = '<img src="' . $data['response']['detail'][0]['book']['bookImageURL'] . '">';
$bookname = $data['response']['detail'][0]['book']['bookname'];
$authors = $data['response']['detail'][0]['book']['authors'];
$description = $data['response']['detail'][0]['book']['description'];
$class = $data['response']['detail'][0]['book']['class_no'];

// class_no 앞자리만 추출하여 분야 출력
$class_fno = substr($class, 0, 1);
$book_class = '';
switch ($class_fno) {
    case 1:
        $book_class = "철학";
        break;
    case 2:
        $book_class = "종교";
        break;
    case 3:
    case 4:
    case 5:
        $book_class = "과학";
        break;
    case 6:
        $book_class = "예술";
        break;
    case 7:
        $book_class = "언어";
        break;
    case 8:
        $book_class = "문학";
        break;
    case 9:
        $book_class = "역사";
        break;
}


$output = '
       <tr>
            <td class="book_img">' . $img . '</td>
            <td class="book_cont">
                <table class="b_cont_wrap">
                    <tr class="b_title"><td>' . $bookname . '</td></tr>
                    <tr class="b_info"><td>기본정보<br>' . $authors . ' | ISBN ' . $isbn . '</td></tr>
                    <tr class="b_cat"><td>주제분류 <br>' . $book_class . '</td></tr>
                    <tr class="b_story"><td><p>' . $description . '</p></td></tr>
					<tr class="b_btn">
						<td>
							<button class="btn1" onclick="myDiaryAdd();">나의 서재에 추가</button>
							<button class="btn2" onclick="myDiaryReading();">책갈피에 추가</button>
						</td>
					</tr>
				</table>
			</td>
	   </tr>
        
        ';

echo $output;

curl_close($ch);


?>