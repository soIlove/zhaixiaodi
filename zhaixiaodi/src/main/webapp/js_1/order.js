

function order(){
	 var params=$('#iform').serialize();//获取值  
	 $.post("order/submit",params,function (data){
		 if(data){
			 alert("下单成功,即将跳往首页");
			 window.location.href="index.jsp";
		 }else{
			 alert("下单失败");
		 }
	 },"json");
	  
	 
 }