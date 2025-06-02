$(function(){
	
	$("#btnUserAddFrm").click(function(){
		location.href='user_account_add_frm.jsp'
	}) // click
	
	$("#btnUserAdd").click(function(){
		chkNull();
	}) // click
	
	$("#btnUserEdit").click(function(){
		
	}) // click
	
	$("#btnUserDelete").click(function(){
		
	}) // click
	
	$("#btnUserBack").click(function(){
		location.href='user_account_list.jsp'
	}) // click

	function preventNavigation(event) {
		// 이벤트가 발생한 대상이 체크박스인지 확인
		if (event.target.type === 'checkbox') {
			event.stopPropagation();  // 부모의 클릭 이벤트가 발생하지 않도록 방지
		} //end if
	} //preventNavigation

	function chkNull(){
    	var name = $("#name").val();
		var email = $("#email").val();
		var pass = $("#pass").val();
		var passchk = $("#passchk").val();
		
    	if( name.trim() == "" || name.trim() == null ){
    		alert("이름은 필수로 입력해주세요.");
			// early return
			return;
    	} else {
			alert("이름 : "+name);
		} // end if
		
		if( email.trim() == "" || email.trim() == null ){
			alert("이메일은 필수로 입력해주세요.");
			// early return
			return;
		} else {
			alert("이메일 : "+email);
		} // end if
		
		if( pass.trim() == "" || pass.trim() == null ){
			alert("비밀번호는 필수로 입력해주세요.");
			// early return
			return;
		} else{
			alert("비밀번호 : " +pass);
		} // end if
		
		if( passchk.trim() == "" || passchk.trim() == null ){
			alert("비밀번호 확인은 필수로 입력해주세요.");
			// early return
			return;
		} else {
			alert("비밀번호 확인 : "+passchk);
		} // end if
		
		if( pass != passchk ){	
			alert("비밀번호가 일치하지 않습니다.\n비밀번호를 다시 확인하여주세요.");
			// early return
			return;
		} // end if
		
		var tel = $("#tel").val();
		var inputDate = $("#inputDate").val();
		addUserProcess( name, email, pass, tel, inputDate )
		
    } // chkNull
	
	function addUserProcess( name, email, pass, tel, inputDate ){
		var param = {
			name : name,
			email : email,
			pass : pass,
			tel : tel,
			inputDate : inputDate };
		alert(name+email+pass+inputDate);
		
		$.ajax({
			url : "user_account_add_proccess.jsp",
			type : "post",
			data : param,
			dataType : "json",
			error : function( xhr ){
				alert("사용자 계정 등록 작업이 정상적으로 수행되지 않았습니다.\n 잠시후 시도해주세요.");
				console.log("status:", xhr.status); // 상태 코드
				console.log("responseText:", xhr.responseText); // 서버에서 응답한 내용
			}, // error
			success : function( jsonObj ){
				console.log("서버 응답:", jsonObj);
				
				if( jsonObj.addFlag ){
					// 사용자 계정 등록성공
					alert("사용자 계정 등록성공");
					location.href="user_account_list.jsp";
				} else {
					// 사용자 계정 등록실패
					alert("사용자 계정 등록실패");
					history.back();
				} //end if else
					
			} // success
		}); //ajax
	} // addUserProcess
    
}); // ready