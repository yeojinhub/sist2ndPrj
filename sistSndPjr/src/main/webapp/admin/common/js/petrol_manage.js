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

	$("#btnPetRemove").click(function() {
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

	$("#btnPetAddFrm").click(function(){
		location.href='petrol_add_frm.jsp';
	}); // click
	
	$("#btnPetAdd").click(function(){
		if (chkAddNull()) {
			// early return
			return false;
		} // end if
	}); // click
	
	$("#btnPetModify").click(function() {
		if (chkModifyNull()) {
			// early return
			return false;
		} // end if
	}); // click
	
	$("#btnPetBack").click(function(){
		location.href='petrol_list.jsp';
	}); // click
	
}); // ready

function chkAddNull(){
	var	name = $("#name").val();
	var route = $("#route").val();
	var tel = $("#tel").val();
	var gasoline = $("#gasoline").val();
	var diesel = $("#diesel").val();
	var lpg = $("#lpg").val();
	var elect = $("#elect").val();
	var hydro = $("#hydro").val();
	
	if( name.trim() == "" || name.trim() == null ){
		alert("휴게소명은 필수로 입력해주세요.");
		// early return
		return false;
	} // end if
	console.log('휴게소명 : ',name);
	
	if( route.trim() == "" || route.trim() == null ){
		alert("노선은 필수로 입력해주세요.");
		// early return
		return false;
	} // end if
	console.log('노선 : ',route);
	
	if( gasoline.trim() == "" || gasoline.trim() == null ){
		gasoline = "X";
	} // end if
	console.log('휘발유 : ',gasoline);
	
	if( diesel.trim() == "" || diesel.trim() == null ){
		diesel = "X";
	} // end if
	console.log('경유 : ',diesel);
	
	if( lpg.trim() == "" || lpg.trim() == null ){
		lpg = "X";
	} // end if
	console.log('LPG : ',lpg);
	
	if( elect.trim() == "" || elect.trim() == null ){
		elect = "X";
	} // end if
	console.log('전기충전소 : ',elect);
	
	if( hydro.trim() == "" || hydro.trim() == null ){
		hydro = "X";
	} // end if
	console.log('수소충전소 : ',hydro);
	
	var param = {
		name: name,
		route: route,
		tel: tel,
		gasoline: gasoline,
		diesel: diesel,
		lpg: lpg,
		elect: elect,
		hydro: hydro,
	}; //param
	
	setEdit("a", param);
	
} // chkAddNull

function chkModifyNull(){
	var num = $("#num").val();
	var gasoline = $("#gasoline").val();
	var diesel = $("#diesel").val();
	var lpg = $("#lpg").val();
	var elect = $("#elect").val();
	var hydro = $("#hydro").val();
	
	if( gasoline.trim() == "" || gasoline.trim() == null ){
		gasoline = "X";
	} // end if
	console.log('휘발유 : ',gasoline);

	if( diesel.trim() == "" || diesel.trim() == null ){
		diesel = "X";
	} // end if
	console.log('경유 : ',diesel);

	if( lpg.trim() == "" || lpg.trim() == null ){
		lpg = "X";
	} // end if
	console.log('LPG : ',lpg);

	if( elect.trim() == "" || elect.trim() == null ){
		elect = "X";
	} // end if
	console.log('전기충전소 : ',elect);

	if( hydro.trim() == "" || hydro.trim() == null ){
		hydro = "X";
	} // end if
	console.log('수소충전소 : ',hydro);
	

	var param = {
		num: num,
		gasoline: gasoline,
		diesel: diesel,
		lpg: lpg,
		elect: elect,
		hydro: hydro,
	}; //param

	setEdit("m", param);

} // chkModifyNull

function setEdit(flag, param){
	
	var url="";
	
	if(flag == "r"){
		url="petrol_remove_process.jsp";
		removePetrolProcess(url, param);
	} // end if
	
	if(flag == "a"){
		url="petrol_add_process.jsp";
		addPetrolProcess(url, param);
	} // end if
	
	if(flag == "m"){
		url="petrol_modify_process.jsp";
		modifyPetrolProcess(url, param);
	} // end if
	
} //setEdit

function addPetrolProcess(actionUrl, param){
	
	$.ajax({
		url: actionUrl,
		type: "post",
		data: param,
		dataType: "json",
		error: function(xhr) {
			alert("주유소 등록 작업이 정상적으로 수행되지 않았습니다.\n 잠시후 시도해주세요.");
			console.log("status:", xhr.status); // 상태 코드
			console.log("responseText:", xhr.responseText); // 서버에서 응답한 내용
		}, // error
		success: function(response){
			if (response.success) {
				// 주유소 등록성공
				alert("주유소 등록성공");
				location.href = "petrol_list.jsp";
			} else {
				// 주유소 등록실패
				alert("주유소 등록실패" + response.message);
				history.back();
			} //end if else
		} //success
	}) // ajax
	
} // addPetrolProcess

function modifyPetrolProcess(actionUrl, param) {

	$.ajax({
		url: actionUrl,
		type: "post",
		data: param,
		dataType: "json",
		error: function(xhr) {
			alert("주유소 수정 작업이 정상적으로 수행되지 않았습니다.\n 잠시후 시도해주세요.");
			console.log("status:", xhr.status); // 상태 코드
			console.log("responseText:", xhr.responseText); // 서버에서 응답한 내용
		}, // error
		success: function(response) {
			if (response.success) {
				// 주유소 수정성공
				alert("주유소 수정성공");
				location.href = "petrol_list.jsp";
			} else {
				// 주유소 수정실패
				alert("주유소 수정실패" + response.message);
				history.back();
			} //end if else
		} // success
	}); //ajax
	
} // modifyPetrolProcess

function removePetrolProcess(actionUrl, checkedValues){

	$.ajax({
		url: actionUrl,
		type: "post",
		data: { chk: checkedValues },
		traditional: true, // 배열 전송
		error: function(xhr) {
			alert("주유소의 삭제 작업이 정상적으로 수행되지 않았습니다.\n 잠시후 시도해주세요.");
			console.error("status:", xhr.status); // 상태 코드
			console.error("responseText:", xhr.responseText); // 서버에서 응답한 내용
		}, // error
		success: function(response) {
			if (response.success) {
				// 주유소 삭제성공
				alert("주유소 삭제성공");
				location.href = "petrol_list.jsp";
			} else {
				// 주유소 삭제실패
				alert("주유소 삭제실패" + response.message);
				history.back();
			} // end if else
		} // success
	}); // ajax

} // removeFoodProcess
