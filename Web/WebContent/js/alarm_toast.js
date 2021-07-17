/**
 * 
 */
$(document).ready(function(){
	$.ajax({           
            url: "../../FingerBook/alarm_info.php",
			method: "POST",
            success: function(data) {
				$('#alarm').html(data);							
            }
        });//ajax

$('#alarm').fadeIn(400).delay(7000).fadeOut(400); //fade out after 7 seconds

});