/**도서추가페이지 도서검색 */
$(document).ready(function() {
	function booklist() { //북 리스트 받아오기 페이지네이션 없음
		$.ajax({
			url: "../../FingerBook/book_list.php",
			method: "POST",
			success: function(data) {
				$('#add_book_list').html(data);
			}
		})//ajax
		if ($('#action') != "") {
			$('#action').click(function() { //검색버튼 클릭 시 실행
				var s_key = $('#s_key').val();
				var s_value = $('#s_value').val();
				var action = $('#action').text();

				$.ajax({
					url: "../../FingerBook/search_book.php",
					method: "POST",
					data: { s_key: s_key, s_value: s_value, action: action },
					success: function(data) {
						$('#add_book_list').html(data); //성공시 실행 테이블 변경
					}
				})//ajax_search

			});//clickfunction	
		}
	}//booklist

	booklist(); //함수호출


});//전체function