/**
 * 
 */
$(function () {
	$('.tab_cont').hide();
	$('.tab_cont:first').show();
		
	$('ul.tabs li').click(function(){
		$('ul.tabs li').removeClass("active").css("color","#333");
		$(this).addClass("active").css("color", "darkred");
        $('.tab_cont').hide()
        var activeTab = $(this).attr("rel");
        $("#" + activeTab).fadeIn()		
	});
	
	function book_read(){ //다 읽은 책
		var is_ajax = 1;
		$.ajax({
			url: "../../FingerBook/my_libr.php",
			method: "POST",
			data :{is_ajax:is_ajax},
			success: function(data) {
				$("#tab1").html(data);
			}
		})//ajax
		//$('#tab1').html("<tr><td>ex1</td></tr>");
	}
	book_read();
	
	function book_add(){ //
		var is_ajax = 2;
		$.ajax({
			url: "../../FingerBook/my_libr.php",
			method: "POST",
			data :{is_ajax:is_ajax},
			success: function(data) {
				$("#tab2").html(data);
			}
		})//ajax
		//$('#tab1').html("<tr><td>ex1</td></tr>");
	}
	book_add();

	function book_reading(){ //다 읽은 책
		var is_ajax = 3;
		$.ajax({
			url: "../../FingerBook/my_libr.php",
			method: "POST",
			data :{is_ajax:is_ajax},
			success: function(data) {
				$("#tab3").html(data);
			}
		})//ajax
		//$('#tab1').html("<tr><td>ex1</td></tr>");
	}
	book_reading();
});