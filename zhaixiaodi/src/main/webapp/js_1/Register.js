function getCaptcha(){
	var phonenum=$("#vphone").val();
	alert(phonenum);
	
	$.post("zxduser/captcha",{"vphone":phonenum},function (data){
				
			},"json")
	
	
}