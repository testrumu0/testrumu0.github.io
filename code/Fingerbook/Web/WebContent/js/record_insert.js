/**
 * 
 */

var link = window.location.search;


	function record_info(){
	     $.ajax({
            url: "../../FingerBook/record_info.php",
			method: "POST",
			data:{link:link},
            success: function(data) {
				$('#record_write').html(data);
            }
        });
	}

	record_info();  
  

	
	$("#add").click(function(){//insert
			var action = $("#record_form").attr('action');
            var form_data = {
			title: $("#title").val(),
			content: $("#content").val()
			}
        	$.ajax({
				type: "POST",
	            url: action,
	            data: form_data,
	            success: function(response) {
					if(response == "none"){
						alert("모든 항목을 작성해주세요");
					}
				}
			});
			
			
		});//click 
		
		$("#upd").click(function(){//update
			var action = $("#record_form").attr('action');
            var form_data = {
			title: $("#title").val(),
			content: $("#content").val(),

			}
        	$.ajax({
				type: "POST",
	            url: action,
	            data: form_data,
	            success: function(response) {
					
						if(response=="none"){
							alert("모든 항목을 작성해주세요");
						}
					
				}
			});
			
			
		});//click 
		
			
	
 		    