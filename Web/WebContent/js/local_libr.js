$(document).ready(function() {
	$('#action').click(function() { //검색버튼 클릭 시 실행
		var s_key = $('#s_key').val();
		var s_value = $('#s_value').val();
		var action = $('#action').text();

		$.ajax({
			url: "../../FingerBook/search.php",
			method: "POST",
			data: { s_key: s_key, s_value: s_value, action: action },
			success: function(data) {
				$('#library_list').html(data); //성공시 실행 테이블 변경
			}
		})//ajax_search

	});//clickfunction					

});//전체function