
	function valid_check(){
		
		if(document.frm1.userid.value==""){
			alert("아이디를 입력해 주시기 바랍니다.");
			document.frm1.userid.focus();
			return false;
		}

		if(document.frm1.usernm.value==""){
			alert("이름을 입력해 주시기 바랍니다.");
			document.frm1.usernm.focus();
			return false;
		}
		if(document.frm1.passwd.value==""){
			alert("비밀번호를 입력해 주시기 바랍니다.");
			document.frm1.passwd.focus();
			return false;
		}
		if(document.frm1.passwd2.value==""){
			alert("비밀번호확인을 입력해 주시기 바랍니다.");
			document.frm1.passwd2.focus();
			return false;
		}
		if(document.frm1.passwd.value != document.frm1.passwd2.value){
			alert("비밀번호를 확인해 주시기 바랍니다.");
			document.frm1.passwd.focus();
			return false;
		}
		if(document.frm1.jumin1.value.length != 6){
			alert("주민번호 앞 자릿수는 6자입니다.");
			document.frm1.jumin1.focus();
			return false;
		}
		if(document.frm1.jumin2.value.length != 7){
			alert("주민번호 앞 자릿수는 7자입니다.");
			document.frm1.jumin2.focus();
			return false;
		}
		document.frm1.submit();
/*		for(var i=0; i<document.frm1.jumin1.value.length; i++){
			if(document.frm1.jumin1.value.charAt(i)<"0" || document.frm1.jumin1.value.charAt(i)>"9"){
				alert("주민번호는 숫자만 가능합니다.");
			    document.frm1.jumin1.focus();
			    return false;
			}
		}
		for(var i=0; i<document.frm1.jumin2.value.length; i++){
			if(document.frm1.jumin2.value.charAt(i)<"0" || document.frm1.jumin2.value.charAt(i)>"9"){
				alert("주민번호는 숫자만 가능합니다.");
			    document.frm1.jumin2.focus();
			    return false;
			}
		}
*/		
	}
	
	function KeyNumber(){
		var event_key = event.keyCode;
		
		if( (event_key<48 ||event_key>57) && (event_key !=8 && event_key !=46) ) {
			event.returnValue=false;
		}		
	}
	function cursor_move(a){
		if(a==1){
			var str = document.frm1.jumin1.value.length;
			if(str==6)
				document.frm1.jumin2.focus();
		}else if(a==2){
			var str = document.frm1.jumin2.value.length;
			if(str==7)
				document.frm1.mailrcv.focus();
		}
	}
