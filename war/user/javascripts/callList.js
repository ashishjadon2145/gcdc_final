function approve1() {

	var total = "";
	var status = "";
	var comment = "";
	var i = 0;
	var checkCount = 0;
	var approve = document.approveUser.approveMob;
	var c = approve.length;

	if (c == null) {
		if (document.approveUser.approveMob.checked == false) {
			alert("Please select at least one check box in order to approve");
			return false;
		} else {
			var r = confirm("Are you sure you want to proceed ?");
			if (r == false) {
				return false;
			}
			total = document.approveUser.approveMob.value;
			status = document.getElementById("newApptAction").value;
			//comment = document.getElementById("newApptComment")[0].value;
			comment = document.approveUser.newApptComment.value;
			alert("cmt: "+comment);
			document.getElementById("approveUserList").value = total;
			document.getElementById("newApptActionList").value = status;
			document.getElementById("newApptCommentList").value = comment;
			return true;
		}
	} else {
		for (i; i < c; i++) {
			if (document.approveUser.approveMob[i].checked) {
				checkCount++;
				total = total + document.approveUser.approveMob[i].value + ",";
				status = status + document.getElementById("newApptAction")[i].value + ",";
				//comment = comment + document.getElementById("newApptComment")[i].value + ",";
				//alert("sts: "+status);
				//alert("cmt: "+comment);
			}
		}
		if (checkCount == 0) {
			alert("Please select at least one check box in order to approve");
			return false;
		} else {
			if (total != "") {
				var finalcheckid = total.substr(0, total.length - 1);
				var finalcheckStatus = status.substr(0, status.length - 1);
				//var finalcheckComment = comment.substr(0, comment.length - 1);
				document.getElementById("approveUserList").value = finalcheckid;
				document.getElementById("newApptActionList").value = finalcheckStatus;
				//document.getElementById("newApptCommentList").value = finalcheckComment;
			} else {
				if (document.approveUser.approveMob.checked) {
					total = document.approveUser.approveMob.value;
					status = document.getElementById("newApptAction").value;
					//comment = document.getElementById("newApptComment").value;
					document.getElementById("approveUserList").value = total;
					document.getElementById("newApptActionList").value = status;
					//document.getElementById("newApptCommentList").value = comment;
					return true;
				} else {
					return false;
				}
			}
		}
	}
	var r = confirm("Are you sure to you wish to approve this appointment !");
	if (r == false) {
		return false;
	}
	return true;
}