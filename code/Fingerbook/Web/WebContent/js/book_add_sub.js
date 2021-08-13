/**
 * 
 */
var link = window.location.search; //url파라미터값 가져와서 isbn정보 보내기
//alert(link);

$.ajax({
	url: "../../FingerBook/book_add_sub.php",
	method: "POST",
	data: { link: link },
	success: function(response) {
		$('#book_sub_info').html(response);
	}
})//ajax


function myDiaryAdd() { //나의서재 추가한책 book_add DB에 입력
	var is_ajax=1;
	$.ajax({
		url: "../FingerBook/my_libr_add.php",
		method: "POST",
		data: { is_ajax:is_ajax, link: link },
		success: function(response){
			if(response == "success"){
				alert("나의 서재에 추가되었습니다")
			}else if(response == "none"){
				alert("서비스 준비중입니다");
			}
		}
	})//ajax
}

function myDiaryReading() { //나의서재 책갈피 book_reading DB에 입력
	var is_ajax=2;
	$.ajax({
		url: "../FingerBook/my_libr_add.php",
		method: "POST",
		data: { is_ajax:is_ajax, link: link },
		success: function(response){
			if(response == "success"){
				alert("나의 책갈피에 추가되었습니다")
			}else if(response == "none"){
				alert("서비스 준비중입니다");
			}
		}
	})//ajax
}