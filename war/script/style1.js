
function jsCheck() {

	var name = document.getElementById("childName").value;
	var dob = document.getElementById("datepicker").value;
	var re=/^[A-z\s]+$/;
	
	
	if(name == "" || dob == ""){
	
			alert("You must fill in all of the fields. ");			
			return false;
		}
	
	
	if(re.test(name) )
		  return true;
	else
	{
			alert(" Name should contain only characters.");
			return false;
	}
}

function formSubimit() {
	var validation = jsCheck();
	if(validation)
		return document.getElementById('formd').submit();
	else
		return false;
}