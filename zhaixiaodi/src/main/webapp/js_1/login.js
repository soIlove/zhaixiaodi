
$("#loginForm").form({
	url:"user/login",    
    success:function(data){ 
    	//alert(data);
    	if(data.trim()=="true"){
    		location.replace("page/list.jsp");
    	}else{
    		$.messager.show({
    			title:"登录信息",
    			msg:"登录失败，编号与姓名不匹配!!!",
    			showType:'show',
    			style:{
    				top:document.body.scrollTop+document.documentElement.scrollTop,
    			}
    		});

    	}
    },    
})


function loginSub(){
	/*if ($.trim($("#j_username").val()) == "") {
		alert("请输入登录名");
		$("#j_username").focus();
		return false;
	}
	if ($.trim($("#j_password").val()) == "") {
		alert("请输入密码");
		$("#j_password").focus();
		return false;
	}*/
	
	
}