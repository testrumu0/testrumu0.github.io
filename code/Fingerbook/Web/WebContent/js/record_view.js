/**
 * 
 */
 var link = window.location.search;

//alert(link);?num=1
 function record_view(){
	     $.ajax({
            url: "../../FingerBook/record_view.php",
			method: "POST",
			data: {link:link},
            success: function(data) {
				$('#record_view').html(data);
            }
        });
	}

	record_view();

/*$("#upd").click(function(){
        	$.ajax({
	            url: "../../FingerBook/record_update.php",
				method: "POST",
	            data: {link:link},
	            success: function(response) {
					if(response == "none"){
						alert("모든 항목을 작성해주세요");
					}
				}
			});
});*/