<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<base href="/zhaixiaodi/">

<meta  charset="UTF-8">
<title>Insert title here</title>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">
<meta http-equiv="Cache-Control" content="no-cache">

<link rel="icon" href="http://www.shouhuobao.com/merchant/favicon.ico" type="image/x-icon">
<link rel="shortcut icon" href="http://www.shouhuobao.com/merchant/favicon.ico" type="image/x-icon">

<link rel="stylesheet" type="text/css" href="css/theme.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap-select.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap-responsive.css">
<link rel="stylesheet" type="text/css" href="css/docs.css">
<link rel="stylesheet" type="text/css" href="css/prettify.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="css/jquery.css">	

<script type="text/javascript" src="css/jquery-1.js"></script>
<!-- <script type="text/javascript" -->

<!-- <script type="text/javascript" -->


<!-- 百度统计开放平台JS API -->
<script>
	var _hmt = _hmt || [];
	_hmt.push(['_setAccount', '450f34e18b8751446775cba4abdb88c2']);
</script>
<title>商户中心 | 宅小递</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link rel="stylesheet" type="text/css" href="css/join.css">
    <script src="js/wb.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/jquery-1_002.js"></script>
    <script src="js/jquery-validate.js"></script>
    <script src="js/swiper.js" type="text/javascript"></script>
    <script src="js/base_002.js" type="text/javascript"></script>
    <script src="js/layer.js" type="text/javascript"></script><link rel="stylesheet" href="css/layer.css" id="layui_layer_skinlayercss" style="">
    <script src="js/uploadPreview.js" type="text/javascript"></script>
    <script src="js/wb.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/api" type="text/javascript"></script><script type="text/javascript" src="js/getscript"></script>
    <script>


        $(function(){

            layer.ready(function () {
                
            });


        	var map = new BMap.Map("allmap");    // 创建Map实例
        	map.centerAndZoom("北京市",15);  // 初始化地图,设置中心点坐标和地图级别
        	function seachPoint(){
                // 百度地图API功能
        		var allOverlay = map.getOverlays();
        		for (var i = 0; i < allOverlay.length ; i++){
        			map.removeOverlay(allOverlay[i]);
        		}
                var sCity = $("#shiCon").prev(".zln-select_box").html();
                var sArea =  $("#quCon").prev(".zln-select_box").html();
                var sOther =  $("#otherCon").prev(".zln-select_box").html();
                var sAddress = $('#address').val();
                // 创建地址解析器实例
                var myGeo = new BMap.Geocoder();
                // 将地址解析结果显示在地图上,并调整地图视野
                myGeo.getPoint(sCity+sArea+sOther+sAddress, function(point){
                    if (point) {
                        $('#lat').val(point.lat);
                        $('#lng').val(point.lng);
                        $('#addressLine1').val(sCity+sArea);
                        map.centerAndZoom(point, 16);
                        map.addOverlay(new BMap.Marker(point));
                    }else{
                        layer.msg("您选择地址没有解析到结果!");
                    }
                }, sCity);
            }
        	$("#searchPoint").on("click",seachPoint);


            $.ajax(
                    {
                        type: "POST",
                        url: "/merchant/search/json-lookup-state.html",
                        data: "params=&ajax=true",
                        success: function (msg) {
                            var oo = eval("("+msg+")");
                            oo.forEach(function(p){
                                var option = "<option value='" + p.value  + "'>" +p.label  + "</option>";
                                $("#selProvince").append(option);
                                $("#shengCon").append("<p><a href='javascript:;' _title=" + p.value + ">" + p.label + "</a></p>");
                            })
                        }
                    }
            );


            $("#selProvince").change(function() {
                var selValue = $("#shengCon").prev(".zln-select_box").attr("_title");
                $("#selCity option:gt(0)").remove();
                $("#shiCon").html("<p><a href='javascript:;' _title='0'>市</a></p>");
                $("#shiCon").prev(".zln-select_box").html("市");
                $("#shiCon").prev().css({"color":"#c6ccd2"});

                $.ajax(
                        {
                            type: "POST",
                            url: "/merchant/search/json-lookup-cityjson.html",
                            data: "params=" + selValue + "&ajax=true&type=city",
                            success: function (msg) {
                                var oo = eval("("+msg+")");
                                oo.forEach(function(p){
                                    var option = "<option value='" + p.value  + "'>" +p.label  + "</option>";
                                    $("#selCity").append(option);
                                    $("#shiCon").append("<p><a href='javascript:;' _title=" + p.value + ">" + p.label + "</a></p>");
                                })
                            }
                        }
                );


            });
            $("#selCity").change(function() {
                var selValue = $("#shiCon").prev(".zln-select_box").attr("_title");
                var city = $("#shiCon").prev(".zln-select_box").html();
                //layer.msg(city);
                $("#selDistrict option:gt(0)").remove();
                $("#quCon").html("<p><a href='javascript:;' _title='0'>区</a></p>");
                $("#quCon").prev(".zln-select_box").html("区");
                $("#quCon").prev().css({"color":"#c6ccd2"});
				initMap(city);
                $.ajax(
                        {
                            type: "POST",
                            url: "/merchant/search/json-lookup-areajson.html",
                            data: "params=" + selValue + "&ajax=true&type=area",
                            success: function (msg) {
                                var oo = eval("("+msg+")");
                                oo.forEach(function(p){
                                    var option = "<option value='" + p.value  + "'>" +p.label  + "</option>";
                                    $("#selDistrict").append(option);

                                    $("#quCon").append("<p><a href='javascript:;' _haschild='1' _title=" + p.value + ">" + p.label + "</a></p>");
                                })
                            }
                        }
                );
            });
            $("#selDistrict").change(function() {
                if($("#quCon").prev(".zln-select_box").attr("_haschild")==1){
                    $("#otherCon").parent().show();
                    var selValue = $("#quCon").prev(".zln-select_box").attr("_title");
                    $("#selOther option:gt(0)").remove();
                    $("#otherCon").html("<p><a href='javascript:;' _title='BZ9999'>其他</a></p>");
                    $("#otherCon").prev(".zln-select_box").html("商圈");
                    $("#otherCon").prev().css({"color":"#c6ccd2"});

                    $.ajax({
                                type: "POST",
                                url: "/merchant/search/json-lookup-bizcirclejson.html",
                                data: "params=" + selValue + "&ajax=true&type=bizcircle",
                                success: function (msg) {
                                    var oo = eval("("+msg+")");
                                    oo.forEach(function(p){
                                        var option = "<option value='" + p.value  + "'>" +p.label  + "</option>";
                                        $("#selOther").append(option);

                                        $("#otherCon").append("<p><a href='javascript:;' _title=" + p.value + ">" + p.label + "</a></p>");
                                    })

                                }
                            });
                }
                else{
                    $("#otherCon").parent().hide();
                }
            });
            /*省 市 区*/
            $(".zln-select_box").click(function(event) {
                if ($(this).hasClass("hoer")) {
                    $(this).removeClass("hoer");
                    $(this).next().hide();
                } else {
                    $(".zln-select_box").removeClass("hoer");
                    $(".zln-select_fola").hide();
                    $(this).addClass("hoer");
                    $(this).next().show();
                }
                event.stopPropagation();
            });
            $(document).click(function(event) {
                $(".zln-select_box").removeClass("hoer");
                $(".zln-select_box").next().hide();
            });

            $("#vphone").on('input',function(){
        		 var phoneNum = $("#vphone").val();
                 if (phoneNum.length == 11) {
                     var isPhone = /^1[3-9]\d{9}$/;
                     if (isPhone.test(phoneNum)) {
                         $("#getMsgBtn").removeAttr("disabled");//启用按钮
                         $("#getMsgBtn").removeClass("disabled");
                         $("#getMsgBtn").val('');
                         layer.msg('请点击获取验证码');
                     } else {
                         layer.msg('您输入的电话号码不对哦,电话号为' + phoneNum);
                     }
                 } else {
                     $("#getMsgBtn").attr("disabled", "disabled");//关闭按钮
                 }
        	});

            $("#getMsgBtn").click(function () {

                $.ajax({
                    type: "POST",
                    url: "json-lookup-vaild.html",
                    data: "params=" + $("#vphone").val() + "&ajax=true",
                    success: function (msg) {
                        layer.msg('验证码已发送，请注意查收。');
                        $('#vaild').val(msg);
                    }
                });

        		var times;
        		var time=60;
        		$(this).addClass("disabled");
        		$(this).val("倒计时"+time+"秒");
        		$(this).attr("disabled","disabled");
        		var _this=$(this);
                times = setInterval(function () {
        			time=time-1;
                    _this.val("倒计时"+time+"秒");
        			if(time==0){
        				clearInterval(times);
        				_this.removeClass("disabled");
        				_this.removeAttr("disabled");
        				_this.val('');
        			}
                }, 1000);
            });

            $('#vaildNum').on('blur', function () {

                var that = this;
                var inputvaild = $('#vaildNum').val();
                var vaild = $('#vaild').val();
                if (inputvaild != "" && inputvaild == vaild) {
                    layer.tips('OK,请您继续输入其他信息', that);
                    $('#proposerPhone').val($('#vphone').val());
                } else {
                    layer.tips('验证码不对哦，亲', that);
                }

            });

            $('#submitOk').on('click',function(){
                if(JqValidate()){
                    $("#iform").submit();
//                    alert('tijiao');
                }
            });

            function initMap(city){
            	// 百度地图API功能
            	map.centerAndZoom(city,15);
            	 $('#lat').val("");
                 $('#lng').val("");
            }

            $('#outpic').on('click',function (){
                new uploadPreview({ UpBtn: "outpic", DivShow: "divoutdoor", ImgShow: "imgoutdoor" ,ImgType:["jpg","png","bmp","jpeg"],callback:function(){
                    $('#outpicname').val($('#outpic').val());
                }});

            });
            $('#innerpic').on('click',function (){
                new uploadPreview({ UpBtn: "innerpic", DivShow: "divinnerdoor", ImgShow: "imginnerdoor" ,ImgType:["jpg","png","bmp","jpeg"],callback:function(){
                    $('#innerpicname').val($('#innerpic').val());
                }});

            });

            $('#licensepic').on('click',function (){
                new uploadPreview({ UpBtn: "licensepic", DivShow: "divlicense", ImgShow: "imglicense" ,ImgType:["jpg","png","bmp","jpeg"],callback:function(){
                    $('#licensepicname').val($('#licensepic').val());
                }});

            });


            $('#idcardf').on('click',function (){
                new uploadPreview({ UpBtn: "idcardf", DivShow: "divdcardf", ImgShow: "imgidcardf" ,ImgType:["jpg","png","bmp","jpeg"],callback:function(){
                    $('#idcardfname').val($('#idcardf').val());
                }});

            });
            $('#idcardb').on('click',function (){
                new uploadPreview({ UpBtn: "idcardb", DivShow: "dividcardb", ImgShow: "imgidcardb" ,ImgType:["jpg","png","bmp","jpeg"],callback:function(){
                    $('#idcardbname').val($('#idcardb').val());
                }});

            });
            function JqValidate()
            {
                if($('#iform :input[id=vphone]').val() == ""){
//                    layer.confirm($('#iform :input[id=landMark]').val());
                    layer.confirm('手机号不能为空');
                    return false;
                }
                if($('#iform :input[id=vaildNum]').val() == ""){
                    layer.confirm('验证码不能为空');
                    return false;
                }else{
                    if($('#iform :input[id=vaildNum]').val() != $('#iform :input[id=vaild]').val()){
                        layer.confirm('验证码不正确');
                        return false;
                    }
                }

                if($('#selProvince').val() == ""){
                    layer.confirm("请选择省份！");
                    return false;
                }

                if($('#selCity').val() == ""){
                    layer.confirm("请选择城市！");
                    return false;
                }
                if($('#selDistrict').val() == ""){
                    layer.confirm("请选择行政区！");
                    return false;
                }
                if($('#selOther').val() == ""){
                    layer.confirm("请选择商圈！");
                    return false;
                }


                if($('#iform :input[id=address]').val() == ""){
                    layer.confirm('请输入详细地址');
                    return false;
                }
                if($('#iform :input[id=lat]').val() == ""){
                    layer.confirm('请点击搜索标准定位您店铺的位置');
                    return false;
                }
                if($('#iform :input[id=name]').val() == ""){
                    layer.confirm('门店名不能为空');
                    return false;
                }
                if($('#iform :input[id=landMark]').val() == ""){
                    layer.confirm('请输入所在小区');
                    return false;
                }
                if($('#iform :input[id=tmCategoryId]').val() == ""){
                    layer.confirm('请选择商户类型');
                    return false;
                }
                if($('#iform :input[id=openBegin]').val() == ""){
                    layer.confirm('请选择营业开始时间');
                    return false;
                }
                if($('#iform :input[id=openEnd]').val() == ""){
                    layer.confirm('请选择营业结束时间');
                    return false;
                }
                if($('#iform :input[id=telephone]').val() == ""){
                    layer.confirm('请填写对外联系电话');
                    return false;
                }
                if($('#iform :input[id=outpic]').val() == ""){
                    layer.confirm('请选择要上传的门头照片');
                    return false;
                }
                if($('#iform :input[id=innerpic]').val() == ""){
                    layer.confirm('请选择要上传的店内照片');
                    return false;
                }
                if($('#iform :input[id=licensepic]').val() == ""){
               	 layer.confirm('请选择营业执照货房屋租赁协议照片');
                    return false;
                }
                if($('#iform :input[id=proposerName]').val() == ""){
                    layer.confirm('请填写签约人姓名');
                    return false;
                }
                if($('#iform :input[id=proposerPhone]').val() == ""){
                    layer.confirm('请填写签约人电话');
                    return false;
                }
                if($('#iform :input[id=card_type]').val() == ""){
                    layer.confirm('请选择证件类型');
                    return false;
                }
                if($('#iform :input[id=proposer_card_id]').val() == ""){
                    layer.confirm('请输入证件号码');
                    return false;
                }
                if($('#iform :input[id=idcardf]').val() == ""){
                    layer.confirm('请选择要上传的证件照片正面');
                    return false;
                }
                if($('#iform :input[id=idcardb]').val() == ""){
                    layer.confirm('请选择要上传的证件照片反面');
                    return false;
                }
                if(!document.getElementById("isnot").checked){
                    layer.confirm('请勾选确认签约！');
                    return false;
                }
                
                return true;
            };
            

        });
        
        function joinUs(){
         			layer.open({
                    type: 0,
                    title: '加盟协议',
                    area: ['800px', '360px'],
                    //btn: ['接受', '拒绝'],
                    shadeClose: false, //点击遮罩关闭
                    content: $('#confirm').html(),
                    yes: function (index, layero) {
                        //layer.msg('您已同意加盟协议，请填写加盟信息');
                        layer.close(index);
                        $("#isnot").attr("checked",true);
                    },
                    cancel: function (index) {
                        //layer.msg('您未同意加盟协议，回到首页');
                        //location.href = "/";
                    }
                });	
        }

    </script>
