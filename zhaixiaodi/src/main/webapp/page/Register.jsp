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
            $(document).on("click",".zln-select_fola p",
                    function() {
                        $(this).parent().prev().html($(this).find("a").html());
                        if($(this).index()==0){
                            $(this).parent().prev().css({"color":"#c6ccd2"});
                        }
                        else{
                            $(this).parent().prev().css({"color":"#666"});
                        }
                        if ($(this).parent().attr("id") == "shengCon") {
                            $("#shengCon").prev(".zln-select_box").attr("_title", $(this).find("a").attr("_title"));
                            $("#selProvince").val($(this).find("a").attr("_title"));
                            $("#selProvince").trigger("change");
                        }
                        if ($(this).parent().attr("id") == "shiCon") {
                            $("#shiCon").prev(".zln-select_box").attr("_title", $(this).find("a").attr("_title"));
                            $("#selCity").val($(this).find("a").attr("_title"));
                            $("#selCity").trigger("change");
                        }
                        if ($(this).parent().attr("id") == "quCon") {
                            $("#quCon").prev(".zln-select_box").attr("_title", $(this).find("a").attr("_title"));
                            $("#quCon").prev(".zln-select_box").attr("_haschild", $(this).find("a").attr("_haschild"));
                            $("#selDistrict").val($(this).find("a").attr("_title"));
                            $("#selDistrict").trigger("change");
                            if($("#quCon").prev().attr("_haschild")&&$("#quCon").prev().attr("_haschild")==1){
                                $(".address-text").css({"margin-top":"10px","margin-left":"144px"});
                                $(".address-btn").css({"margin-top":"10px"});
                            }
                            else{
                                $(".address-text").css({"margin-top":"0","margin-left":"10px"});
                                $(".address-btn").css({"margin-top":"0"});
                            }
                        }
                        if ($(this).parent().attr("id") == "otherCon") {
                            $("#shiCon").prev(".zln-select_box").attr("_title", $(this).find("a").attr("_title"));
                            $("#selOther").val($(this).find("a").attr("_title"));

                        }
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
<link href="css/WdatePicker.css" rel="stylesheet" type="text/css"><script charset="UTF-8" src="js/iframeWidget.js"></script><style type="text/css">.BMap_mask{background:transparent url(http://api0.map.bdimg.com/images/blank.gif);}.BMap_noscreen{display:none;}.BMap_button{cursor:pointer;}.BMap_zoomer{background-image:url(http://api0.map.bdimg.com/images/mapctrls1d3.gif);background-repeat:no-repeat;overflow:hidden;font-size:1px;position:absolute;width:7px;height:7px;}.BMap_stdMpCtrl div{position:absolute;}.BMap_stdMpPan{width:44px;height:44px;overflow:hidden;background:url(http://api0.map.bdimg.com/images/mapctrls2d0.png) no-repeat;}.BMap_ie6 .BMap_stdMpPan{background:none;}.BMap_ie6 .BMap_smcbg{left:0;width:44px;height:464px;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src="http://api0.map.bdimg.com/images/mapctrls2d0.png");}.BMap_ie6 .BMap_stdMpPanBg{z-index:-1;}.BMap_stdMpPan .BMap_button{height:15px;width:15px;}.BMap_panN,.BMap_panW,.BMap_panE,.BMap_panS{overflow:hidden;}.BMap_panN{left:14px;top:0;}.BMap_panW{left:1px;top:12px;}.BMap_panE{left:27px;top:12px;}.BMap_panS{left:14px;top:25px;}.BMap_stdMpZoom{top:45px;overflow:hidden;}.BMap_stdMpZoom .BMap_button{width:22px;height:21px;left:12px;overflow:hidden;background-image:url(http://api0.map.bdimg.com/images/mapctrls2d0.png);background-repeat:no-repeat;z-index:10;}.BMap_ie6 .BMap_stdMpZoom .BMap_button{background:none;}.BMap_stdMpZoomIn{background-position:0 -221px;}.BMap_stdMpZoomOut{background-position:0 -265px;}.BMap_ie6 .BMap_stdMpZoomIn div{left:0;top:-221px;}.BMap_ie6 .BMap_stdMpZoomOut div{left:0;top:-265px;}.BMap_stdMpType4 .BMap_stdMpZoom .BMap_button{left:0;overflow:hidden;background:-webkit-gradient(linear,50% 0,50% 100%,from(rgba(255,255,255,0.85)),to(rgba(217,217,217,0.85)));z-index:10;-webkit-border-radius:22px;width:34px;height:34px;border:1px solid rgba(255,255,255,0.5);-webkit-box-shadow:0 2px 3.6px #CCC;display:-webkit-box;-webkit-box-align:center;-webkit-box-pack:center;-webkit-box-sizing:border-box;}.BMap_stdMpType4 .BMap_smcbg{position:static;background:url(http://api0.map.bdimg.com/images/mapctrls2d0_mb.png) 0 0 no-repeat;-webkit-background-size:24px 32px;}.BMap_stdMpType4 .BMap_stdMpZoomIn{background-position:0 0;}.BMap_stdMpType4 .BMap_stdMpZoomIn .BMap_smcbg{width:24px;height:24px;background-position:0 0;}.BMap_stdMpType4 .BMap_stdMpZoomOut{background-position:0 0;}.BMap_stdMpType4 .BMap_stdMpZoomOut .BMap_smcbg{width:24px;height:6px;background-position:0 -25px;}.BMap_stdMpSlider{width:37px;top:18px;}.BMap_stdMpSliderBgTop{left:18px;width:10px;overflow:hidden;background:url(http://api0.map.bdimg.com/images/mapctrls2d0.png) no-repeat -23px -226px;}.BMap_stdMpSliderBgBot{left:19px;height:8px;width:10px;top:124px;overflow:hidden;background:url(http://api0.map.bdimg.com/images/mapctrls2d0.png) no-repeat -33px bottom;}.BMap_ie6 .BMap_stdMpSliderBgTop,.BMap_ie6 .BMap_stdMpSliderBgBot{background:none;}.BMap_ie6 .BMap_stdMpSliderBgTop div{left:-23px;top:-226px;}.BMap_ie6 .BMap_stdMpSliderBgBot div{left:-33px;bottom:0;}.BMap_stdMpSliderMask{height:100%;width:24px;left:10px;cursor:pointer;}.BMap_stdMpSliderBar{height:11px;width:19px;left:13px;top:80px;overflow:hidden;background:url(http://api0.map.bdimg.com/images/mapctrls2d0.png) no-repeat 0 -309px;}.BMap_stdMpSliderBar.h{background:url(http://api0.map.bdimg.com/images/mapctrls2d0.png) no-repeat 0 -320px;}.BMap_ie6 .BMap_stdMpSliderBar,.BMap_ie6 .BMap_stdMpSliderBar.h{background:none;}.BMap_ie6 .BMap_stdMpSliderBar div{top:-309px;}.BMap_ie6 .BMap_stdMpSliderBar.h div{top:-320px;}.BMap_zlSt,.BMap_zlCity,.BMap_zlProv,.BMap_zlCountry{position:absolute;left:34px;height:21px;width:28px;background-image:url(http://api0.map.bdimg.com/images/mapctrls2d0.png);background-repeat:no-repeat;font-size:0;cursor:pointer;}.BMap_ie6 .BMap_zlSt,.BMap_ie6 .BMap_zlCity,.BMap_ie6 .BMap_zlProv,.BMap_ie6 .BMap_zlCountry{background:none;overflow:hidden;}.BMap_zlHolder{display:none;position:absolute;top:0;}.BMap_zlHolder.hvr{display:block;}.BMap_zlSt{background-position:0 -380px;top:21px;}.BMap_zlCity{background-position:0 -401px;top:52px;}.BMap_zlProv{background-position:0 -422px;top:76px;}.BMap_zlCountry{background-position:0 -443px;top:100px;}.BMap_ie6 .BMap_zlSt div{top:-380px;}.BMap_ie6 .BMap_zlCity div{top:-401px;}.BMap_ie6 .BMap_zlProv div{top:-422px;}.BMap_ie6 .BMap_zlCountry div{top:-443px;}.BMap_stdMpType1 .BMap_stdMpSlider,.BMap_stdMpType2 .BMap_stdMpSlider,.BMap_stdMpType3 .BMap_stdMpSlider,.BMap_stdMpType4 .BMap_stdMpSlider,.BMap_stdMpType2 .BMap_stdMpZoom,.BMap_stdMpType3 .BMap_stdMpPan,.BMap_stdMpType4 .BMap_stdMpPan{display:none;}.BMap_stdMpType3 .BMap_stdMpZoom{top:0;}.BMap_stdMpType4 .BMap_stdMpZoom{top:0;}.BMap_cpyCtrl a{font-size:11px;color:#7979CC;}.BMap_scaleCtrl{height:23px;overflow:hidden;}.BMap_scaleCtrl div.BMap_scaleTxt{font-size:11px;font-family:Arial,sans-serif;}.BMap_scaleCtrl div{position:absolute;overflow:hidden;}.BMap_scaleHBar img,.BMap_scaleLBar img,.BMap_scaleRBar img{position:absolute;width:37px;height:442px;left:0;}.BMap_scaleHBar{width:100%;height:5px;font-size:0;bottom:0;}.BMap_scaleHBar img{top:-437px;width:100%;}.BMap_scaleLBar,.BMap_scaleRBar{width:3px;height:9px;bottom:0;font-size:0;z-index:1;}.BMap_scaleLBar img{top:-427px;left:0;}.BMap_scaleRBar img{top:-427px;left:-5px;}.BMap_scaleLBar{left:0;}.BMap_scaleRBar{right:0;}.BMap_scaleTxt{text-align:center;width:100%;cursor:default;line-height:18px;}.BMap_omCtrl{background-color:#fff;overflow:hidden;}.BMap_omOutFrame{position:absolute;width:100%;height:100%;left:0;top:0;}.BMap_omInnFrame{position:absolute;border:1px solid #999;background-color:#ccc;overflow:hidden;}.BMap_omMapContainer{position:absolute;overflow:hidden;width:100%;height:100%;left:0;top:0;}.BMap_omViewMv{border-width:1px;border-style:solid;border-left-color:#84b0df;border-top-color:#adcff4;border-right-color:#274b8b;border-bottom-color:#274b8b;position:absolute;z-index:600;}.BMap_omViewInnFrame{border:1px solid #3e6bb8;}.BMap_omViewMask{width:1000px;height:1000px;position:absolute;left:0;top:0;background-color:#68c;opacity:.2;filter:progid:DXImageTransform.Microsoft.Alpha(opacity=20);}.BMap_omBtn{height:13px;width:13px;position:absolute;cursor:pointer;overflow:hidden;background:url(http://api0.map.bdimg.com/images/mapctrls1d3.gif) no-repeat;z-index:1210;}.anchorBR .BMap_omOutFrame{border-top:1px solid #999;border-left:1px solid #999;}.quad4 .BMap_omBtn{background-position:-26px -27px;}.quad4 .BMap_omBtn.hover{background-position:0 -27px;}.quad4 .BMap_omBtn.BMap_omBtnClosed{background-position:-39px -27px;}.quad4 .BMap_omBtn.BMap_omBtnClosed.hover{background-position:-13px -27px;}.anchorTR .BMap_omOutFrame{border-bottom:1px solid #999;border-left:1px solid #999;}.quad1 .BMap_omBtn{background-position:-39px -41px;}.quad1 .BMap_omBtn.hover{background-position:-13px -41px;}.quad1 .BMap_omBtn.BMap_omBtnClosed{background-position:-26px -41px;}.quad1 .BMap_omBtn.BMap_omBtnClosed.hover{background-position:0 -41px;}.anchorBL .BMap_omOutFrame{border-top:1px solid #999;border-right:1px solid #999;}.quad3 .BMap_omBtn{background-position:-27px -40px;}.quad3 .BMap_omBtn.hover{background-position:-1px -40px;}.quad3 .BMap_omBtn.BMap_omBtnClosed{background-position:-40px -40px;}.quad3 .BMap_omBtn.BMap_omBtnClosed.hover{background-position:-14px -40px;}.anchorTL .BMap_omOutFrame{border-bottom:1px solid #999;border-right:1px solid #999;}.quad2 .BMap_omBtn{background-position:-40px -28px;}.quad2 .BMap_omBtn.hover{background-position:-14px -28px;}.quad2 .BMap_omBtn.BMap_omBtnClosed{background-position:-27px -28px;}.quad2 .BMap_omBtn.BMap_omBtnClosed.hover{background-position:-1px -28px;}.anchorR .BMap_omOutFrame{border-bottom:1px solid #999;border-left:1px solid #999;border-top:1px solid #999;}.anchorL .BMap_omOutFrame{border-bottom:1px solid #999;border-right:1px solid #999;border-top:1px solid #999;}.anchorB .BMap_omOutFrame{border-top:1px solid #999;border-left:1px solid #999;border-right:1px solid #999;}.anchorT .BMap_omOutFrame{border-bottom:1px solid #999;border-right:1px solid #999;border-left:1px solid #999;}.anchorNon .BMap_omOutFrame,.withOffset .BMap_omOutFrame{border:1px solid #999;}.BMap_zoomMask0,.BMap_zoomMask1{position:absolute;left:0;top:0;width:100%;height:100%;background:transparent url(http://api0.map.bdimg.com/images/blank.gif);z-index:1000;}.BMap_contextMenu{position:absolute;border-top:1px solid #adbfe4;border-left:1px solid #adbfe4;border-right:1px solid #8ba4d8;border-bottom:1px solid #8ba4d8;padding:0;margin:0;width:auto;visibility:hidden;background:#fff;z-index:10000000;}.BMap_cmShadow{position:absolute;background:#000;opacity:.3;filter:alpha(opacity=30);visibility:hidden;z-index:9000000;}div.BMap_cmDivider{border-bottom:1px solid #adbfe4;font-size:0;padding:1px;margin:0 6px;}div.BMap_cmFstItem{margin-top:2px;}div.BMap_cmLstItem{margin-bottom:2px;}.BMap_shadow img{border:0 none;margin:0;padding:0;height:370px;width:1144px;}.BMap_pop .BMap_top{border-top:1px solid #ababab;background-color:#fff;}.BMap_pop .BMap_center{border-left:1px solid #ababab;border-right:1px solid #ababab;background-color:#fff;}.BMap_pop .BMap_bottom{border-bottom:1px solid #ababab;background-color:#fff;}.BMap_shadow,.BMap_shadow img,.BMap_shadow div{-moz-user-select:none;-webkit-user-select:none;}.BMap_checkbox{background:url(http://api0.map.bdimg.com/images/mapctrls1d3.gif);vertical-align:middle;display:inline-block;width:11px;height:11px;margin-right:4px;background-position:-14px 90px;}.BMap_checkbox.checked{background-position:-2px 90px;}.BMap_pop .BMap_top img,.BMap_pop .BMap_center img,.BMap_pop .BMap_bottom img{display:none;}@media print{.BMap_noprint{display:none;}.BMap_noscreen{display:block;}.BMap_mask{background:none;}.BMap_pop .BMap_top img,.BMap_pop .BMap_center img,.BMap_pop .BMap_bottom img{display:block;}}.BMap_vectex{cursor:pointer;width:11px;height:11px;position:absolute;background-repeat:no-repeat;background-position:0 0;}.BMap_vectex_nodeT{background-image:url(http://api0.map.bdimg.com/images/nodeT.gif);}.BMap_vectex_node{background-image:url(http://api0.map.bdimg.com/images/node.gif);}.iw{width:100%;-webkit-box-sizing:border-box;border:.3em solid transparent;-webkit-background-clip:padding;}.iw_rt{position:relative;height:46px;width:195px;-webkit-box-sizing:border-box;display:-webkit-box;-webkit-box-align:center;margin:2px 5px 0 2px;background-color:rgba(0,0,0,0.8);-webkit-box-shadow:2px 2px 7px rgba(0,0,0,0.3);-webkit-border-radius:2px;color:#fff;}.iw_rt:after{content:"";position:absolute;left:50%;bottom:-8px;width:0;height:0;border-left:5px solid transparent;border-top:8px solid rgba(0,0,0,0.8);border-right:5px solid transparent;margin:0 0 0 -6px;}.iw_s{text-align:center;vertical-align:middle;height:100%;-webkit-box-sizing:border-box;}.iw_rt .iw_s1{color:#cbcbcb;}.iw_rt b{color:#fff;font-weight:bold;}.iw_rt_gr{margin-left:-4px;}.iw_busline{margin:32px 0 0 -3px;}.iw_busline .iw_cc{text-align:center;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;padding:0 6px;}.iw_r{-webkit-box-ordinal-group:3;}.iw_r,.iw_l{height:100%;font-size:4.5em;text-align:center;color:#747474;border:none;-webkit-box-sizing:border-box;-webkit-border-radius:0;line-height:.7em;border:1px solid rgba(255,255,255,0.2);width:41px;}.iw_r{border-style:none none none solid;}.iw_l{border-style:none solid none none;}.iw_search,.iw_l{background:url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACYAAAAlCAYAAAAuqZsAAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJ bWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdp bj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6 eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMC1jMDYwIDYxLjEz NDc3NywgMjAxMC8wMi8xMi0xNzozMjowMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJo dHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlw dGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAv IiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RS ZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpD cmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNSBNYWNpbnRvc2giIHhtcE1NOkluc3RhbmNl SUQ9InhtcC5paWQ6QjA3NjMyREJDNzQ2MTFFMTlBQUM5QzlCRDZGODZCQkYiIHhtcE1NOkRvY3Vt ZW50SUQ9InhtcC5kaWQ6QjA3NjMyRENDNzQ2MTFFMTlBQUM5QzlCRDZGODZCQkYiPiA8eG1wTU06 RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDpCMDc2MzJEOUM3NDYxMUUxOUFB QzlDOUJENkY4NkJCRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDpCMDc2MzJEQUM3NDYxMUUx OUFBQzlDOUJENkY4NkJCRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1w bWV0YT4gPD94cGFja2V0IGVuZD0iciI/PllB9T8AAAKuSURBVHjaxFjRcdpAEAX+mVEqiFxB5AoQ HZAKElcArsBWBSgVQCoAVwCuwEoFlivwGQpI7jKrzGXn7ep0EsPO7BjLp/O73bdv9xifTqdRpCXW c+sz65n1lNy3mvzZemX9aN34C6bTKdx8HAHMgVlaX0QeaGv9J4EcBJgD9EA/hzAH7N4Cq/oAW1tf KX+vKEXP7PlMSLFvhQX32BWY49GBOIRO7FKy57wBlnoUQHu5yJX+g4mymdvgFWzkAM3JtwGgmiJw a2/pvQoEYBQCLKNI8RfuaeNjT245gAUdqgHdmkqUPiOctLdJVYkithkAVO/K5cC+M30KAZVSxboo /ybnn1eIR5r5qUyI7P4GX6nqJHskbQsxQ7wqu6aSn2qrgHLrXjqAat5ZC0WlRuzVE0J3uhtBCjRt a3qjX92JIMiOIqYtYgumzpo+7RRtu/E0zvknokMF5GgdQv4Ze/5DWL8CFVe2aNuedGsLCi1vS+WL F4WKNkL2Dnh414FnO1b1R5vKuRaxjKUF2YKBqjuCGtF6nyL5+XxOJWCcL2/CpjzdRYRuGpDShQQs ARUj9U/OnRh7Yr9/CW1JXU4fYxXoHIMCu+iB+gBLIt/LgShDYCYktGCDfCBgvyRgVQgZwTy/jIzy EnQNMZV1QCT4bJ+3XFCkS81/WijdkiYAdSak04BWtabWEmIbsNZYgU00YE+gjyErQeo31GpShVMH Yc+/dwsEzh97/D6ojT2ZMlM1XwN8WP9Ma7NAbZvbtBoEjE+jBT2TusCu5SIbI7z/wLWN1rdKi0o6 cqwTuAmYyTm5NQW/82atWvlnBbo7apxD98qDJxl7mkC76JQ2Qm0CI1xKF95Gb4oLXHJDwJlxjy/u LgruGtNFM8lqnNtfK2JqN3CVeW1gzWj9jThd0xd59R8BBgAAiefGO1Bt1gAAAABJRU5ErkJggg==") no-repeat 50% 50%;-webkit-background-size:19px 19px;}.iw_line_s,.iw_r{background:url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACUAAAAmCAYAAABDClKtAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJ bWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdp bj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6 eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMC1jMDYwIDYxLjEz NDc3NywgMjAxMC8wMi8xMi0xNzozMjowMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJo dHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlw dGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAv IiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RS ZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpD cmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNSBNYWNpbnRvc2giIHhtcE1NOkluc3RhbmNl SUQ9InhtcC5paWQ6QjA3NjMyREZDNzQ2MTFFMTlBQUM5QzlCRDZGODZCQkYiIHhtcE1NOkRvY3Vt ZW50SUQ9InhtcC5kaWQ6QjA3NjMyRTBDNzQ2MTFFMTlBQUM5QzlCRDZGODZCQkYiPiA8eG1wTU06 RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDpCMDc2MzJEREM3NDYxMUUxOUFB QzlDOUJENkY4NkJCRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDpCMDc2MzJERUM3NDYxMUUx OUFBQzlDOUJENkY4NkJCRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1w bWV0YT4gPD94cGFja2V0IGVuZD0iciI/PqheQ+MAAAEtSURBVHja7JftDYIwEIbB8JeEUXACZQPd oGygE+gGxAnQEZzAOgEdwREIDKBXUgjBIqW5Npj0kvcHpG0erveFX1WVZ8l2oBhEhRoLw/BroW8J KgeR3vMVlI5BrSwAHQZAnngmYxtMe4oIL41ZAp6iNqF4/BQTa0oBxmxAcaAHKFJY+wKtAaw0CRUJ oHjGHiY8VpqCKmYCdRkJUKmJ7Ms1gZqkqOs6w/bUGXRCOGePCcXjaItwDsW8PoZ0zhM70IeeyiZi jH/Isf+CF9MAOdCppDj+LJ6yim6j9802B6VqQa818BFjY6AHakHp9Crj15ctCaiFIi7Q/wCKLRHq vjSoVNKWunH4rTBDv5Cv7NKeKfvvU2nINzHAuexzUA7KQTkoB6UxDicKvc+qfQQYABaiUBxugCsr AAAAAElFTkSuQmCC") no-repeat 50% 50%;-webkit-background-size:19px 19px;}.iw_line{height:64px;width:228px;padding:0 11px;line-height:20px;}.iw_bustrans .iw_cc{text-align:center;}.iw_c{color:#FFFFFF;text-decoration:none;overflow:hidden;display:-webkit-box;-webkit-box-align:center;-webkit-box-flex:1;}.iw_cc{-webkit-box-sizing:border-box;width:100%;border:none;}.gray_background{filter:alpha(opacity=50);-moz-opacity:0.5;-khtml-opacity:0.5;opacity: 0.5} .light_gray_background {filter:alpha(opacity=70);-moz-opacity:0.7;-khtml-opacity:0.7;opacity: 0.7} .panoInfoBox {cursor: pointer; } .panoInfoBox {position: relative; width: 323px; height: 101px; margin-bottom: 4px; cursor: pointer; } .panoInfoBox .panoInfoBoxTitleBg {width: 323px; height: 19px; position: absolute; left: 0; bottom: 0; z-index: 2; background-color: #000; opacity: .7; } .panoInfoBox .panoInfoBoxTitleContent {font-size: 12px; color: #fff; position: absolute; bottom: 2px; left: 5px; z-index: 3; text-decoration: none; } .RouteAddressOuterBkg{position:relative; padding: 32px 4px 4px 3px; background-color:#ffdd99; } .RouteAddressInnerBkg{padding: 3px 5px 8px 8px; background-color:#ffffff; } #RouteAddress_DIV1{margin-top: 5px; } .RouteAddressTip{position:absolute; width:100%; top:0px; text-align:center; height:30px; line-height:30px; color:#994c00; } .route_tip_con {position:absolute;top:145px;} .route_tip_con .route_tip{position:absolute;width:233px;height:29px;color:#803300;text-align:center;line-height:29px;border:#cc967a solid 1px;background:#fff2b2;z-index:100000;} .route_tip_con .route_tip span{position:absolute;top:0;right:0;_right:-1px;width:14px;height:13px;background:url(http://api0.map.bdimg.com/images/addrPage.png?v=20121107) no-repeat 0 -121px;cursor:pointer;} .route_tip_con .route_tip_shadow{width:233px;height:29px;  position:absolute;left:1px;top:1px;background:#505050;border:1px solid #505050;opacity:0.2;filter:alpha(opacity=20)} .sel_body_body_page{margin:5px 0} .sel_n{margin-top:5px;overflow:hidden;} .sel_n .sel_top{background:url(http://api0.map.bdimg.com/images/bgs.gif) no-repeat 0 -418px;height:4px;font-size:0px;} .sel_n .sel_body_top{height:32px;width:100%;background:url(http://api0.map.bdimg.com/images/addrPage.png?v=20121107) no-repeat 0 -41px;} .sel_n .sel_body_title{float:left;width:100%;height:31px;} .sel_n .sel_body_sign{margin-top:1px;width:30px;height:31px;float:left;background:url(http://api0.map.bdimg.com/images/bgs.gif) no-repeat -79px -387px;} .sel_n .sel_body_name{height: 10px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; margin:0 20px 0 30px;padding:8px 7px 7px;font-size:14px;color:#FA8722;} .sel_n .sel_body_button{float:left;width:55px;margin-left:-55px;padding-top:8px;} .sel_n .sel_body_button a{} .sel_n .sel_bottom{background:url(http://api0.map.bdimg.com/images/bgs.gif) no-repeat 0 -415px;height:4px;font-size:0px;} .sel_n .sel_body_body{padding:3px 0 0 0} .sel_n1{margin-top:5px;width:329px;overflow:hidden;} .sel_n1 .sel_top{background:url(http://api0.map.bdimg.com/images/bgs.gif) no-repeat 0 -418px;height:4px;font-size:0px;} .sel_n1 .sel_body_top{height:31px;width:100%;background:url(http://api0.map.bdimg.com/images/sel_body_n_top.gif) repeat-x;} .sel_n1 .sel_body_top{height:32px;width:100%;background:url(http://api0.map.bdimg.com/images/addrPage.png?v=20121107) no-repeat 0 -41px} .sel_n1 .sel_body_title{float:left;width:100%;height:31px;cursor:pointer;} .sel_n1 .sel_body_sign{margin-top:1px;width:30px;height:31px;float:left;background:url(http://api0.map.bdimg.com/images/bgs.gif) no-repeat -79px -387px;} .sel_n1 .sel_body_name{margin:0 20px 0 30px;padding:8px 7px 7px;font-size:14px;color:#FA8722;} .sel_n1 .sel_body_button{float:left;width:20px;height:31px;margin-left:-23px;background:url(http://api0.map.bdimg.com/images/bgs.gif) no-repeat -253px -382px;overflow:hidden;zoom:1;cursor:pointer;} .sel_n1 .sel_body_button a{display:none;} .sel_n1 .sel_body_body{display:none} .sel_n1 .sel_bottom{background:url(http://api0.map.bdimg.com/images/bgs.gif) no-repeat 0 -415px;height:4px;font-size:0px;} .sel_y{margin-top:5px;overflow:hidden;} .sel_y .sel_top{background:url(http://api0.map.bdimg.com/images/bgs.gif) no-repeat 0 -439px;height:4px;zoom:1;font-size:0px;} .sel_y .sel_body_top{height:32px;width:100%;background:url(http://api0.map.bdimg.com/images/addrPage.png?v=20121107) no-repeat 0 0} .sel_y .sel_body_title{float:left;width:100%;height:31px;cursor:pointer;} .sel_y .sel_body_sign{margin-top:1px;width:30px;height:31px;float:left;background:url(http://api0.map.bdimg.com/images/bgs.gif) no-repeat -167px -384px;} .sel_y .sel_body_name{margin:0 20px 0 30px;padding:8px 7px 7px;font-size:14px;color:#5B7BCB;} .sel_y .sel_body_button{float:left;width:20px;height:31px;margin-left:-20px;background:url(http://api0.map.bdimg.com/images/bgs.gif) no-repeat -269px -297px;cursor:pointer;} .sel_y .sel_body_button a{display:none;} .sel_y .sel_body_body{display:none;height:0px} .sel_y .sel_body_body_div{} .sel_y .sel_bottom{background:url(http://api0.map.bdimg.com/images/bgs.gif) no-repeat 0 -436px;height:4px;font-size:0px;} .sel_y .sel_body_body_page{display:none;height:0px;} .sel_x{margin-top:5px;width:329px;overflow:hidden;} .sel_x .sel_top{background:url(http://api0.map.bdimg.com/images/bgs.gif) no-repeat 0 -418px;height:4px;font-size:0px;} .sel_x .sel_body_top{height:32px;width:100%;background:url(http://api0.map.bdimg.com/images/addrPage.png?v=20121107) no-repeat 0 -41px;} .sel_x .sel_body_title{float:left;width:100%;height:31px;} .sel_x .sel_body_sign{margin-top:1px;width:30px;height:31px;float:left;background:url(http://api0.map.bdimg.com/images/bgs.gif) no-repeat -122px -384px;} .sel_x .sel_body_name{margin:0 20px 0 30px;padding:8px 7px 7px;font-size:14px;color:#FA8722;} .sel_x .sel_body_button{float:left;width:55px;margin-left:-55px;padding-top:8px;} .sel_x .sel_body_button a{} .sel_x .sel_body_body{} .sel_x .sel_body_body_div{padding:5px 5px 0 5px;} .sel_x .sel_bottom{background:url(http://api0.map.bdimg.com/images/bgs.gif) no-repeat 0 -415px;height:4px;font-size:0px;} .sel_x1{margin-top:5px;width:329px;overflow:hidden;} .sel_x1 .sel_top{background:url(http://api0.map.bdimg.com/images/bgs.gif) no-repeat 0 -418px;height:4px;font-size:0px;} .sel_x1 .sel_body_top{height:32px;width:100%;background:url(http://api0.map.bdimg.com/images/addrPage.png?v=20121107) no-repeat 0 -41px} .sel_x1 .sel_body_title{float:left;width:100%;height:31px;cursor:pointer;} .sel_x1 .sel_body_sign{margin-top:1px;width:30px;height:31px;float:left;background:url(http://api0.map.bdimg.com/images/bgs.gif) no-repeat -122px -384px;} .sel_x1 .sel_body_name{margin:0 20px 0 30px;padding:8px 7px 7px;font-size:14px;color:#FA8722;} .sel_x1 .sel_body_button{float:left;width:55px;height:31px;margin-left:-55px;} .sel_x1 .sel_body_button a{display:none;} .sel_x1 .sel_body_body{display:none;height:0px;} .sel_x1 .sel_body_body_div{padding:5px 5px 0 5px;} .sel_x1 .sel_bottom{background:url(http://api0.map.bdimg.com/images/bgs.gif) no-repeat 0 -415px;height:4px;font-size:0px;} .sel_body_citylist{height:100px;padding: 0 0 0 5px} .sel_body_resitem{table-layout:fixed;overflow-x:hidden;overflow-y:hidden;} .sel_body_resitem table {margin-right:5px;} .sel_body_resitem tr{cursor:pointer;} .sel_body_resitem th{padding-top:5px;padding-left:5px;text-align:left;vertical-align:top;width:22px;} .sel_body_resitem th div.iconbg{background:url(http://api0.map.bdimg.com/images/markers_new_ie6.png) no-repeat scroll 0 0;height:29px;width:24px;} .sel_body_resitem th div.icon{cursor:pointer} .sel_body_resitem th div#no_0_1, .sel_body_resitem th div#no_1_1{background-position:0 -64px} .sel_body_resitem th div#no_0_2, .sel_body_resitem th div#no_1_2{background-position:-24px -64px} .sel_body_resitem th div#no_0_3, .sel_body_resitem th div#no_1_3{background-position:-48px -64px} .sel_body_resitem th div#no_0_4, .sel_body_resitem th div#no_1_4{background-position:-72px -64px} .sel_body_resitem th div#no_0_5, .sel_body_resitem th div#no_1_5{background-position:-96px -64px} .sel_body_resitem th div#no_0_6, .sel_body_resitem th div#no_1_6{background-position:-120px -64px} .sel_body_resitem th div#no_0_7, .sel_body_resitem th div#no_1_7{background-position:-144px -64px} .sel_body_resitem th div#no_0_8, .sel_body_resitem th div#no_1_8{background-position:-168px -64px} .sel_body_resitem th div#no_0_9, .sel_body_resitem th div#no_1_9{background-position:-192px -64px} .sel_body_resitem th div#no_0_10, .sel_body_resitem th div#no_1_10{background-position:-216px -64px} .sel_body_resitem td{line-height:160%;padding:3px 0 3px 3px;vertical-align:top;} .sel_body_resitem div.ra_td_title{float:left;margin-right:40px;} .sel_body_resitem div.ra_td_button{float:right; width:40px;} .sel_body_resitem div.ra_td_button input{height:18px;font-size:12px;width:40px;} .sel_body_resitem div.clear{clear:both;height:0px;width:100%;} .sel_body_resitem td .selBtn {width:70px;height:29px;background:url(http://api0.map.bdimg.com/images/addrPage.png?v=20121107) no-repeat -21px -81px;text-align:center;line-height:29px;visibility:hidden;color:#b35900;display:inline-block;*display:inline;*zoom:1;} .sel_body_resitem td .list_street_view_poi {display:inline-block;float:none;margin-right:6px;position:static;*vertical-align:-3px;_vertical-align:-5px;*display:inline;*zoom:1;} .selInfoWndBtn {width:70px;height:29px;background:url(http://api0.map.bdimg.com/images/addrPage.png?v=20121107) no-repeat -21px -81px;text-align:center;line-height:29px;margin: 0 auto;cursor:pointer;color:#b35900} .sel_body_body td a{text-decoration: none; cursor: auto; } .sel_body_body td a:hover,.sel_body_body td a:focus{text-decoration:underline; }.panoInfoBox{cursor:pointer}.panoInfoBox{position:relative;width:323px;height:101px;margin-bottom:4px;cursor:pointer}.panoInfoBox .panoInfoBoxTitleBg{width:323px;height:19px;position:absolute;left:0;bottom:0;z-index:2;background-color:#000;opacity:.7}.panoInfoBox .panoInfoBoxTitleContent{font-size:12px;color:#fff;position:absolute;bottom:2px;left:5px;z-index:3;text-decoration:none}.pano_switch_left,.pano_switch_right{position:absolute;width:28px;height:38px;cursor:pointer;background-color:#252525;background-color:rgba(37,37,37,.9)}.pano_switch_left{background:url(http://api0.map.bdimg.com/images/panorama/zuojiantou.png) no-repeat;-webkit-background-size:100% 100%;background-size:100% 100%}.pano_switch_right{background:url(http://api0.map.bdimg.com/images/panorama/youjiantou.png) no-repeat;-webkit-background-size:100% 100%;background-size:100% 100%}.pano_switch_left:hover{background:url(http://api0.map.bdimg.com/images/panorama/zuojiantou_hover.png) no-repeat;-webkit-background-size:100% 100%;background-size:100% 100%}.pano_switch_right:hover{background:url(http://api0.map.bdimg.com/images/panorama/youjiantou_hover.png) no-repeat;-webkit-background-size:100% 100%;background-size:100% 100%}.pano_switch_left.pano_switch_disable,.pano_switch_right.pano_switch_disable{background:0 0;border:none}.pano_poi_1,.pano_poi_2,.pano_poi_4{display:inline-block;width:16px;height:16px;vertical-align:middle;background:url(http://webmap0.map.bdimg.com/newmap/static/common/images/pano_whole/guide_icons_4b871b2.png) no-repeat;background-position:0 0}.pano_photo_arrow_l,.pano_photo_arrow_r{position:absolute;top:0;width:20px;height:100%;background:#f3eeee}.pano_photo_arrow_l{left:0}.pano_photo_arrow_r{right:0}.pano_arrow_l,.pano_arrow_r{display:inline-block;width:18px;height:18px;background:url(http://webmap0.map.bdimg.com/newmap/static/common/images/pano_whole/pano-icons_223a291.png) no-repeat}.pano_catlogLi{cursor:pointer;position:relative;line-height:10px;font-size:10px;text-align:center;color:#abb0b2;border:1px solid #53565c;padding:3px 0;margin-top:3px;margin-left:2px;width:90%}.pano_catlogLi:hover{color:#3DAAFC;border:1px solid #3DAAFC}.pano_catlogLiActive{color:#3DAAFC;border:1px solid #3DAAFC}.pano_arrow_l{background-position:0 -36px}.pano_arrow_r{background-position:-54px -36px}.pano_photo_arrow_l:hover .pano_arrow_l{background-position:-18px -36px}.pano_photo_arrow_r:hover .pano_arrow_r{background-position:-72px -36px}.pano_photo_arrow_l.pano_arrow_disable .pano_arrow_l{background-position:-36px -36px}.pano_photo_arrow_r.pano_arrow_disable .pano_arrow_r{background-position:-90px -36px}.pano_photo_item{position:relative;float:left;line-height:0;padding-left:8px}.pano_photo_decs{position:absolute;bottom:1px;left:0;padding:2px 0;text-indent:5px;margin-left:8px;display:inline-block;color:#fff;background:#000;opacity:.5;filter:alpha(opacity=50)9;text-overflow:ellipsis;overflow:hidden;white-space:nowrap}.pano_photo_item img{display:inline-block;border:solid 1px #252525}.pano_photo_item:hover img{border-color:#005efc}.pano_photo_item_seleted{position:absolute;top:0;left:-100000px;border:3px solid #097df3}.pano_close{position:absolute;right:10px;top:10px;width:40px;cursor:pointer;height:40px;line-height:40px;border-radius:3px;background-color:rgba(37,37,37,.9);background-image:url(http://api0.map.bdimg.com/images/panorama/close.png);background-repeat:no-repeat;background-position:center center;background-size:90%}.pano_close:hover{background-image:url(http://api0.map.bdimg.com/images/panorama/close_hover.png)}.pano_pc_indoor_exit{position:absolute;right:60px;top:10px;width:89px;cursor:pointer;height:40px;line-height:40px;color:#ebedf0;border-radius:3px;background-color:#252525;background-color:rgba(37,37,37,.9);background-image:url(http://api0.map.bdimg.com/images/panorama/indoor_exit.png);background-repeat:no-repeat;background-position:15px 12px}.pano_pc_indoor_exit:hover{background-image:url(http://api0.map.bdimg.com/images/panorama/indoor_exit_hover.png);color:#2495ff}.pano_m_indoor_exit{font-size:16px;position:absolute;right:30px;top:10px;width:89px;cursor:pointer;height:40px;line-height:40px;color:#ebedf0;border-radius:3px;background-color:#252525;background-color:rgba(37,37,37,.9);background-image:url(http://api0.map.bdimg.com/images/panorama/indoor_exit.png);background-repeat:no-repeat;background-position:15px 12px}.navtrans-table tr{color:#666}.navtrans-table tr:hover{color:#333}.navtrans-navlist-icon{float:left;width:18px;height:16px;background:url(http://webmap0.map.bdimg.com/wolfman/static/common/images/nav-icon_b5c3223.png) no-repeat 0px 0px;_background:url(http://webmap0.map.bdimg.com/wolfman/static/common/images/nav-icon_ie6_134841b.png) no-repeat 0px 0px;margin-top:2px;margin-right:5px}.navtrans-navlist-icon.s-1{background-position:0px 0px}.navtrans-navlist-icon.s-2{background-position:-18px 0px}.navtrans-navlist-icon.s-3{background-position:-36px 0px}.navtrans-navlist-icon.s-4{background-position:-54px 0px}.navtrans-navlist-icon.s-5{background-position:-72px 0px}.navtrans-navlist-icon.s-6{background-position:-90px 0px}.navtrans-navlist-icon.s-7{background-position:0px -16px}.navtrans-navlist-icon.s-8{background-position:-18px -16px}.navtrans-navlist-icon.s-9{background-position:-36px -16px}.navtrans-navlist-icon.s-10{background-position:-54px -16px}.navtrans-navlist-icon.s-11{background-position:-72px -16px}.navtrans-navlist-icon.s-12{background-position:-90px -16px}.navtrans-navlist-icon.s-13{background-position:0px -32px}.navtrans-navlist-icon.s-14{background-position:-18px -32px}.navtrans-navlist-icon.s-18{background-position:-36px -32px}.navtrans-navlist-icon.s-19{background-position:-54px -32px}.navtrans-navlist-icon.s-20{background-position:-72px -32px}.navtrans-navlist-icon.s-21{background-position:-90px -32px}.navtrans-navlist-icon.nav-st,.navtrans-navlist-icon.nav-through{background-position:-16px -70px}.navtrans-navlist-icon.nav-ed{background-position:0px -70px}.navtrans-view{border-top:1px solid #e4e6e7;border-left:1px solid #e4e6e7;border-right:1px solid #e4e6e7}.navtrans-view:hover{cursor:pointer}.navtrans-view .navtrans-arrow{position:absolute;top:8px;right:5px;width:7px;height:4px;background-image:url(http://webmap0.map.bdimg.com/wolfman/static/common/images/nav-icon_b5c3223.png);background-repeat:no-repeat;background-position:-40px -70px;margin-top:3px;margin-right:3px;_background-image:url(http://webmap0.map.bdimg.com/wolfman/static/common/images/nav-icon_ie6_134841b.png)}.navtrans-view.expand:hover .navtrans-arrow{background-position:-61px -70px}.navtrans-view.expand .navtrans-arrow{background-position:-54px -70px}.navtrans-view:hover .navtrans-arrow{background-position:-47px -70px}.navtrans-navlist-content{overflow:hidden}.navtrans-res{border-bottom:1px solid #E4E6E7;border-left:1px solid #E4E6E7;border-right:1px solid #E4E6E7}.navtrans-bus-icon{display:inline-block;float:left;background-image:url(http://webmap0.map.bdimg.com/wolfman/static/common/images/ui3/mo_banner_e1aa2e6.png);background-repeat:no-repeat}.navtrans-bus-icon.bus{width:13px;height:16px;background-position:-1px -192px;position:relative;top:4px}.navtrans-bus-icon.walk{width:16px;height:18px;background-position:-63px -189px;position:relative;top:2px;left:-2px}.navtrans-bus-desc{line-height:24px;margin-left:20px}.navtrans-busstation{color:#36c;font-weight:600}.tranroute-plan-list.expand .trans-title{border-bottom:1px solid #e4e6e7;background-color:#ebf1fb}.trans-plan-content tr td:hover .bus{background-position:-15px -192px}.trans-plan-content tr td:hover .walk{background-position:-82px -189px}.suggest-plan{position:absolute;background-color:#0C88E8;padding:0px 15px;line-height:20px;color:#fff;left:0px;top:0px}.suggest-plan-des{text-align:left;padding:29px 0px 0px 25px;font-size:13px;color:#000}.bmap-clearfix{*+height:1%}.bmap-clearfix:after{content:".";display:block;height:0px;clear:both;visibility:hidden}.BMap_CityListCtrl{font-size:12px}.BMap_CityListCtrl a{text-decoration:none!important}.BMap_CityListCtrl a:hover{text-decoration:underline!important}.BMap_CityListCtrl .citylist_popup_main{border:1px solid #cdcdcd;z-index:2;position:relative;width:100%;height:100%;background:#fafafa;overflow:hidden;box-shadow:1px 1px 1px rgba(0,0,0,.1)}.ui_city_change_top .ui_city_change_inner,.ui_city_change_bottom .ui_city_change_inner{display:inline-block;height:24px;line-height:24px;border:1px solid #c4c7cc;background-color:#fff;padding:0 10px 0 10px;color:#000}.ui_city_change_top .ui_city_change_inner i,.ui_city_change_bottom .ui_city_change_inner i{width:8px;height:6px;display:inline-block;position:relative;top:9px;left:5px;-webkit-transition:all ease-in-out .15s;transition:all ease-in-out .15s;display:none9}.ui_city_change_click .ui_city_change_inner i,.ui_city_change_click_close .ui_city_change_inner i{-webkit-transform:rotate(180deg);-moz-transform:rotate(180deg);-o-transform:rotate(180deg);transform:rotate(180deg)}.ui_city_change_top .ui_city_change_inner:hover em{border-top-color:#0C88E8}.ui_city_change_top .ui_city_change_inner em{width:0;height:0;border-color:rgba(255,255,255,0);border-top-color:#D0D4DA;border-style:solid;border-width:4px}.ui_city_change_top .ui_city_change_inner:hover,.ui_city_change_bottom .ui_city_change_inner:hover{text-decoration:none!important;color:#3d6dcc}.ui_city_change_bottom .ui_city_change_inner:hover em{border-bottom-color:#0C88E8}.ui_city_change_bottom .ui_city_change_inner em{width:0;height:0;border-color:rgba(255,255,255,0);border-bottom-color:#D0D4DA;border-style:solid;border-width:4px;position:relative;top:-18px}.citylist_popup_main .citylist_ctr_title{background:#f9f9f9;border-bottom:1px solid #dadada;height:25px;line-height:25px;font-size:12px;color:#4c4c4c;padding-left:7px}.citylist_popup_main .city_content_top{position:relative;height:30px;padding:15px 10px 0px 10px;border-bottom:1px solid #CCC;margin:0px 10px}.citylist_popup_main .city_content_top .cur_city_info{display:inline-block;margin:0;padding:0;}#city_ctrl_form{position:absolute;right:12px;top:10px}#selCityWd{border:1px solid #ccc;height:20px;width:121px;line-height:20px;text-indent:4px;outline:none}#selCitySubmit:hover{background-position:-355px -98px}#selCitySubmit{float:right;background:url(http://webmap0.map.bdimg.com/wolfman/static/common/images/index_a2f1ac4.png) no-repeat scroll -302px -98px;height:24px;line-height:24px;width:48px;cursor:pointer;margin-left:5px;text-align:center}#sel_city_letter_list{padding-top:10px}#sel_city_letter_list a{white-space:nowrap;margin-right:11px;line-height:18px;font-size:13px;font-family:Arial,Helvetica,SimSun,sans-serif}.city_content_medium{padding:10px 10px 10px 10px;border-bottom:1px solid #CCC;margin:0px 10px}.city_content_bottom{padding:10px 10px 10px 8px;margin:9px 5px 5px 5px;height:218px;overflow-y:auto}#city_detail_table tr td{vertical-align:top}.sel_city_hotcity a{color:#3d6dcc}.sel_city_letter{padding:0 14px 0 3px}.sel_city_letter div{font-size:24px;line-height:24px;font-weight:700;color:#ccc;padding:0;margin:0;font-family:Arial,Helvetica,SimSun,sans-serif}.sel_city_sf{padding-right:8px;font-weight:700}.sel_city_sf a{white-space:nowrap;line-height:18px;color:#3d6dcc}.city_names_wrap{margin-bottom:9px}.sel_city_name{color:#3d6dcc;white-space:nowrap;margin-right:9px;line-height:18px;float:left}#popup_close{outline:none;position:absolute;z-index:50;top:7px;right:6px;width:12px;height:12px;background:url(http://webmap0.map.bdimg.com/wolfman/static/common/images/popup_close_15d2283.gif) no-repeat;border:0;cursor:pointer}</style></head>
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
		
			
				<a href="http://www.shouhuobao.com/merchant"><img alt="" src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/merchant-logo.jpg"></a>
			
			
		
	</div>
	<div class="flr">
		<!--  div class="fll"
			style="margin-bottom: 0; margin-top: 18px; color: red">
			小提示：如果您在使用过程中遇到异常问题，推荐使用 <a href="http://chrome.360.cn/"
				target="_blank" class="blue"> <img alt=""
				src="/merchant/res/img/logo-360se.jpg"
				style="vertical-align: middle; margin: 0 5px;"></a><a
				href="http://chrome.360.cn/" target="_blank" class="blue"> 点此下载
				>></a>
		</div>-->
        
            
                
                    
                        
                        
                        
                        
                        
                    
                    
                        
                        
                        
                        
                    
                    
                        
                        
                        
                            
                                
                                    
                                
                                
                                    
                                
                            
                        
                    
                
            
            

            
        

        
            
            

            
        

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
                <h4>加盟流程</h4>
                <!-- 流程块 -->
                <div class="zln-liuchen">
                    <!-- 第一步 经过时有一个hover样式 -->
                    <dl class="zln-hover">
                        <dt>
                        <div class="zln-dldl"><span>申请报名</span><font><img src="image/join_03.jpg" width="9" height="6"></font></div>
                        </dt>
                        <dd>
                            <div class="zln-yuan">
                                <div class="zln-yuan_img"></div>
                                <div class="zln-yuan_hover"></div>
                            </div>
                            <div class="zln-size"></div>
                        </dd>
                    </dl>
                    <!-- 第二步 -->
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
                    <!-- 第三步 -->
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

                    <!-- 第四步 -->
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
                </div>
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
                            
                        </ul>
                    </div>
                    <!-- 商铺信息 -->
                    <div class="zln-join_box zln-c">
                        <div class="zln-join_title"><span>商铺信息</span><font>&nbsp;</font></div>
                        <ul class="zln-c">
                            <li class="zln-li1"><span>所在区域</span>
                                <input name="receivePointJoin.tmLocation.latitude_baidu" id="lat" type="hidden">
                                <input name="receivePointJoin.tmLocation.longitude_baidu" id="lng" type="hidden">
                                <input name="receivePointJoin.tmLocation.addressLine1" id="addressLine1" type="hidden">
                                <select id="selProvince" name="receivePointJoin.tmLocation.state">
                                    <option value="" selected="selected">省</option>
                                <option value="110000">北京</option><option value="310000">上海</option><option value="440000">广东省</option></select>
                                <select id="selCity" name="receivePointJoin.tmLocation.city">
                                    <option value="" selected="selected">市</option>
                                </select>
                                <select id="selDistrict" name="receivePointJoin.tmLocation.area">
                                    <option value="" selected="selected">区</option>
                                </select>
                                <select id="selOther" name="receivePointJoin.tmLocation.bizcircle">
                                    <option value="BZ9999" selected="selected">商圈</option>
                                </select>

                                <div class="zln-select zln-selectc">
                                    <div class="zln-select_box"> 省</div>
                                    <div class="zln-select_fola" id="shengCon" style="display: none;">
                                        <p><a href="javascript:;" _title="0">省</a></p>
                                    <p><a href="javascript:;" _title="110000">北京</a></p><p><a href="javascript:;" _title="310000">上海</a></p><p><a href="javascript:;" _title="440000">广东省</a></p></div>
                                </div>
                                <div class="zln-select zln-select_m zln-selectc">
                                    <div class="zln-select_box"> 市</div>
                                    <div class="zln-select_fola" id="shiCon" style="display: none;">
                                        <p><a href="javascript:;" _title="0">市</a></p>
                                    </div>
                                </div>
                                <div class="zln-select zln-selectc">
                                    <div class="zln-select_box"> 区</div>
                                    <div class="zln-select_fola" id="quCon" style="display: none;">
                                        <p><a href="javascript:;" _title="0">区</a></p>
                                    </div>
                                </div>
                                <div class="zln-select zln-select_m zln-selectc" style="display:none">
                                    <div class="zln-select_box">商圈</div>
                                    <div class="zln-select_fola" id="otherCon" style="display: none;">
                                        <p><a href="javascript:;" _title="BZ9999">商圈</a></p>
                                    </div>
                                </div>
                                <input name="receivePointJoin.tmLocation.addressLine2" id="address" class="zln-text address-text" placeholder="请输入详细地址" type="text">

                                <input class="address-btn" value="搜索标注" id="searchPoint" type="button">
                            </li>
                            <li class="zln-li1"><span>定位</span><div id="allmap" style="overflow: hidden; position: relative; z-index: 0; background-color: rgb(243, 241, 236); color: rgb(0, 0, 0); text-align: left;"><div style="overflow: visible; position: absolute; z-index: 0; left: 0px; top: 0px; cursor: grab;"><div class="BMap_mask" style="position: absolute; left: 0px; top: 0px; z-index: 9; overflow: hidden; -moz-user-select: none; width: 821px; height: 371px;"></div><div style="position: absolute; height: 0px; width: 0px; left: 0px; top: 0px; z-index: 200;"><div style="position: absolute; height: 0px; width: 0px; left: 0px; top: 0px; z-index: 800;"></div><div style="position: absolute; height: 0px; width: 0px; left: 0px; top: 0px; z-index: 700;"></div><div style="position: absolute; height: 0px; width: 0px; left: 0px; top: 0px; z-index: 600;"></div><div style="position: absolute; height: 0px; width: 0px; left: 0px; top: 0px; z-index: 500;"><label class="BMapLabel" unselectable="on" style="position: absolute; -moz-user-select: none; display: none; cursor: inherit; background-color: rgb(190, 190, 190); border: 1px solid rgb(190, 190, 190); padding: 1px; white-space: nowrap; font: 12px arial,simsun,sans-serif; z-index: -20000; color: rgb(190, 190, 190);">shadow</label></div><div style="position: absolute; height: 0px; width: 0px; left: 0px; top: 0px; z-index: 400;"></div><div style="position: absolute; height: 0px; width: 0px; left: 0px; top: 0px; z-index: 300;"></div><div style="position: absolute; height: 0px; width: 0px; left: 0px; top: 0px; z-index: 201;"></div><div style="position: absolute; height: 0px; width: 0px; left: 0px; top: 0px; z-index: 200;"></div></div><div style="position: absolute; overflow: visible; top: 0px; left: 0px; z-index: 1;"><div style="position: absolute; overflow: visible; z-index: -100; left: 410px; top: 185px; display: block; transform: translate3d(0px, 0px, 0px);"><img style="-moz-user-select: none; position: absolute; border: medium none; width: 256px; height: 256px; left: 320px; top: 33px; max-width: none; opacity: 1;" src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/a_005.png"><img style="-moz-user-select: none; position: absolute; border: medium none; width: 256px; height: 256px; left: 64px; top: 33px; max-width: none; opacity: 1;" src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/a.png"><img style="-moz-user-select: none; position: absolute; border: medium none; width: 256px; height: 256px; left: -448px; top: 33px; max-width: none; opacity: 1;" src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/a_008.png"><img style="-moz-user-select: none; position: absolute; border: medium none; width: 256px; height: 256px; left: 320px; top: -223px; max-width: none; opacity: 1;" src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/a_006.png"><img style="-moz-user-select: none; position: absolute; border: medium none; width: 256px; height: 256px; left: -192px; top: 33px; max-width: none; opacity: 1;" src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/a_002.png"><img style="-moz-user-select: none; position: absolute; border: medium none; width: 256px; height: 256px; left: 64px; top: -223px; max-width: none; opacity: 1;" src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/a_003.png"><img style="-moz-user-select: none; position: absolute; border: medium none; width: 256px; height: 256px; left: -448px; top: -223px; max-width: none; opacity: 1;" src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/a_007.png"><img style="-moz-user-select: none; position: absolute; border: medium none; width: 256px; height: 256px; left: -192px; top: -223px; max-width: none; opacity: 1;" src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/a_004.png"></div></div><div style="position: absolute; overflow: visible; top: 0px; left: 0px; z-index: 2; display: none;"><div style="position: absolute; overflow: visible; top: 0px; left: 0px; z-index: 0; display: none;"></div><div style="position: absolute; overflow: visible; top: 0px; left: 0px; z-index: 10; display: none;"></div></div><div style="position: absolute; overflow: visible; top: 0px; left: 0px; z-index: 3;"></div></div><div class="pano_close" style="z-index: 1201; display: none;" title="退出全景"></div><a class="pano_pc_indoor_exit" style="z-index: 1201; display: none;" title="退出室内景"><span style="float:right;margin-right:12px;">出口</span></a><div id="zoomer" style="position:absolute;z-index:0;top:0px;left:0px;overflow:hidden;visibility:hidden;cursor:-moz-grab"><div class="BMap_zoomer" style="top:0;left:0;"></div><div class="BMap_zoomer" style="top:0;right:0;"></div><div class="BMap_zoomer" style="bottom:0;left:0;"></div><div class="BMap_zoomer" style="bottom:0;right:0;"></div></div><div style="height: 32px; position: absolute; z-index: 30; -moz-user-select: none; -moz-text-size-adjust: none; bottom: 20px; right: auto; top: auto; left: 1px;" class=" anchorBL"><a title="到百度地图查看此区域" target="_blank" href="http://map.baidu.com/?sr=1" style="outline: medium none;"><img style="border:none;width:77px;height:32px" src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/copyright_logo.png"></a></div><div unselectable="on" class=" BMap_cpyCtrl BMap_noprint anchorBL" style="cursor: default; white-space: nowrap; -moz-user-select: none; color: black; background: transparent none repeat scroll 0% 0%; font: 11px/15px arial,simsun,sans-serif; bottom: 2px; right: auto; top: auto; left: 2px; position: absolute; z-index: 10; -moz-text-size-adjust: none;"><span _cid="1" style="display: inline;"><span style="background: rgba(255, 255, 255, 0.701961);padding: 0px 1px;line-height: 16px;display: inline;height: 16px;">©&nbsp;2017 Baidu - GS(2015)2650号&nbsp;- Data © 长地万方</span></span></div></div>
                            </li>
                            <li class="zln-li1"><span>门店名</span>
                                <input name="receivePointJoin.name" id="name" class="zln-text" type="text">
                                <font>门店名不得含有区域地址信息（如，北京市XXX公司）</font>
                            </li>
                            <li class="zln-li1"><span>所在小区</span>
                                <input name="receivePointJoin.tmLocation.landMark" id="landMark" class="zln-text" type="text">
                                <font></font>

                            </li>
                            <li class="zln-li1"><span>商铺类型</span>
                                <input name="receivePointJoin.tmCategoryId" id="tmCategoryId" type="hidden">
                                <div class="zln-select zln-hover zln-selecta">
                                    <div class="zln-select_box">请选择</div>
                                    <div class="zln-select_fola" style="display: none;">
                                        
                                            <p>
                                                <a onclick="javascript:$('#tmCategoryId').attr('value','167');">超市/便利店</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#tmCategoryId').attr('value','168');">洗衣/皮具护理类</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#tmCategoryId').attr('value','169');">药店类</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#tmCategoryId').attr('value','170');">数码3C</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#tmCategoryId').attr('value','171');">物业</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#tmCategoryId').attr('value','172');">服饰化妆品</a>
                                            </p>
                                        
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <!-- 服务信息 -->
                    <div class="zln-join_box zln-c">
                        <div class="zln-join_title"><span>服务信息</span><font></font></div>
                        <ul>
                            <li class="zln-li1"><span>营业时间</span>
                                <input name="receivePointJoin.openBegin" id="openBegin" type="hidden">
                                <input name="receivePointJoin.openEnd" id="openEnd" type="hidden">

                                <div class="zln-select zln-selectp">
                                    <div class="zln-select_box"> 请选择</div>
                                    <div class="zln-select_fola" style="display: none;">
                                        
                                            <p>
                                                <a onclick="javascript:$('#openBegin').attr('value','00:00');">00:00</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openBegin').attr('value','00:30');">00:30</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openBegin').attr('value','01:00');">01:00</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openBegin').attr('value','01:30');">01:30</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openBegin').attr('value','02:00');">02:00</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openBegin').attr('value','02:30');">02:30</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openBegin').attr('value','03:00');">03:00</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openBegin').attr('value','03:30');">03:30</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openBegin').attr('value','04:00');">04:00</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openBegin').attr('value','04:30');">04:30</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openBegin').attr('value','05:00');">05:00</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openBegin').attr('value','05:30');">05:30</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openBegin').attr('value','06:00');">06:00</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openBegin').attr('value','06:30');">06:30</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openBegin').attr('value','07:00');">07:00</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openBegin').attr('value','07:30');">07:30</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openBegin').attr('value','08:00');">08:00</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openBegin').attr('value','08:30');">08:30</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openBegin').attr('value','09:00');">09:00</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openBegin').attr('value','09:30');">09:30</a>
                                            </p>
                                        
                                    </div>
                                </div>
                                <div class="zln-select zln-selectp  zln-select_m">
                                    <div class="zln-select_box"> 请选择</div>
                                    <div class="zln-select_fola" style="display: none;">
                                        
                                            <p>
                                                <a onclick="javascript:$('#openEnd').attr('value','21:00');">21:00</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openEnd').attr('value','21:30');">21:30</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openEnd').attr('value','22:00');">22:00</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openEnd').attr('value','22:30');">22:30</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openEnd').attr('value','23:00');">23:00</a>
                                            </p>
                                        
                                            <p>
                                                <a onclick="javascript:$('#openEnd').attr('value','23:30');">23:30</a>
                                            </p>
                                        
                                    </div>
                                </div>
                            </li>


                            <li class="zln-li1"><span>对外联系电话</span>
                                <input id="telephone" name="receivePointJoin.telephone" class="zln-text1" type="text">
                                <font></font>
                            </li>

                            <input id="outpicname" name="outpicname" type="hidden">
                            <input id="innerpicname" name="innerpicname" type="hidden">
                            <input id="licensepicname" name="licensepicname" type="hidden">
                            <input id="idcardfname" name="idcardfname" type="hidden">
                            <input id="idcardbname" name="idcardbname" type="hidden">
                            <li class="zln-li1"><span>门头照片</span>

                                <div class="zw">
                                    <input name="outpic1" id="outpic" style="display:none" multiple="" type="file">
                                    <a href="" onclick="document.getElementById('outpic').click();return false;"><div id="divoutdoor"><img id="imgoutdoor" src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/zw.jpg"></div></a>
                                    
                                </div>
                                <span class="last">店内照片</span>

                                <div class="zw">
                                    <input name="innerpic1" id="innerpic" style="display:none" onclick="" multiple="" type="file">
                                    <a href="" onclick="document.getElementById('innerpic').click();return false;"><div id="divinnerdoor"><img id="imginnerdoor" src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/zw.jpg"></div></a>
                                </div>
                                <div class="zln-c hint1 mb20">*像素要求必须为640*340像素，支持.jpg .jpeg .bmp .png格式，大小不超过5M</div>
                            <span>营业执照或有效租房协议<br>
                            <b class="need"></b></span>

                                <div class="zw">
                                    <input name="licensepic1" id="licensepic" style="display:none" onclick="" multiple="" type="file">
                                    <a href="" onclick="document.getElementById('licensepic').click();return false;"><div id="divlicense"><img id="imglicense" src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/zw.jpg"></div></a>
                                </div>
                                <div class="zln-c hint1">*像素要求必须为640*340像素，支持.jpg .jpeg .bmp .png格式，大小不超过5M</div>
                            </li>
                        </ul>
                    </div>
                    <!-- 个人信息 -->
                    <div class="zln-join_box zln-c">
                        <div class="zln-join_title"><span>个人信息</span><font></font></div>
                        <ul>
                            <li class="zln-li1"><span>签约人姓名</span>
                                <input id="proposerName" name="receivePointJoin.proposerName" class="zln-text1" type="text"> <font></font>
                            </li>
                            <li class="zln-li1"><span>签约人联系电话</span>
                                <input id="proposerPhone" name="receivePointJoin.proposerPhone" class="zln-text1" type="text"> <font></font>
                            </li>
                            <li class="zln-li1"><span>证件类型</span>
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
                            </li>
                            <li class="zln-li1"> <span>证件照片<br>
                          <b class="need">（正面）</b></span>

                                <div class="zw">
                                    <input name="idcardf1" id="idcardf" style="display:none" onclick="" multiple="" type="file">
                                    <a href="" onclick="document.getElementById('idcardf').click();return false;"><div id="divdcardf"><img id="imgidcardf" src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/zw.jpg"></div></a>
                                </div>
                            <span class="last">证件照片<br>
                                <b class="need">（背面）</b></span>

                                <div class="zw">
                                    <input name="idcardb1" id="idcardb" style="display:none" onclick="" multiple="" type="file">
                                    <a href="" onclick="document.getElementById('idcardb').click();return false;"><div id="dividcardb"><img id="imgidcardb" src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/zw.jpg"></div></a>
                                </div>
                                <div class="zln-c hint1">*像素要求必须为640*340像素，支持.jpg .jpeg .bmp .png格式，大小不超过5M</div>
                            </li>
                            <li class="zln-li1" style="padding-left:153px;color:#000;font-size:14px">
                                <input id="isnot" name="isnot" type="checkbox"> 同意签约 <a href="javascript:void(null)" onclick="joinUs();" style="color:#00f">点击查看协议条款&gt;&gt;</a>
                            </li>
                            <li class="zln-dtest zln-li1"><span>&nbsp;</span>

                                <div class="zln-libt_a">
                                	
                                    <input id="submitOk" value="提交加盟信息" class="zln-button" type="button">

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
            <img src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/copyRight.jpg" class="bh-fr"></div>
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
</script><script src="js/h.js" type="text/javascript"></script><a href="http://tongji.baidu.com/hm-web/welcome/ico?s=450f34e18b8751446775cba4abdb88c2" target="_blank"><img src="%E5%95%86%E6%88%B7%E4%B8%AD%E5%BF%83%20_%20%E6%94%B6%E8%B4%A7%E5%AE%9D_files/21.gif" width="20" height="20" border="0"></a>
	<script type="text/javascript">
		$(document).ready(function() {
			if ($('#_merchantReceivePointId').val() == "") {
				$(".headerInfoAfterLogin").hide();
			}
		});
	</script>

<div id="_my97DP" style="position: absolute; top: -1970px; left: -1970px;"><iframe style="width: 186px; height: 198px;" src="htm/My97DatePicker.htm" border="0" scrolling="no" frameborder="0"></iframe></div></body></html>