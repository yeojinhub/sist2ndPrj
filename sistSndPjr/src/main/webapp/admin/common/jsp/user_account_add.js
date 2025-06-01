$(function(){
	$("#btnUserAdd").click(function(){
		chkNull();
	}) // click
	
	function chkNull(){
    	var name = $("#name").val();
		alert(name);
    	
    	if( name.trim() == "" ){
    		alert("이름은 필수로 입력해주세요.");
    	} // end if
    } // chkNull
    
}); // ready