<link href="css/WdatePicker.css" rel="stylesheet" type="text/css">
<script charset="UTF-8" src="js/iframeWidget.js"></script>
<body><iframe style="display: none;" id="sina_anywhere_iframe"></iframe>
	


<style type="text/css">
.s_code_pickup {
	text-align: center;
	background-color: #fff;
	border-radius: 3px;
	position: fixed;
	width: 268px;
	height: auto;
	left: 806px;
	top: 34px;
	border: 1px solid #dddddd;
	box-shadow: 0 0 3px #ccc;
	padding:10px;
	z-index: 99999;
}
.s_code_pickup ul{ margin:0; padding: 0; height:160px; overflow-y:scroll;overflow-x:hidden; list-style:none;}
.s_code_pickup ul li{ height:auto; line-height:1.5;font-size:12px; color:#666; text-align:left; margin:0; padding:7px 10px 7px 10px; border-bottom:1px solid #eeeeee;} 
.s_code_pickup ul li a{text-decoration: none; color: #ff6600;}
.s_code_pickup ul li a:hover{color: #ff9900;}
</style>


<input id="h_userId" type="hidden">
<div id="pushMsgDiv" class="hide"></div>
 <div class="s_code_pickup" id="s_code_pickup" style="display:none">
            
            <ul id="s_code_pickup_id"> 
			
            </ul>
            
          </div>
<div id="header-top">
	<div id="header-top-content" class="clearfix">
		<div class="fll lh20">
			
				
					<div class="headerInfoBeforeLogin">宝，欢迎来到收货宝！</div>
				
				
			
		</div>
		<div class="flr">
			<ul>
				<li style="border-left: none"><a href="http://www.shouhuobao.com/" target="_blank">收货宝首页</a></li>
				
				<li style="border-right: medium none;">
					<!--  <script charset="utf-8"
						type="text/javascript"
						src="http://wpa.b.qq.com/cgi/wpa.php?key=XzkzODA0Nzc3Ml82MjIzNF80MDA3MzMzMzkwXw"></script>
					 -->
				</li>
			</ul>
		</div>
	</div>
</div>
<div id="header-logo" class="clearfix">
	
	<div class="fll">
		
			
				<a href="http://www.shouhuobao.com/merchant"><img alt="" src="image/merchant-logo.jpg"></a>
			
			
		
	</div>
	<div class="flr">

	</div>
	<input id="_merchantReceivePointId" value="" type="hidden"> <input id="merchantPhoneHidden" type="hidden">
</div>
<div id="maskLayer" class="modal-backdrop fade hide" style="z-index: 2000;">
	<img alt="" src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/loading-big.gif" style="left: 50%; margin-left: -62px; margin-top: 18%; position: absolute;">
</div>
<!-- 手机版下载 -->
<div class="modal hide fade" id="mobileDownloadWindow" style="width: 700px;">
	<div class="modal-header">
		<a class="close" data-dismiss="modal">×</a>
		<h3>手机版下载</h3>
	</div>
	<div class="modal-body" style="overflow: inherit;">
		<form class="bs-docs-example form-horizontal">
			<div class="alert alert-info mb20 cb">
				<p>
					<strong>商户中心手机版，无需开电脑，使用更方便！</strong> <a target="_blank" class="flr blue" href="http://www.shouhuobao.com/merchant/help/help-center.html?cat=Zero&amp;item=modify-phone">查看手机版使用帮助＞＞</a>
				</p>
			</div>
			<div class="fll mb20" style="width: 320px;">
				<ul>
					<li style="list-style-type: disc; height: 25px;">包裹签收，用户取件，新建快件等功能使用更便捷！</li>
					<li style="list-style-type: disc; height: 25px;">运单号无需输入，直接扫描二维码即可！</li>
					<li><img alt="" src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/phone_receive.jpg"></li>
					<li>店小三Android版</li>
				</ul>
			</div>
			<div class="flr mb20" style="width: 320px;">
				<ul>
					<li class="clearfix h30"><span class="botton_serial1"></span><b>扫描二维码，获取下载地址</b></li>
					<li class="clearfix"><div class="fll w100 ml20">
							<img alt="" src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/ewm.jpg">
						</div>
						<div class="flr w170">使用您手机上的条码扫描程序扫描下面的二维码，即可获得下载链接。</div></li>
					<li class="clearfix h30"><span class="botton_serial2"></span><b>填写手机号，短信获取下载地址</b></li>
					<li><input name="sss" placeholder="预制老板手机号" id="userPointPhone" class="ml20" disabled="disabled" type="text"> <input name="button" class="phonedownload ml10" style="width: 48px;" onclick="login.sendDownloadHref()" id="sendSuccess" value="发送" type="button">
						<br>
						<p class="red ml20 none" id="sendTips">已发送成功，请注意查收</p></li>
					<li class="clearfix h30"><span class="botton_serial3"></span><b>直接电脑下载，下载后手动安装</b></li>
					<li><a href="http://www.shouhuobao.com/file/app/dianxiaosan-android/PoseidonShop.apk" target="_blank" class="ml20 phonedownload">立即下载</a></li>
					<li><p class="ml20">下载安装文件后，通过数据线或者读卡器传输到手机存储卡中，在文件管理器中执行安装。</p></li>
				</ul>
			</div>
		</form>
	</div>
</div>
<div id="qrcodeModal" class="modal hide fade in" aria-hidden="false">
	<div class="modal-header">
		<a data-dismiss="modal" class="close">×</a>
		<h3>扫描关注官方微信</h3>
	</div>
	<div style="overflow: inherit; text-align: center;" class="modal-body">
		<img alt="" src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/qrcode_big.jpg" width="400px" height="400px">
	</div>
	<div class="modal-footer">
		<a data-dismiss="modal" class="btn" href="#">关闭</a>
	</div>
</div>

<!-- 支付弹出层 -->
<form id="payForm" action="pay-success-page.html" method="post">
	<div id="layer-pay" class="modal hide fade in" aria-hidden="false">
		<input name="orderId" id="accountNumberForPay" type="hidden">
		<div class="modal-header">
			<a id="btnCancel_pay" data-dismiss="modal" class="close">×</a>
			<h3>网上支付提示</h3>
		</div>
		<div class="recordInfo">
			
				<div class="control-group tac">支付完成前，请不要关闭此支付验证窗口</div>
				<div class="control-group tac">支付完成后，请根据您支付的情况点击下面按钮</div>
			
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-primary" id="pay_finish">支付完成</button>
			<a href="#" class="btn" id="pay_problem">支付遇到问题</a>
		</div>
	</div></form>

<!--  

-->
	<div class="header-top">
    <div class="com-w">
        <p class="h-wel"> 收货宝，社区物流与生活服务平台 </p>

        <div class="h-r">
            <ul>
                <li class="h-qq"><em></em>

                    <div class="qq-tanchu"><b></b>

                        <p> 收货宝在线客服 <br>
                            <span class="gray">4007333390</span></p>
                        <a onclick="javascript:window.open('http://b.qq.com/webc.htm?new=0&amp;sid=4007333390&amp;o=http://www.shouhuobao.com/&amp;q=7', '_blank', 'height=502, width=644,toolbar=no,scrollbars=no,menubar=no,status=no');">点击交谈</a>
                    </div>
                </li>
                <!--未关注-->
                <li class="h-sina"><em></em>

                    <div class="sina-tanchu"><b></b>

                        <p> 收货宝官方微博： <br>
                            <img src="image/logo1.png"></p>
                        <wb:follow-button uid="2137795655" type="red_1" width="67" height="24" class="gz2"><iframe src="htm/followbutton_002.htm" scrolling="no" marginheight="0" width="67" height="24" frameborder="0"></iframe></wb:follow-button>
                    </div>
                </li>
                <!--已关注-->
                <li class="h-sina" style="display:none;">
                    <div class="sina-followed">
                        <wb:follow-button uid="2137795655" type="red_1" width="67" height="24" class="gz3"><iframe src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/followbutton_002.htm" scrolling="no" marginheight="0" width="67" height="24" frameborder="0"></iframe></wb:follow-button>
                    </div>
                </li>
                <li class="h-tel"><em></em><img src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/tel.jpg"></li>
            </ul>
        </div>
    </div>
</div>
<div class="header-mid">
    <div class="com-w bh-posRlt">
        <div class="logo" id="logo">
            <p><a href="http://www.shouhuobao.com/index.html"><img src="image/Logo.jpg"></a></p>
        </div>
        <div class="menu">
            <ul>
                <ul>
                    <li> <a href="index.jsp">首页</a> </li>
			        <li> <a href="page/about">关于我们</a> </li>
			        <li class="on"> <a href="page/Login.jsp">商户中心</a> </li>
			        <li> <a href="#">帮助中心</a> </li>
			        <li> <a href="#">裹儿</a> </li>
                </ul>
            </ul>
        </div>
        <div class="navShow"></div>
        <div class="clearfix"></div>
    </div>
</div>
<div class="content">
    <div class="zln-banner_in"><a href=""> </a></div>
    <div class="zln-w970">
        <div class="zln-join">
            <div class="zln-join_in">
                <h4>请填写注册信息</h4>
                <!-- 流程块 -->
              <!--   <div class="zln-liuchen">
                    第一步 经过时有一个hover样式
                    <dl class="zln-hover">
                        <dt>
                        <div class="zln-dldl"><span>填写注册信息</span><font><img src="image/join_03.jpg" width="9" height="6"></font></div>
                        </dt>
                        <dd>
                            <div class="zln-yuan">
                                <div class="zln-yuan_img"></div>
                                <div class="zln-yuan_hover"></div>
                            </div>
                            <div class="zln-size"></div>
                        </dd>
                    </dl>
                    第二步
                    <dl>
                        <dt>
                        <div class="zln-dldl"><span>申请报名</span><font><img src="image/join_03.jpg" width="9" height="6"></font></div>
                        </dt>
                        <dd>
                            <div class="zln-yuan">
                                <div class="zln-yuan_img">
                                    <div class="zln-yuan_hover"></div>
                                </div>
                            </div>
                            <div class="zln-size">资格审核</div>
                        </dd>
                    </dl>
                    第三步
                    <dl>
                        <dt>
                        <div class="zln-dldl"><span>申请报名</span><font><img src="image/join_03.jpg" width="9" height="6"></font></div>
                        </dt>
                        <dd>
                            <div class="zln-yuan">
                                <div class="zln-yuan_img">
                                    <div class="zln-yuan_hover"></div>
                                </div>
                            </div>
                            <div class="zln-size">签约</div>
                        </dd>
                    </dl>

                    第四步
                    <dl>
                        <dt>
                        <div class="zln-dldl"><span>申请报名</span><font><img src="image/join_03.jpg" width="9" height="6"></font></div>
                        </dt>
                        <dd>
                            <div class="zln-yuan  bgno">
                                <div class="zln-yuan_img">
                                    <div class="zln-yuan_hover"></div>
                                </div>
                            </div>
                            <div class="zln-size">开通上线</div>
                        </dd>
                    </dl>
                </div> -->
                <form class="form-horizontal" action="merchant-add.html" method="post" id="iform" enctype="multipart/form-data">
                    <div class="f14 mt20">请您认真填写下列信息，有助于提供审核通过几率，谢谢您的认真填写</div>

                    <div class="zln-join_box zln-c">
                        <div class="zln-join_title"><span>验证信息</span><font></font></div>
                        <ul>
                            <li class="zln-li1"><span>手机号</span>
                                <input id="vphone" name="receivePointJoin.vphone" class="zln-text1" maxlength="11" type="text">
                                <input style="width: 99px" class="yzm-btn disabled" id="getMsgBtn" value="获取验证码" disabled="disabled" type="button">
                            </li>
                            <li class="zln-li1"><span>手机验证码</span>
                                <input class="zln-text1" id="vaildNum" name="vaildNum" maxlength="4" type="text">
                                <input id="vaild" name="vaild" type="hidden"></li>
                                
                              <li class="zln-li1"><span>登录密码</span>
                                <input class="zln-text1" id="vaildNum" name="vaildNum" maxlength="4" type="password">
                                <input id="vaild" name="vaild" type="hidden"></li>
                                
                                 <li class="zln-li1"><span>确认密码</span>
                                <input class="zln-text1" id="vaildNum" name="vaildNum" maxlength="4" type="password">
                                <input id="vaild" name="vaild" type="hidden"></li>
                            
                        </ul>
                    </div>
                  
                    <!-- 详细信息 -->
                    <div class="zln-join_box zln-c">
                        <div class="zln-join_title"><span>详细信息</span><font></font></div>
                        <ul>
                            <li class="zln-li1"><span>用户昵称</span>
                                <input id="proposerName" name="receivePointJoin.proposerName" class="zln-text1" type="text"> <font></font>
                            </li>
                             <li class="zln-li1"><span>用户性别</span>
                              &nbsp;<input type="radio" name="Sex" value="man" checked="checked"> &nbsp;男&nbsp;&nbsp;<input type="radio" name="Sex" value="womale"/>  &nbsp; 女
                               
                            </li>
                            <li class="zln-li1"><span>联系电话</span>
                                <input id="proposerPhone" name="receivePointJoin.proposerPhone" class="zln-text1" type="text"> <font></font>
                            </li>
                               <li class="zln-li1"><span>用户邮箱</span>
                                <input id="proposerPhone" name="receivePointJoin.proposerPhone" class="zln-text1" type="text"> <font></font>
                            </li>
                            
                           <!--  <li class="zln-li1"><span>证件类型</span>
                                <input name="receivePointJoin.card_type" id="card_type" type="hidden">

                                <div class="zln-select zln-selectb">
                                    <div class="zln-select_box">请选择</div>
                                    <div class="zln-select_fola" style="display: none;">
                                        <p>
                                            <a onclick="javascript:$('#card_type').attr('value','身份证');">身份证</a>
                                        </p>

                                        <p>
                                            <a onclick="javascript:$('#card_type').attr('value','护照');">护照</a>
                                        </p>
                                    </div>
                                </div>
                                <span class="last">证件号码</span>
                                <input id="proposer_card_id" name="receivePointJoin.proposerCardId" class="zln-text1" type="text"> <font></font>
                            </li> -->
                            <li class="zln-li1"> <span>用户头像<br>
                          <b class="need">(点我)</b></span>

                                <div class="zw">
                                    <input name="idcardf1" id="idcardf" style="display:none" onclick="" multiple="" type="file">
                                    <a href="" onclick="document.getElementById('idcardf').click();return false;"><div id="divdcardf"><img id="imgidcardf" src="image/zw.jpg"></div></a>
                                </div>
                          <!--   <span class="last">证件照片<br>
                                <b class="need">（背面）</b></span>

                                <div class="zw">
                                    <input name="idcardb1" id="idcardb" style="display:none" onclick="" multiple="" type="file">
                                    <a href="" onclick="document.getElementById('idcardb').click();return false;"><div id="dividcardb"><img id="imgidcardb" src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/zw.jpg"></div></a>
                                </div>
                                <div class="zln-c hint1">*像素要求必须为640*340像素，支持.jpg .jpeg .bmp .png格式，大小不超过5M</div> -->
                            </li>
                            <li class="zln-li1" style="padding-left:153px;color:#000;font-size:14px">
                                <input id="isnot" name="isnot" type="checkbox"> 同意协议 <a href="javascript:void(null)" onclick="joinUs();" style="color:#00f">点击查看协议条款&gt;&gt;</a>
                            </li>
                            <li class="zln-dtest zln-li1"><span>&nbsp;</span>

                                <div class="zln-libt_a">
                                	
                                    <input id="submitOk" value="完成注册" class="zln-button" type="button">

                                    <!-- 等待 -->
                                    

                                    <!-- 完成 -->
                                    
                                </div>
                            </li>
                        </ul>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>

<div class="back" style="display: none;"><a href="#logo"></a></div>
<div id="confirm" class="content" style="width: 800px; height: 600px; background-color: #FFFFFF; overflow: auto; display: none;">
    <h3 align="center"><strong>收货宝社区服务联盟</strong></h3>

    <h2 align="center">增值服务平台加入协议</h2>

    <p><strong>甲方：客恩瑞（北京）网络技术有限公司 （以下简称“甲方”）</strong><br>
        <strong>乙方：__________________________________（以下简称“乙方”）</strong>

    </p><p>&nbsp;&nbsp;&nbsp;&nbsp;收货宝是甲方建设、投资和运营的社区物流与生活服务平台（以下简称“收货宝平台”），
        致力于为有社区生活增值服务需求的个人或单位（以下简称“用户”）与提供增值服务的商户（以下简称“商户”）搭建第三方交易平台， 并提供相关的信息、管理等服务。
        同时，甲方为所有合作商户构建收货宝社区服务联盟（以下简称“收货宝联盟”），乙方希望正式加入收货宝平台并在该平台上开展相应的业务。 经甲乙双方友好协商， 就乙方加入收货宝平台开展相应业务等相关事宜订立如下一致协议：</p>
    <h4><strong>第一条 双方基本信息</strong></h4>

    <p>&nbsp;&nbsp;&nbsp;&nbsp;甲方系经工商行政管理局登记注册的合法法人，具有独立民事行为能力，能独立承担本协议全部的权利义务。 甲方有权授权甲方的关联公司处理与本协议相关的所有事项。<br>
        甲方的营业地址：北京市朝阳区小关北里甲2号渔阳置业大厦B403，<br> 电话: 010-59802933, 电子邮件:
        kf@shouhuobao.com，微信号：shouhuobao，甲方支付宝账户：alexluo@collectplus.cn
        甲方银行账户：户名：客恩瑞（北京）网络技术有限公司
        开户行：中国工商银行望京支行 账号：0200 0035 1900 0186 638
        乙方系具有独立民事行为能力的法人或个人，能独立承担本协议全部的权利义务。</p>
    <h4><strong>第二条 双方合作内容及合作条件</strong></h4>

    <p>1、合作内容：乙方门店申请成为甲方授权的增值服务网点, 自愿为其潜在用户提供社区增值生活服务或开展社区电子商务业务；<br>
        2、合作条件：<br>
        2.1、乙方需提供具备实时上网条件的智能手机、平板或电脑；<br>
        2.2、乙方必须具备独立存放包裹的货架或场所，并按要求张贴相关标识；<br>
        2.3、乙方的营业时间需至少满足每日09:00—21:00的正常营业时间；<br>
        2.4、乙方必须具备和提供冷藏/冷冻设备存放需低温保存的包裹或商品;<br>
        2.5、乙方在甲方平台系统产生服务费时，甲方可先行扣除500元作为合作保证金并予以冻结，当系统余额超过500元时，超额部分乙方可以根据实际情况提现。冻结的保证金，在双方合作结束且无异议时退还。</p>
    <h4><strong>第三条 收益与结算</strong></h4>

    <p>1. 在本协议有效期内，通过甲乙方双方的共同努力，达到促进乙方收益的持续增长（详见附件二）；<br>
        2. 收益结算方式：<br>
        &nbsp;&nbsp;&nbsp;&nbsp; a)每月18日（遇法定节假日顺延），甲方在系统中公布乙方前一个月的结算账单，并将账单对应的服务费用加入乙方在系统中的账户。<br>
        &nbsp;&nbsp;&nbsp;&nbsp;
        b)乙方在系统中申请将服务费支付至指定的结算银行账户中，甲方将扣除相应的税金(乙方提供与本商户名称一致的服务费发票的除外)及转账手续费，同一提现人有多个合作网点将按税务局规定依当月累计提现总额计税。<br>
        &nbsp;&nbsp;&nbsp;&nbsp; c)甲方将会在申请后5个工作日内，对已提交的支付申请进行审核；如审核通过，将在5个工作日内向银行提请支付。具体到账时间以各银行规定为准。<br>
        3.
        
