
	$('#iform').form({    
		url:"zxd/RegisterDai",   
		success:function(data){  
			if(data){
				alert("恭喜你注册成功");
			}else{
				alert(" 注册失败");
			}
		}    
	});    

function addpic(obj){
	var picStr = window.URL.createObjectURL(obj.files[0]);
	$("#upicimage").attr("src", picStr);
};
