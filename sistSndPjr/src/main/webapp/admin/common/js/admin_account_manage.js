$(function(){
	
	$("#btnAdminModify").click(function(){
		if( chkModifyNull() ){
			setEdit("m");
		} //end if
	}); // click
	
	$("#btnAdminBack").click(function(){
		location.href='admin_account_list.jsp'
	}); // click
	
}); // ready

function chkModifyNull() {
	var name = $("#name").val();

	if (name.trim() == "" || name.trim() == null) {
		alert("이름은 필수로 입력해주세요.");
		// early return
		return;
	} else {
		alert("이름 : " + name);
		return true;
	} // end if

} // chkModifyNull

function setEdit(flag) {

	var url = "";
	var msg = "";

	if (flag == "m") {
		url = "admin_account_modify_process.jsp";
		msg = "변경";
		modifyAdminProcess(url);
	} //end if

	/* if( confirm("정말 " +msg+ " 하시겠습니까?") ){ */
	/* } //end if */

} //setEdit

function modifyAdminProcess(actionUrl) {

	$.ajax({
		url: actionUrl,
		type: "post",
		data: $("#editFrm").serialize(),
		dataType: "json",
		error: function(xhr) {
			alert("관리자 계정 수정 작업이 정상적으로 수행되지 않았습니다.\n 잠시후 시도해주세요.");
			console.log("status:", xhr.status); // 상태 코드
			console.log("responseText:", xhr.responseText); // 서버에서 응답한 내용
		}, // error
		success: function(response) {

			if (response.success) {
				// 사용자 계정 등록성공
				alert("관리자 계정 수정성공");
				location.href = "admin_account_list.jsp";
			} else {
				// 사용자 계정 등록실패
				alert("관리자 계정 수정실패" + response.message);
				history.back();
			} //end if else

		} // success
	}); //ajax
	
} // modifyAdminProcess