乙方应妥善保管甲方提供的平台账户和密码，并对账户和密码的安全，以及对通过乙方的账户和密码实施的行为/操作负责。如果发现任何人不当使用您的账户或有
任何其他可能危及您的账户安全的情形时，您应当立即以有效方式通知甲方，要求甲方暂停相关服务，甲方对在采取行动前已经产生的后果不承担责任。
    </p>
    <h4><strong>第四条 甲方的权利与义务</strong></h4>

    <p>1、甲方负责提供自身研发的收货宝平台及终端应用软件（以下简称“系统”）， 并负责系统的定期维护与更新，保证其良好的工作状态。<br>
        2、甲方将协助乙方进行增值业务的宣传、推广，并设立专职客服，协助乙方解决相关问题。<br>
        3、甲方将根据乙方的业务情况与乙方的选择逐步开通增值业务。<br>
        4、甲方将为乙方在收货宝平台上建立宣传平台，供乙方发布打折、促销、招聘等信息。但乙方必须确保发布信息的真实性、合法性，否则甲方有权删除并追究乙方的法律责任。<br>
        5、甲方有权在收货宝平台上更新与商户有关的协议、条款或收益标准，若乙方不接受该等更新即视为乙方提前解除本协议并退出收货宝平台。 <br>
        6、甲方有权为符合其评估条件的门店配备相应的展示物料，乙方应予以配合。</p>
    <h4><strong>第五条 乙方的权利与义务</strong></h4>

    <p>1、在本协议约定的期限内，乙方不得与其他公司或个人再签订与本协议类似的协议或文件，不得以任何形式再加入任何与收货宝平台类似的增值服务平台，一经发现，甲方有权立即中止合作并扣除账户所有余额。<br>
        2、乙方应积极向用户宣传与推广开通的增值服务，利用自有资源开展更多的延展性服务。<br>
        3、若乙方开通的增值服务中涉及货物实体的存放，自乙方签收货物之时起至货物被用户或快递取走之时止（即“保管期内”）,乙方应当妥善保管货物并确保其安全，以系统中完成全部流程的订单为结算依据。<br>
        4、乙方应严格按照甲方的要求在经营场所悬挂统一字样的标识，甲方将根据乙方业务的开展情况提供有偿或无偿的业务物料及宣传品，但物料送至乙方的运输费用由乙方承担。<br>
        5、乙方必须保证严格按照甲方提供的操作手册或网站操作指引执行； <br>
        6、乙方有权向甲方申请相应的基础物料，甲方将根据乙方业务的开展情况提供有偿或无偿的业务物料及宣传品，但物料送至乙方的运输费用由乙方承担。</p>
    <h4><strong>第六条 违约责任</strong></h4>

    <p>任何一方均不得违反本协议的约定，否则对方有权要求违约方限期改正，逾期仍未改正的，对方有权解除本协议并追究其违约责任。常见的违约情况包含但不限于如下列表：<br>
        违约情况&nbsp;&nbsp;&nbsp;&nbsp; 违约及赔偿责任<br>
        货物丢失&nbsp;&nbsp;&nbsp;&nbsp; 货物的实际价值<br>
        临时暂停服务而未提前通知甲方 首次警告，再次罚款100元<br>
        人为损坏设备或物料&nbsp;&nbsp;&nbsp;&nbsp; 按设备或物料的实际价值进行赔偿<br>
        弄虚作假、伪造订单等行为&nbsp;&nbsp;&nbsp;&nbsp; 首次扣除所有虚假订单收益，再次以当月服务费用作为罚款<br>
        擅自向用户重复收费或多收费 &nbsp;&nbsp;&nbsp;&nbsp; 首次罚款50元，再次以当月服务费用作为罚款</p>
    <h4><strong>第七条 续约与解约</strong></h4>

    <p>1、本协议有效期三年，双方完成签署后自甲方审核通过并开通运营之日起正式生效。协议期满双方均未提出异议时，本协议自动延续。<br>
        2、甲乙双方均有权提前30日书面通知对方解除本协议，协议自一方发出书面通知之日起第30日即解除；<br>
        3、若出现以下情形之一，甲方有权书面通知乙方解除本协议并不予结算相关费用：<br>
        &nbsp;&nbsp;&nbsp;&nbsp; a)乙方存在非法侵占、擅自拆开、擅自使用用户货物的行为。<br>
        &nbsp;&nbsp;&nbsp;&nbsp; b)乙方变更经营地址而未通知甲方。<br>
        &nbsp;&nbsp;&nbsp;&nbsp; c)乙方单方面停止合作而未通知甲方。<br>
        &nbsp;&nbsp;&nbsp;&nbsp; d)乙方同时与收货宝平台类似的增值服务提供商合作。<br>
        &nbsp;&nbsp;&nbsp;&nbsp; e)乙方存在弄虚作假、伪造订单等行为达到3次及以上。<br>
        4、合作终止后,双方应在15个工作日内结清所有往来款项和货物，且乙方应销毁甲方所有标志和宣传资料。 </p>
    <h4><strong>第八条 特别条款</strong></h4>

    <p>
        双方确认，甲方并不从事增值服务业务，而仅仅是为用户及商户提供第三方技术平台。乙方与甲方不存在加盟关系，不是甲方的经营网点，与甲方亦不存在隶属关系、雇佣关系或挂靠关系。双方各自经济上独立核算，法律上独立承担责任，税赋各自承担。</p>
    <h4><strong>第九条 附则</strong></h4>

    <p>1、本协议以及本协议履行过程中一切相关资料应当进行严格的保密。</p>
    <p></p>
