$(function(){
	
	$('#chkAll').change(function() {
		// 전체 선택 체크박스의 상태에 따라 모든 개별 체크박스의 상태를 변경
		$('input[name="chk"]').prop('checked', this.checked);
	}); // change

	$('input[name="chk"]').change(function() {
		// 만약 전체 체크박스 중 하나라도 체크 해제되면, 전체 선택 체크박스를 해제
		if ($('input[name="chk"]').length === $('input[name="chk"]:checked').length) {
			$('#chkAll').prop('checked', true);
		} else {
			$('#chkAll').prop('checked', false);
		} // end if else
	}); // change
	
	$("#btnFoodAddFrm").click(function(){
		location.href='food_add_frm.jsp';
	}); // click
	
	$("#btnFoodModify").click(function(){
		chkModifyNull();
	}); // click
	
	$("#btnFoodRemove").click(function() {
		const checkedValues = [];
		$("input[name='chk']:checked").each(function() {
			checkedValues.push($(this).val());
		});

		if (checkedValues.length === 0) {
			alert("삭제할 항목을 선택해주세요.");
			// early return
			return false;
		} // end if

		if (!confirm("정말 삭제하시겠습니까?")) {
			// early return
			return false;
		} // end if

		setEdit("r", checkedValues);
	}); // click

	$("#btnFoodBack").click(function(){
		location.href='food_witharea_list.jsp';
	}); // click
	
}); // ready

function chkModifyNull(){
	var foodName = $("#foodName").val();
	var price = $("#price").val();
	
	if( foodName.trim() == "" || foodName.trim() == null ){
		alert("음식명은 필수로 입력해주세요.");
		// early return
		return false;
	} // end if
	console.log('음식명 : ',foodName);

	if( price.trim() == "" || price.trim() == null ){
		price = "0";
	} // end if
	console.log('음식가격 : ',price);
	

	var param = {
		foodName: foodName,
		price: price
	}; //param

	setEdit("m", param);

} // chkModifyNull

function setEdit(flag, param){
	
	var url="";
	
	if(flag == "r"){
		url="food_remove_process.jsp";
		removeFoodProcess(url, param);
	} // end if
	
	if(flag == "a"){
		url="food_add_process.jsp";
		addAreaProcess(url, param);
	} // end if
	
	if(flag == "m"){
		url="food_modify_process.jsp";
		modifyFoodProcess(url, param);
	} // end if
	
} //setEdit

function modifyFoodProcess(actionUrl, param){

	$.ajax({
		url: actionUrl,
		type: "post",
		data: param,
		error: function(xhr) {
			alert("음식의 수정 작업이 정상적으로 수행되지 않았습니다.\n 잠시후 시도해주세요.");
			console.error("status:", xhr.status); // 상태 코드
			console.error("responseText:", xhr.responseText); // 서버에서 응답한 내용
		}, // error
		success: function(response) {
			if (response.success) {
				// 음식 수정성공
				alert("음식 수정성공");
				location.href = "food_list.jsp";
			} else {
				// 음식 삭제실패
				alert("음식 수정성공" + response.message);
				history.back();
			} // end if else
		} // success
	}); // ajax

} // removeFoodProcess


function removeFoodProcess(actionUrl, checkedValues){

	$.ajax({
		url: actionUrl,
		type: "post",
		data: { chk: checkedValues },
		traditional: true, // 배열 전송
		error: function(xhr) {
			alert("음식의 삭제 작업이 정상적으로 수행되지 않았습니다.\n 잠시후 시도해주세요.");
			console.error("status:", xhr.status); // 상태 코드
			console.error("responseText:", xhr.responseText); // 서버에서 응답한 내용
		}, // error
		success: function(response) {
			if (response.success) {
				// 음식 삭제성공
				alert("음식 삭제성공");
				location.href = "food_list.jsp";
			} else {
				// 음식 삭제실패
				alert("음식 삭제실패" + response.message);
				history.back();
			} // end if else
		} // success
	}); // ajax

} // removeFoodProcess
