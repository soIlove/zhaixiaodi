

function order(){
	 var params=$('#iform').serialize();//获取值  
	 alert(params);
	 $.post("order/submit",params,function (data){
		 alert("返回结果:::"+data);
		 if(data){
		 }
	 },"json");
	  
	 
 }