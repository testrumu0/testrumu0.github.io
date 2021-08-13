/**
 * 독서기록게시판에 DB추가
 */
$(document).ready(function() {
	function record_list() {
		$.ajax({
			url: "../../FingerBook/record_list.php",
			method: "POST",
			success: function(data) {
				$('#record_list').html(data);
			}
		})//ajax
	}

	record_list();
	
});
