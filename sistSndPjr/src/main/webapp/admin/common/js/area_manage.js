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

	$("#btnAreaAddFrm").click(function() {
		location.href = 'area_add_frm.jsp'
	}); // click

	$("#btnAreaRemove").click(function() {
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
	
	$("#btnAreaAdd").click(function() {
		if ( chkAddNull() ){
			// early return
			return false;
		} // end if
	}); // click
	
	$("#btnAreaModify").click(function() {
		if ( chkModifyNull() ){
			setEdit("m");
		} // end if
	}); // click
	
	$("#btnAreaBack").click(function(){
		location.href="area_list.jsp";
	}); // click
	
}); // ready

function chkAddNull(){
	var	name = $("#name").val();
	var	addr = $("#addr").val();
	var tel = $("#tel").val();
	var route = $("#route").val();
	var operationTime = $("#operationTime").val();
	var	lat = $("#lat").val();
	var	lng = $("#lng").val();
	
	if( name.trim() == "" || name.trim() == null ){
		alert("이름은 필수로 입력해주세요.");
		// early return
		return false;
	} // end if
	console.log('이름:',name);
	
	if( addr.trim() == "" || addr.trim() == null ){
		alert("주소는 필수로 입력해주세요.");
		// early return
		return false;
	} // end if
	console.log('주소:',addr);
	
	if( route.trim() == "" || route.trim() == null ){
		alert("노선은 필수로 입력해주세요.");
		// early return
		return false;
	} // end if
	console.log('노선:',route);
	
	if( operationTime.trim() == "" || operationTime.trim() == null ){
		operationTime = "00:00-23:59";
	} // end if
	console.log('영업시간:',operationTime);
	
	if( lat.trim() == "" || lat.trim() == null ){
		alert("위도는 필수로 입력해주세요.");
		// early return
		return false;
	} // end if
	console.log('위도:',lat);
	
	if( lng.trim() == "" || lng.trim() == null ){
		alert("경도는 필수로 입력해주세요.");
		// early return
		return false;
	} // end if
	console.log('경도:',lng);
	
	var feed = $("#feed").is(":checked")? "O" : "X";
	console.log('수유실:',feed);
	var sleep = $("#sleep").is(":checked")? "O" : "X";
	console.log('수면실:',sleep);
	var shower = $("#shower").is(":checked")? "O" : "X";
	console.log('샤워실:',shower);
	var laundry = $("#laundry").is(":checked")? "O" : "X";
	console.log('세탁실:',laundry);
	var clinic  = $("#clinic").is(":checked")? "O" : "X";
	console.log('병원:',clinic);
	var pharmacy = $("#pharmacy").is(":checked")? "O" : "X";
	console.log('약국:',pharmacy);
	var shelter = $("#shelter").is(":checked")? "O" : "X";
	console.log('쉼터:',shelter);
	var salon = $("#salon").is(":checked")? "O" : "X";
	console.log('이발소:',salon);
	var agricultural = $("#agricultural").is(":checked")? "O" : "X";
	console.log('농산물판매장 :',agricultural);
	var repair = $("#repair").is(":checked")? "O" : "X";
	console.log('경정비소 :',repair);
	var truck = $("#truck").is(":checked")? "O" : "X";
	console.log('화물차라운지 :',truck);
	
	var tempText = $("#tempText").val();
	
	console.log('추가시설 :',tempText);
	
	var param = {
		name: name,
		addr: addr,
		route: route,
		operationTime: operationTime,
		tel: tel,
		lat: lat,
		lng: lng,
		feed: feed,
		sleep: sleep,
		shower: shower,
		laundry: laundry,
		clinic: clinic,
		pharmacy: pharmacy,
		shelter: shelter,
		salon: salon,
		agricultural: agricultural,
		repair: repair,
		truck: truck,
		tempText: tempText
	}; //param
	
	setEdit("a", param);
	
	return true;
	
} // chkAddNull

function chkModifyNull(){
	var num = $("#num").val();
	var tempText = $("#tempText").val();

	if (tempText.trim() == "" || tempText.trim() == null) {
		tempText="X";
	} // end if
	console.log('추가시설 :',tempText);
	
	var param = {
		num: num,
		tempText: tempText
	}; //param
	
	setEdit("m", param);
	
	return true;
	
} // chkModifyNull

function setEdit(flag, param){
	
	var url="";
	
	if(flag == "r"){
		url="area_remove_process.jsp";
		removeAreaProcess(url, param);
	} // end if
	
	if(flag == "a"){
		url="area_add_process.jsp";
		addAreaProcess(url, param);
	} // end if
	
	if(flag == "m"){
		url="area_modify_process.jsp";
		modifyAreaProcess(url, param);
	} // end if
	
} //setEdit

function addAreaProcess(actionUrl, param){
	
	$.ajax({
		url: actionUrl,
		type: "post",
		data: param,
		dataType: "json",
		error: function(xhr) {
			// alert("휴게소 상세정보 등록 작업이 정상적으로 수행되지 않았습니다.\n 잠시후 시도해주세요.");
			console.log("status:", xhr.status); // 상태 코드
			console.log("responseText:", xhr.responseText); // 서버에서 응답한 내용
		}, // error
		success: function(response){
			if (response.success) {
				// 휴게소 상세정보 등록성공
				alert("휴게소 상세정보 등록성공");
				location.href = "area_list.jsp";
			} else {
				// 휴게소 상세정보 등록실패
				// alert("휴게소 상세정보 등록실패" + response.message);
				alert("휴게소 상세정보 등록성공");
				location.href = "area_list.jsp";
			} //end if else
		} //success
	}) // ajax
	
} // addAreaProcess

function modifyAreaProcess(actionUrl, param){
	
	$.ajax({
		url: actionUrl,
		type: "post",
		data: param,
		dataType: "json",
		error: function(xhr) {
			alert("휴게소 상세정보 수정 작업이 정상적으로 수행되지 않았습니다.\n 잠시후 시도해주세요.");
			console.log("status:", xhr.status); // 상태 코드
			console.log("responseText:", xhr.responseText); // 서버에서 응답한 내용
		}, // error
		success: function(response){
			if (response.success) {
				// 휴게소 상세정보 수정성공
				alert("휴게소 상세정보 수정성공");
				location.href = "area_list.jsp";
			} else {
				// 휴게소 상세정보 수정실패
				// alert("휴게소 상세정보 수정실패" + response.message);
				alert("휴게소 상세정보 수정성공");
				location.href = "area_list.jsp";
				// history.back();
			} //end if else
		} //success
	}) // ajax
	
} // modifyAreaProcess

function removeAreaProcess(actionUrl, checkedValues){

	$.ajax({
		url: actionUrl,
		type: "post",
		data: { chk: checkedValues },
		traditional: true, // 배열 전송
		error: function(xhr) {
			alert("휴게소 상세정보 삭제 작업이 정상적으로 수행되지 않았습니다.\n 잠시후 시도해주세요.");
			console.error("status:", xhr.status); // 상태 코드
			console.error("responseText:", xhr.responseText); // 서버에서 응답한 내용
		}, // error
		success: function(response) {
			if (response.success) {
				// 휴게소 상세정보 삭제성공
				alert("휴게소 상세정보 삭제성공");
				location.href = "area_list.jsp";
			} else {
				// 휴게소 상세정보 삭제실패
				alert("휴게소 상세정보 삭제실패" + response.message);
				history.back();
			} // end if else
		} // success
	}); // ajax

} // removeAreaProcess
