function feedback(){
	var x = document.forms["feedback1"]["email"].value;
	if (x == "") {
		alert("Email must be filled out");
		return false;
	}
	var y = document.forms["feedback1"]["firstname"].value;
	if (y == "") {
		alert("First Name must be filled out");
		return false;
	}
	var z = document.forms["feedback1"]["lastname"].value;
	if (z == "") {
		alert("Last Name must be filled out");
		return false;
	}
	var a = document.forms["feedback1"]["comments"].value;
	if (a == "") {
		alert("Comments must be filled out");
		return false;
	}
	var b = document.forms["feedback1"]["gender"].value;
	if (b == "") {
		alert("Gender must be filled out");
		return false;
	}
	var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	if(re.test(String(x).toLowerCase())==false){
		alert("Incorrect Email Format!");
		return false;
	}
}