</div>
	

<div class="footer">
    <div class="com-w">
        
       <div class="copyRight bh-overf">
            <p><span>©2011-2015 Shouhuobao.com 版权所有</span><span class="copyright-icp">京ICP证110890号   京ICP备11018594号-1<b>京公网安备编号：110105013415</b></span>
                <span class="copyAddress">公司地址：北京市朝阳区小关北里甲2号渔阳置业大厦B403室</span></p>
            <img src="image/copyRight.jpg" class="bh-fr"></div>
    </div>
</div>
<script type="text/javascript" src="js/map.js"></script>
<script type="text/javascript" src="js/tripledes.js"></script>
<script type="text/javascript" src="js/jquery_003.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/bootstrap-select.js"></script>
<script type="text/javascript" src="js/ajax.js"></script>
<script type="text/javascript" src="js/appbuilder.js"></script>
<script type="text/javascript" src="js/global.js"></script>
<script type="text/javascript" src="js/subTabSwitch.js"></script>
<script type="text/javascript" src="js/validate.js"></script>
<script type="text/javascript" src="js/login.js"></script>
<script type="text/javascript" src="js/WdatePicker.js"></script>
<script type="text/javascript" src="js/jquery_004.js"></script>
<script type="text/javascript" src="js/jquery_002.js"></script>
<script type="text/javascript" src="js/base.js"></script>
<script type="text/javascript" src="js/qrcode.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>


<script type="text/javascript">
	app.ctx = '/merchant';
	app.staticUrlPrefix = '/merchant';
	var __currentLoginUserIno = '';
	
	
</script>
<script type="text/javascript">
	/**
	百度统计* 
	 */
	var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://"
			: " http://");
	document
			.write(unescape("%3Cscript src='"
					+ _bdhmProtocol
					+ "hm.baidu.com/h.js%3F450f34e18b8751446775cba4abdb88c2' type='text/javascript'%3E%3C/script%3E"));
</script><script src="js/h.js" type="text/javascript"></script><a href="http://tongji.baidu.com/hm-web/welcome/ico?s=450f34e18b8751446775cba4abdb88c2" target="_blank"><img src="image/21.gif" width="20" height="20" border="0"></a>
	<script type="text/javascript">
		$(document).ready(function() {
			if ($('#_merchantReceivePointId').val() == "") {
				$(".headerInfoAfterLogin").hide();
			}
		});
	</script>

 <div id="_my97DP" style="position: absolute; top: -1970px; left: -1970px;">
 <iframe style="width: 186px; height: 198px;" src="htm/My97DatePicker.htm" border="0" scrolling="no" frameborder="0"></iframe></div>
</body></html> 