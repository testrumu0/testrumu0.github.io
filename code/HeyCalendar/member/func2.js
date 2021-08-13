	function valid_check(){
		
		if(document.frml.userid.value==""){
			alert("아이디를 입력해 주시기 바랍니다.");
			document.frml.userid.focus();
			return false;
		}
		if(document.frml.userid.value.length<= 3){
			alert("아이디는 3글자 이상입니다.");
			document.frml.userid.focus();
			return false;
		}
		if(document.frml.userpw.value==""){
			alert("비밀번호를 입력해 주시기 바랍니다.");
			document.frml.userpw.focus();
			return false;
		}
		if(document.frml.usernm.value==""){
			alert("이름을 입력해 주시기 바랍니다.");
			document.frml.usernm.focus();
			return false;
		}
		if(document.frml.userph.value==""){
			alert("번호를 입력해 주시기 바랍니다.");
			document.frml.userph.focus();
			return false;
		}
		document.frml.submit();
		
	}//functionEND
