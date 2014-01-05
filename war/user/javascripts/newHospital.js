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
			var r = confirm("Are you sure to you wish to close the appointments !");
			if (r == false) {
				return false;
			}
			total = document.approveUser.approveMob.value;
			status = document.approveUser.newApptAction.value;
			comment = document.approveUser.newApptComment.value;
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
			}
		}
		if (checkCount == 0) {
			alert("Please select at least one check box in order to approve");
			return false;
		} else {
			if (total != "") {
				var finalcheckid = total.substr(0, total.length - 1);
				document.getElementById("approveUserList").value = finalcheckid;
			} else {
				if (document.approveUser.approveMob.checked) {
					total = document.approveUser.approveMob.value;
					document.getElementById("approveUserList").value = total;
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

function close1() {

	var total = "";
	var i = 0;
	var checkCount = 0;
	var approve = document.closeUser.closeMob;
	// alert("--->"+approve.length);
	var c = approve.length;
	// alert("+++++++"+c);
	if (c == null) {
		// alert("in if... line 14");
		if (document.closeUser.closeMob.checked == false) {
			alert("Please select at least one check box in order to close the appointments");
			return false;
		} else {
			// alert(" line 19");
			var r = confirm("Are you sure to you wish to close the appointments !");
			if (r == false) {
				return false;
			}
			total = document.closeUser.closeMob.value;
			total = document.closeUser.closeMob.value;
			document.getElementById("closeUserList").value = total;
			// alert("total = " + total);
			return true;
		}

	} else {
		for (i; i < c; i++) {
			// alert("line 34");
			// alert("ash"+document.closeUser.closeMob[i].checked);
			if (document.closeUser.closeMob[i].checked) {
				// alert("mobnum.......");
				// alert(document.closeUser.closeMob[i].value);

				// alert("line 38");
				checkCount++;
				// alert("mobnum......."+document.closeUser.closeMob[i].value);
				total = total + document.closeUser.closeMob[i].value + ",";
				// alert("total--------" + total);
			}
		}
		// alert("i am");
		if (checkCount == 0) {
			alert("Please select at least one check box in order to close");
			return false;
		} else {
			if (total != "") {
				// alert("line 51");
				var finalcheckid = total.substr(0, total.length - 1);
				// alert("finalcheckedid--------- " +finalcheckid);
				document.getElementById("closeUserList").value = finalcheckid;
				// alert("closeuserlist......."+document.closeUser.closeUserList.value);
			} else {
				// alert("line 57");
				if (document.closeUser.closeMob.checked) {
					// alert("line 60");
					total = document.closeUser.closeMob.value;
					document.getElementById("closeUserList").value = total;
					// alert("hi....hi");
					// alert("-----------------------> "
					// +document.getElementById("closeUserList").value);
					return true;
				} else {
					return false;
				}
			}
		}
	}
	// alert("-----------------------> "
	// +document.getElementById("closeUserList").value);
	var r = confirm("Are you sure to you wish to close this appointment !");
	if (r == false) {
		return false;
	}
	return true;

}
