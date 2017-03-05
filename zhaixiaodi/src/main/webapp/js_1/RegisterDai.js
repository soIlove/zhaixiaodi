$('#iform').form({
	url : "dai/RegisterDai",
	success : function(data) {
		if ($.trim(data) == "true") {
			alert("请耐心等待,正在审核....");
		} else {
			alert(" 注册失败!! 可能是您已经是待递员了");
		}
		$('#iform').reset();
	}
	
});

<<<<<<< HEAD
function addpic(obj) {
=======
	$('#iform').form({    
		url:"zxd/RegisterDai",   
		success:function(data){  
			if(data){
				alert("恭喜你成为小递，加油哦！");
				window.location.href("index.jsp")
			}else{
				alert(" 注册失败");
			}
		}    
	});    

function addpic(obj){
>>>>>>> branch 'master' of https://github.com/soIlove/zhaixiaodi.git
	var picStr = window.URL.createObjectURL(obj.files[0]);
	$("#upicimage").attr("src", picStr);
};
