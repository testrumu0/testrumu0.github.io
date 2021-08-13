/**
 * 
 */
var link = window.location.search; //url파라미터값 가져와서 isbn정보 보내기

$(document).ready(function(){
		function bestbook_list() {
		$.ajax({
			url: "../../FingerBook/best_book_list.php",
			method: "POST",
			success: function(data) {
				$('#best_book_list').html(data);
			}
		})//ajax
	}//bestbook
	
	function recommendbook_list() {
		$.ajax({
			url: "../../FingerBook/recommend_book_list.php",
			method: "POST",
			success: function(data) {
				$('#recommend_book_list').html(data);
			}
		})//ajax
	}//recommendbook
	
		function new_recommend_list() {
		$.ajax({
			url: "../../FingerBook/new_recommend_list.php",
			method: "POST",
			success: function(data) {
				$('#new_recommend_list').html(data);
			}
		})//ajax
	}//recommendbook

	bestbook_list();
	recommendbook_list();
	new_recommend_list();
});