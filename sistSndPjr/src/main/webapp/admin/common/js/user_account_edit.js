$(function() {

	$("#btnUserAdd").click(function() {
		chkAddNull();
	}) // click

	$("#btnUserModify").click(function() {
		chkModifyNull();
		setEdit("m");
	}); // click

	$("#btnUserRemove").click(function() {
		setEdit("r");
	}); // click

	$("#btnUserBack").click(function() {
		location.href = 'user_account_list.jsp'
	}); // click

}); // ready

function chkAddNull() {
	var name = $("#name").val();
	var email = $("#email").val();
	var pass = $("#pass").val();
	var passchk = $("#passchk").val();

	if (name.trim() == "" || name.trim() == null) {
		alert("이름은 필수로 입력해주세요.");
		// early return
		return;
	} else {
		alert("이름 : " + name);
	} // end if

	if (email.trim() == "" || email.trim() == null) {
		alert("이메일은 필수로 입력해주세요.");
		// early return
		return;
	} else {
		alert("이메일 : " + email);
	} // end if

	if (pass.trim() == "" || pass.trim() == null) {
		alert("비밀번호는 필수로 입력해주세요.");
		// early return
		return;
	} else {
		alert("비밀번호 : " + pass);
	} // end if

	if (passchk.trim() == "" || passchk.trim() == null) {
		alert("비밀번호 확인은 필수로 입력해주세요.");
		// early return
		return;
	} else {
		alert("비밀번호 확인 : " + passchk);
	} // end if

	if (pass != passchk) {
		alert("비밀번호가 일치하지 않습니다.\n비밀번호를 다시 확인하여주세요.");
		// early return
		return;
	} // end if

	var tel = $("#tel").val();
	var inputDate = $("#inputDate").val();
	addUserProcess(name, email, pass, tel, inputDate)

} // chkAddNull

function chkModifyNull() {
	var name = $("#name").val();

	if (name.trim() == "" || name.trim() == null) {
		alert("이름은 필수로 입력해주세요.");
		// early return
		return;
	} else {
		alert("이름 : " + name);
	} // end if

} // chkModifyNull

function setEdit(flag) {

	var url = "";
	var msg = "";
	var obj = $("#editFrm")[0];

	if (flag == "m") {
		url = "user_account_modify_process.jsp";
		msg = "변경";
		obj.action = url;
		obj.submit();
		modifyUserProcess(url);
	} //end if

	if (flag == "r") {
		url = "user_account_remove_process.jsp";
		msg = "삭제";
		obj.action = url;
		obj.submit();
		removeUserProcess(url);
	} //end if

	/* if( confirm("정말 " +msg+ " 하시겠습니까?") ){ */
	/* } //end if */

} //setEdit

function addUserProcess(name, email, pass, tel, inputDate) {
	var param = {
		name: name,
		email: email,
		pass: pass,
		tel: tel,
		inputDate: inputDate
	};
	alert(name + email + pass + inputDate);

	$.ajax({
		url: "user_account_add_proccess.jsp",
		type: "post",
		data: param,
		dataType: "json",
		error: function(xhr) {
			alert("사용자 계정 등록 작업이 정상적으로 수행되지 않았습니다.\n 잠시후 시도해주세요.");
			console.log("status:", xhr.status); // 상태 코드
			console.log("responseText:", xhr.responseText); // 서버에서 응답한 내용
		}, // error
		success: function(jsonObj) {
			console.log("서버 응답:", jsonObj);

			if (jsonObj.addFlag) {
				// 사용자 계정 등록성공
				alert("사용자 계정 등록성공");
				location.href = "user_account_list.jsp";
			} else {
				// 사용자 계정 등록실패
				alert("사용자 계정 등록실패");
				history.back();
			} //end if else

		} // success
	}); //ajax
} // addUserProcess

function modifyUserProcess(actionUrl) {

	$.ajax({
		url: actionUrl,
		type: "post",
		data: $("#editFrm").serialize(),
		dataType: "json",
		error: function(xhr) {
			alert("사용자 계정 수정 작업이 정상적으로 수행되지 않았습니다.\n 잠시후 시도해주세요.");
			console.log("status:", xhr.status); // 상태 코드
			console.log("responseText:", xhr.responseText); // 서버에서 응답한 내용
		}, // error
		success: function(response) {

			if (response.success) {
				// 사용자 계정 등록성공
				alert("사용자 계정 수정성공");
				location.href = "user_account_list.jsp";
			} else {
				// 사용자 계정 등록실패
				alert("사용자 계정 수정실패" + response.message);
				history.back();
			} //end if else

		} // success
	}); //ajax
} // modifyUserProcess

function removeUserProcess(actionUrl) {

	$.ajax({
		url: actionUrl,
		type: "post",
		data: $("#editFrm").serialize(),
		dataType: "json",
		error: function(xhr) {
			alert("사용자 계정 삭제 작업이 정상적으로 수행되지 않았습니다.\n 잠시후 시도해주세요.");
			console.log("status:", xhr.status); // 상태 코드
			console.log("responseText:", xhr.responseText); // 서버에서 응답한 내용
		}, // error
		success: function(response) {

			if (response.success) {
				// 사용자 계정 등록성공
				alert("사용자 계정 삭제성공");
				location.href = "user_account_list.jsp";
			} else {
				// 사용자 계정 등록실패
				alert("사용자 계정 삭제실패" + response.message);
				history.back();
			} //end if else

		} // success
	}); //ajax

} // removeUserProcess