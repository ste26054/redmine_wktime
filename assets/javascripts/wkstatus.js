$(document).ready(function(){
	var txtEntryDate;
	if(document.getElementById('divError') != null){	
		if(document.getElementById('time_entry_spent_on')!=null){
			txtEntryDate = document.getElementById('time_entry_spent_on');	
		}
		else{
			//get current date
			var today = new Date();	
			today = today.getFullYear() + '-' + (today.getMonth()+1) + '-' + today.getDate();
			showEntryWarning(today);
		}		
	}	
	if(txtEntryDate!=null){		
		showEntryWarning(txtEntryDate.value);
		txtEntryDate.onchange=function(){showEntryWarning(this.value)};	
	}	
});

function showEntryWarning(entrydate){
	var $this = $(this);				
	var divID =document.getElementById('divError');	
	var statusUrl = document.getElementById('getstatus_url').value;		
	divID.style.display ='none';
	$.ajax({
		url: statusUrl,
		type: 'get',
		data: {startDate: entrydate},
		success: function(data){ showMessage(data,divID); },
		complete: function(){ $this.removeClass('ajax-loading'); }
	});		
}

function showMessage(data,divID){							
	if(data!=null && ('s'== data || 'a'== data || 'l'== data)){
		divID.style.display = 'block';
		 $("form.edit_time_entry p :input").prop("disabled", true);
		 $("form.edit_time_entry p :input").prop("readOnly", true);
		 $("form.edit_time_entry :input[type=submit]").hide();
		 if ($("form.edit_time_entry p .ui-datepicker-trigger").length > 0){
			$("form.edit_time_entry p .ui-datepicker-trigger").hide();
		 }
	}
	else{				
		divID.style.display ='none';
		$("form.edit_time_entry p :input").prop("disabled", false);
		 $("form.edit_time_entry p :input").prop("readOnly", false);
		 $("form.edit_time_entry :input[type=submit]").show();
		 if ($("form.edit_time_entry p .ui-datepicker-trigger").length > 0){
			$("form.edit_time_entry p .ui-datepicker-trigger").show();
		 }
	}	
}
