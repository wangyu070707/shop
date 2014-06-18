// --------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------
//     描述： 日历选择
//   依赖于:  jQuery library;
//     作者:  林卿;
//     邮箱： linqing@allinpay.com
//     日期： 2013-11-13
// --------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------
// START

if (typeof allinpay !== 'object') var allinpay = {};
allinpay.datePicker = function(el,args) {
	this.init = function(){
		$(el).datepicker(args);
	}	
}

$(function(){
	var tommorrow =	new Date();
	tommorrow.setDate(tommorrow.getDate()+1);

	(new allinpay.datePicker(".datePicker,.datePickerEndTime,.datePickerAfter30Days",{
		goToCurrent:true,
		rangeSlelect:true,
		hideIfNoPrevNext:true,
		rangeSlelect:true,
		changeYear:true,
		changeMonth:true,
		showStatues:true,
		yearRange:"-100:+100",
		showButtonPanel: true
	})).init();

	(new allinpay.datePicker(".datePickerStartTime",{
		goToCurrent:true,
		rangeSlelect:true,
		hideIfNoPrevNext:true,
		rangeSlelect:true,
		changeYear:true,
		changeMonth:true,
		showStatues:true,
		yearRange:"-100:+100",
		showButtonPanel: true,
		onSelect:function(dateText,inst){
			var d = new Date();
			d.setDate(inst.currentDay);
			d.setMonth(inst.currentMonth);
			d.setYear(inst.currentYear);
			endDate = new Date(d.valueOf()+30*24*60*60*1000);
			$(this).siblings(".datePickerEndTime")
				.datepicker("option","minDate",dateText);
			$(this).siblings(".datePickerAfter30Days")
				.datepicker("option","minDate",dateText)
				.datepicker("option","maxDate",endDate);
		} 
	})).init();

	(new allinpay.datePicker(".datePickerAfterToday",{
		goToCurrent:true,
		rangeSlelect:true,
		hideIfNoPrevNext:true,
		rangeSlelect:true,
		changeYear:true,
		changeMonth:true,
		showStatues:true,
		yearRange:"-0:+100",
		minDate: tommorrow,
		showButtonPanel: true,
		onSelect:function(dateText,inst){  
			$(this).siblings(".datePickerEndTime").datepicker("option","minDate",dateText);  
		}
	})).init();


	$(".datePickerStartTime").each(function(index, val) {
		var currentDate = $(this).datepicker("getDate");
		if (currentDate) {
			var endDate = new Date(currentDate.valueOf()+30*24*60*60*1000);
		}
		$(this).siblings(".datePickerAfter30Days")
				.datepicker("option","minDate",currentDate)
				.datepicker("option","maxDate",endDate);
	});
});