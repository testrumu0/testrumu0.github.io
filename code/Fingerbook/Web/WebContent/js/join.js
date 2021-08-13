$(document).ready(function() {
    $("#join_us").click(function() {
            var action = $("#join_form").attr('action');
            var form_data = {
            user_id: $("#user_id").val(),
            user_pw: $("#user_pw").val(),
            user_name: $("#user_name").val(),
            user_email: $("#user_email").val(),
            user_ph: $("#user_ph").val(),
			alarm_yn: $('input[name="alarm_chk"]:checked').val(),
            is_ajax: 1
        };
        $.ajax({
            type: "POST",
            url: action,
            data: form_data,
            success: function(response) {
                if(response == 'success') {
                $("#message").html("<p style='color:green'>가입 성공</p><br><a href='login_form.html'>로그인화면으로 이동</a>");
                }else if(response == 'none'){
				$("#message").html("<p style='color:red'>모든 항목을 입력하세요.</p>");				
                }else {
                $("#message").html("<p style='color:red'>오류</p>");
                }
            }
        });
        return false;
    });

	$("#check_id").click(function(){
		var check_id = ($("#user_id").val() == "")? alert("아이디를 입력하세요") : $("#user_id").val();
		$.ajax({
			type : "POST",
			url :  "../../FingerBook/check_id.php",
			data : {check_id:check_id},
			success : function(response){
				if(response == 'check'){
					$("#message").html("<p style='color:green'>사용할 수 있는 아이디입니다.</p>");
				}else if(response == 'overlap'){
                	$("#message").html("<p style='color:red'>이미 존재하는 아이디입니다.</p>");
                }else{
					$("#message").html("<p style='color:red'>아이디 체크 오류.</p>");
				}
			}
		});
		return false;
	});
});