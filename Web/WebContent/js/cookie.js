/**
 * 
 */
$(document).ready(function() {
	function check_cookie() {
		$.ajax({
			url: "../../FingerBook/cookie.php",
			method: "POST",
			success: function(response) {
				$('.cookie').html(response);

			}
		})//ajax
	}
	check_cookie(); //함수호출 
});