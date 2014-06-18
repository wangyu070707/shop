function gotoPage(formName, pageNum){
		var pageInputName = "currentPage";
		var pageInput = null;
		var form = document.getElementsByName(formName)[0];
		
		if(document.getElementsByName(pageInputName).length != 0){
			pageInput = document.getElementsByName(pageInputName)[0];
			pageInput.value = pageNum;
		}else{
			pageInput = document.createElement("input");
			pageInput.type = "hidden";
		    pageInput.name = "currentPage";
		    pageInput.value = pageNum;
		    
		    form.appendChild(pageInput);
		}
		
		form.submit();
}