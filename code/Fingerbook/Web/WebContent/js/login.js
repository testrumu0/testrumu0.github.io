$(document).ready(function() {
    $("#login").click(function() {
            var action = $("#login_form").attr('action');
            var form_data = {
			user_id: $("#user_id").val(),
			user_pw: $("#user_pw").val(),
            //user_id: ($("#user_id").val() == "")? alert("아이디를 입력하세요") : $("#user_id").val(),
            //user_pw: ($("#user_pw").val() == "")? alert("비밀번호를 입력하세요") : $("#user_pw").val(),
            is_ajax: 1
        };
        $.ajax({
            type: "POST",
            url: action,
            data: form_data,
            success: function(data) {	

					$("#message").html(data);
				
                /*
				if(response == 'success') {
                $("#message").html("<p style='color:green'>로그인 성공</p><br><a href='#'>홈으로 이동</a>");
                }else if(response == 'none'){
				$("#message").html("<p style='color:red'>아이디와 비밀번호를 모두 입력하세요.</p>");				
                }else {
                $("#message").html("<p style='color:red'>아이디 또는 비밀번호가 잘못되었습니다.</p>");
                }*/
            }
        });
        return false;
    });
});