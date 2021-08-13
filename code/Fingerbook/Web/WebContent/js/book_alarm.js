/**
 * 
 */
$(document).ready(function() {//프로필 영역 출력
	function profile(){
	        $.ajax({           
            url: "../../FingerBook/profile.php",
			method: "POST",
            success: function(data) {
				$('#member').html(data);	
            }
        });
	}
	profile();
	
	function alarm_info(){//독서알림 정보 출력
	        $.ajax({           
            url: "../../FingerBook/alarm_info.php",
			method: "POST",
            success: function(data) {
				$('#alarm_info').html(data);	
            }
        });
	}
	alarm_info();
	
	
    $("#submit_btn").click(function() {//알림 정보 저장
            var action = $("#alarm_pick").attr('action');//alarm_insert.php
            var form_data = {
				start_date : $("#start_date").val(),
				end_date : $("#end_date").val(),
				start_time : $("#start_time").val(),
				end_time : $("#end_time").val()          
        };                                             
        $.ajax({
            type: "POST",
            url: action,
            data: form_data,
            success: function(response) {
						//alert(response);	
					if(response =='success'){
						alert("알림이 성공적으로 설정되었습니다");
						location.reload();
					}else if(response == 'false'){
						alert("실패");
						location.reload();
					}
            }
        });
        
    });
});

