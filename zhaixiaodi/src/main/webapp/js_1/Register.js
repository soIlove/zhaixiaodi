function getCaptcha(){
	var phonenum=$("#uphone").val();
	$.post("zxd/captcha",{"uphone":phonenum},function (data){				
		$("#vaild").val(data);
	},"json")
	
	var times;
	var time=60;
	$("#getMsgBtn").addClass("disabled");
	$("#getMsgBtn").val("倒计时"+time+"秒");
	$("#getMsgBtn").attr("disabled","disabled");
	var _this=$("#getMsgBtn");

    times = setInterval(function () {
		time=time-1;
        _this.val("倒计时"+time+"秒");
		if(time==0){
			clearInterval(times);
			_this.removeClass("disabled");
			_this.removeAttr("disabled");
			_this.val('获取验证码');
		}
    }, 1000);
				
}

$("#uphone").blur(function(){
	 var phoneNum = $("#uphone").val();
    if (phoneNum.length == 11) {
        var isPhone = /^1[3-9]\d{9}$/;
        if (isPhone.test(phoneNum)) {
            $("#getMsgBtn").removeAttr("disabled");//启用按钮
            $("#getMsgBtn").removeClass("disabled");
            $("#getMsgBtn").val('获取验证码');
            layer.msg('请点击获取验证码');
        } else {
            layer.msg('您输入的电话号码不对哦,电话号为' + phoneNum);
        }
    } else {
        $("#getMsgBtn").attr("disabled", "disabled");//关闭按钮
    }
});
$("#vaildNum").blur(function(){
	
     var inputvaild = $('#vaildNum').val();
     var vaild = $('#vaild').val();
     if (inputvaild != "" && inputvaild == vaild) {
    	 alert("验证码正确,")
        
        // $('#proposerPhone').val($('#vphone').val());
     } else {
    	 alert("验证码输入不正确,")
     }

})

$("#password02").blur(function(){
		var password1=$("#upwd").val();
		var password2=$("#password02").val();
		if(password2!=password1){
			alert("两次密码不统一,请重新输入");
		}
	
})


$('#iform').form({    
	
    url:"zxd/Register",    
    success:function(data){    
    	if(data){
    		alert("恭喜你注册成功")
    	}
    }    
});    

function addpic(obj){
	var picStr = window.URL.createObjectURL(obj.files[0]);
	$("#upicimage").attr("src", picStr);
};
