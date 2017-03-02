function getExpress(pageNum){
	$.get("zxd/list?page="+pageNum,function(data){
		//alert(data.rows);
		$("#expressList").empty();
		var expresses= data.rows;
		for(var i=0;i<expresses.length;i++){
			$("#expressList").append("<li class='topic'><div class='u_photo'>"+
				"<img src='image/85_avatar_m.jpg'height='48' width='48'>" +
				"<div style='width:48px;height:20px;line-height:20px;font-size:13px;" +
				"font-family:'微软雅黑';text-align:center;color:#E76D26;' >"+expresses[i].uname+"</div>"+
				"</div><div class='u_post'><div class='btn_order'></div>"+
				"<div class='li_1' style='line-height: 21px;'>"+
				"<a style='font-size: 18px; font-family: '微软雅黑';' class='i_title'"+
				"href='javascript:void(0)'>"+expresses[i].otype+"</a></div>"+
				"<div class='li_2' style='margin-top: 15px;'>"+
				"<a href='javascript:void(0)'>"+expresses[i].zaddr+"</a> <em class='li_s'>"+expresses[i].otime+"</em>" +
				"<em class='readNum li_s'>"+expresses[i].osize+"</em><em class='collectNum li_s'>" +
				"<span class='money'>￥"+expresses[i].oprice+"</span></em></div>"+
				"<div class='li_3' style='font-size: 14px; font-family: '微软雅黑';" +
				" padding-top: 10px;'>"+expresses[i].odesc +
				"</div></div></li>");
			
			
		}
		//if(data.totalPage>5){
			$("#pagation").empty();
			if(pageNum<5){
				switch(pageNum){
				case 1:
					$("#pagation").append("<ul><li><span>1</span></li>" +
							"<li><a href='javascript:void(0)'  onclick='getExpress(2)'>"+2
							+"</a></li><li><a href='javascript:void(0)'  onclick='getExpress(3)'>"+3
							+"</a></li><li><a href='javascript:void(0)'  onclick='getExpress(4)'>"+4
							+"</a></li><li><a href='javascript:void(0)'  onclick='getExpress(5)'>"+5
							+"</a></li><li><em style='javascript:void(0)'  onclick='getExpress(1)'>...</em></li>"
							+"<li><a href='javascript:void(0)'  onclick='getExpress("+data.totalPage+")'>"+data.totalPage
							+"</a></li><li><a href='javascript:void(0)'  onclick='getExpress("+(data.currPage+1)+")'"
							+">下一页</a></li></ul>") ;
					break;
				case 2:
					$("#pagation").append("<ul><li><a href='javascript:void(0)'  onclick='getExpress(1)'>"+1+"</a></li>" +
							"<li><span>2</span></li><li><a href='javascript:void(0)'  onclick='getExpress(3)'>"+3
							+"</a></li><li><a href='javascript:void(0)'  onclick='getExpress(4)'>"+4
							+"</a></li><li><a href='javascript:void(0)'  onclick='getExpress(5)'>"+5
							+"</a></li><li><em style='javascript:void(0)'  onclick='getExpress(1)'>...</em></li>"
							+"<li><a href='javascript:void(0)'  onclick='getExpress("+data.totalPage+")'>"+data.totalPage
							+"</a></li><li><a href='javascript:void(0)'  onclick='getExpress("+(data.currPage+1)+")'"
							+">下一页</a></li></ul>") ;
					break;
				case 3:
					$("#pagation").append("<ul><li><a href='javascript:void(0)'  onclick='getExpress(1)'>"+1+"</a></li>" +
							"<li><a href='javascript:void(0)'  onclick='getExpress(2)'>"+2
							+"</a></li><li><span>3</span></li><li><a href='javascript:void(0)'  onclick='getExpress(4)'>"+4
							+"</a></li><li><a href='javascript:void(0)'  onclick='getExpress(5)'>"+5
							+"</a></li><li><em style='javascript:void(0)'  onclick='getExpress(1)'>...</em></li>"
							+"<li><a href='javascript:void(0)'  onclick='getExpress("+data.totalPage+")'>"+data.totalPage
							+"</a></li><li><a href='javascript:void(0)'  onclick='getExpress("+(data.currPage+1)+")'"
							+">下一页</a></li></ul>") ;
					break;
				case 4:
					$("#pagation").append("<ul><li><a href='javascript:void(0)'  onclick='getExpress(1)'>"+1+"</a></li>" +
							"<li><a href='javascript:void(0)'  onclick='getExpress(2)'>"+2
							+"</a></li><li><a href='javascript:void(0)'  onclick='getExpress(3)'>"+3
							+"</a></li><li><span>4</span></li><li><a href='javascript:void(0)'  onclick='getExpress(5)'>"+5
							+"</a></li><li><em style='javascript:void(0)'  onclick='getExpress(1)'>...</em></li>"
							+"<li><a href='javascript:void(0)'  onclick='getExpress("+data.totalPage+")'>"+data.totalPage
							+"</a></li><li><a href='javascript:void(0)'  onclick='getExpress("+(data.currPage+1)+")'"
							+">下一页</a></li></ul>") ;
					break;
				default:"参数错误！！！";
				}
				
			}else if(pageNum==data.totalPage||pageNum==data.totalPage-1){
				switch(pageNum){
				case data.totalPage-1:
					$("#pagation").append("<ul><li><a href='javascript:void(0)' onclick='getExpress(1)'>1</a></li>" +
							"<li><em style='display:block; height:30px; line-height:16px;'>...</em>" +
							"</li><li><a href='javascript:void(0)' onclick='getExpress("+(data.totalPage-4)+")'>"+(data.totalPage-4)+"</a></li>" +
							"<li><a href='javascript:void(0)' onclick='getExpress("+(data.totalPage-3)+")'>"+(data.totalPage-3)+"</a></li>" +
							"<li><a href='javascript:void(0)' onclick='getExpress("+(data.totalPage-2)+")'>"+(data.totalPage-2)+"</a></li>" +
							"<li><span>"+(data.totalPage-1)+"</span></li>" +
							"<li><a href='javascript:void(0)' onclick='getExpress("+data.totalPage+")'>"+data.totalPage+"</a></li>" +
							"<li><a href='javascript:void(0)'  onclick='getExpress("+(data.currPage+1)+")'>下一页</a></li></ul>");
					break;
				case data.totalPage:
					$("#pagation").append("<ul><li><a href='javascript:void(0)' onclick='getExpress(1)'>1</a></li>" +
							"<li><em style='display:block; height:30px; line-height:16px;'>...</em>" +
							"</li><li><a href='javascript:void(0)' onclick='getExpress("+(data.totalPage-4)+")'>"+(data.totalPage-4)+"</a></li>" +
							"<li><a href='javascript:void(0)' onclick='getExpress("+(data.totalPage-3)+")'>"+(data.totalPage-3)+"</a></li>" +
							"<li><a href='javascript:void(0)' onclick='getExpress("+(data.totalPage-2)+")'>"+(data.totalPage-2)+"</a></li>" +
							"<li><a href='javascript:void(0)' onclick='getExpress("+(data.totalPage-1)+")'>"+(data.totalPage-1)+"</a></li>" +
							"<li><span>"+data.totalPage+"</span></li></ul>");
					break;
				default:"参数错误！！！";
				}
				
			}
			else if(pageNum>=5&&pageNum<=data.totalPage-2){
					$("#pagation").append("<ul><li><a href='javascript:void(0)' onclick='getExpress(1)'>1</a></li><li>" +
							"<em style='display:block; height:30px; line-height:16px;'>...</em>"+
					        "</li><li><a href='javascript:void(0)' onclick='getExpress("+(data.currPage-2)+")'>"+(data.currPage-2)+"</a></li>" +
							"<li><a href='javascript:void(0)' onclick='getExpress("+(data.currPage-1)+")'>"+(data.currPage-1)+"</a></li>" +
							"<li><span>"+data.currPage+"</span></li>" +
							"<li><a href='javascript:void(0)' onclick='getExpress("+(data.currPage+1)+")'>"+(data.currPage+1)+"</a></li>" +
							"<li><a href='javascript:void(0)' onclick='getExpress("+(data.currPage+2)+")'>"+(data.currPage+2)+"</a></li>" +
							"<li><em style='display:block; height:30px; line-height:16px;'>...</em>"+
							"</li><li><a href='javascript:void(0)' onclick='getExpress("+data.totalPage+")'>"+data.totalPage+"</a></li>" +
							"<li><a href='javascript:void(0)'  onclick='getExpress("+(data.currPage+1)+")'>下一页</a></li></ul>");
			}
			
		//}
		

	},"json");
}
getExpress(1);	

function getType(){
	$.get("zxd/type",function(data){
		//alert(data.length);
		$("#typelist").empty();
		var sum=0;
		for(var i=0;i<data.length;i++){
			$("#typelist").append(
						"<span><a href='zxd/findType?otype="+data[i].otype+"'>"+data[i].otype
						+"<em>("+data[i].num+")</em></a></span>");
			sum+=parseInt(data[i].num);		
		}
		$("#typelist").append(" <span><a href='javascript:void(0)' onclick='getExpress(1)'>全部<em>("+sum+")</em></a></span>");
		$("#typelist a").click(function(){
			listExpress(this.href);
			return false;
		});
		
	},"json");
}
getType();

function  listExpress(url){
	function getExpress02(pageNum){
		$.post(url+"&page="+pageNum,function(data){
			$("#expressList").empty();
			var expresses= data.rows;
			for(var i=0;i<expresses.length;i++){
				$("#expressList").append("<li class='topic'><div class='u_photo'>"+
					"<img src='image/85_avatar_m.jpg'height='48' width='48'>"+
					"<div style='width:48px;height:20px;line-height:20px;font-size:13px;" +
					"font-family:'微软雅黑';text-align:center;color:#E76D26;' >"+expresses[i].uname+"</div>"+
					"</div><div class='u_post'><div class='btn_order'></div>"+
					"<div class='li_1' style='line-height: 21px;'>"+
					"<a style='font-size: 18px; font-family: '微软雅黑';' class='i_title'"+
					"href='javascript:void(0)'>"+expresses[i].otype+"</a></div>"+
					"<div class='li_2' style='margin-top: 15px;'>"+
					"<a href='javascript:void(0)'>"+expresses[i].zaddr+"</a> <em class='li_s'>"+expresses[i].otime+"</em>" +
					"<em class='readNum li_s'>"+expresses[i].osize+"</em><em class='collectNum li_s'>" +
					"<span class='money'>￥"+expresses[i].oprice+"</span></em></div>"+
					"<div class='li_3' style='font-size: 14px; font-family: '微软雅黑';" +
					" padding-top: 10px;'>"+expresses[i].odesc +
					"</div></div></li>");
				
				
			}
			$("#pagation").empty();
			if(pageNum<5){
				switch(pageNum){
				case 1:
					$("#pagation").append("<ul><li><span>1</span></li>" +
							"<li><a href='javascript:void(0)'  onclick='getExpress02(2)'>"+2
							+"</a></li><li><a href='javascript:void(0)'  onclick='getExpress02(3)'>"+3
							+"</a></li><li><a href='javascript:void(0)'  onclick='getExpress02(4)'>"+4
							+"</a></li><li><a href='javascript:void(0)'  onclick='getExpress02(5)'>"+5
							+"</a></li><li><em style='javascript:void(0)'  onclick='getExpress02(1)'>...</em></li>"
							+"<li><a href='javascript:void(0)'  onclick='getExpress02("+data.totalPage+")'>"+data.totalPage
							+"</a></li><li><a href='javascript:void(0)'  onclick='getExpress02("+(data.currPage+1)+")'"
							+">下一页</a></li></ul>") ;
					break;
				case 2:
					$("#pagation").append("<ul><li><a href='javascript:void(0)'  onclick='getExpress02(1)'>"+1+"</a></li>" +
							"<li><span>2</span></li><li><a href='javascript:void(0)'  onclick='getExpress02(3)'>"+3
							+"</a></li><li><a href='javascript:void(0)'  onclick='getExpress02(4)'>"+4
							+"</a></li><li><a href='javascript:void(0)'  onclick='getExpress02(5)'>"+5
							+"</a></li><li><em style='javascript:void(0)'  onclick='getExpress02(1)'>...</em></li>"
							+"<li><a href='javascript:void(0)'  onclick='getExpress02("+data.totalPage+")'>"+data.totalPage
							+"</a></li><li><a href='javascript:void(0)'  onclick='getExpress02("+(data.currPage+1)+")'"
							+">下一页</a></li></ul>") ;
					break;
				case 3:
					$("#pagation").append("<ul><li><a href='javascript:void(0)'  onclick='getExpress02(1)'>"+1+"</a></li>" +
							"<li><a href='javascript:void(0)'  onclick='getExpress02(2)'>"+2
							+"</a></li><li><span>3</span></li><li><a href='javascript:void(0)'  onclick='getExpress02(4)'>"+4
							+"</a></li><li><a href='javascript:void(0)'  onclick='getExpress02(5)'>"+5
							+"</a></li><li><em style='javascript:void(0)'  onclick='getExpress02(1)'>...</em></li>"
							+"<li><a href='javascript:void(0)'  onclick='getExpress02("+data.totalPage+")'>"+data.totalPage
							+"</a></li><li><a href='javascript:void(0)'  onclick='getExpress02("+(data.currPage+1)+")'"
							+">下一页</a></li></ul>") ;
					break;
				case 4:
					$("#pagation").append("<ul><li><a href='javascript:void(0)'  onclick='getExpress02(1)'>"+1+"</a></li>" +
							"<li><a href='javascript:void(0)'  onclick='getExpress02(2)'>"+2
							+"</a></li><li><a href='javascript:void(0)'  onclick='getExpress02(3)'>"+3
							+"</a></li><li><span>4</span></li><li><a href='javascript:void(0)'  onclick='getExpress02(5)'>"+5
							+"</a></li><li><em style='javascript:void(0)'  onclick='getExpress02(1)'>...</em></li>"
							+"<li><a href='javascript:void(0)'  onclick='getExpress02("+data.totalPage+")'>"+data.totalPage
							+"</a></li><li><a href='javascript:void(0)'  onclick='getExpress02("+(data.currPage+1)+")'"
							+">下一页</a></li></ul>") ;
					break;
				default:"参数错误！！！";
				}
				
			}else if(pageNum==data.totalPage||pageNum==data.totalPage-1){
				switch(pageNum){
				case data.totalPage-1:
					$("#pagation").append("<ul><li><a href='javascript:void(0)' onclick='getExpress02(1)'>1</a></li>" +
							"<li><em style='display:block; height:30px; line-height:16px;'>...</em>" +
							"</li><li><a href='javascript:void(0)' onclick='getExpress02("+(data.totalPage-4)+")'>"+(data.totalPage-4)+"</a></li>" +
							"<li><a href='javascript:void(0)' onclick='getExpress02("+(data.totalPage-3)+")'>"+(data.totalPage-3)+"</a></li>" +
							"<li><a href='javascript:void(0)' onclick='getExpress02("+(data.totalPage-2)+")'>"+(data.totalPage-2)+"</a></li>" +
							"<li><span>"+(data.totalPage-1)+"</span></li>" +
							"<li><a href='javascript:void(0)' onclick='getExpress02("+data.totalPage+")'>"+data.totalPage+"</a></li>" +
							"<li><a href='javascript:void(0)'  onclick='getExpress02("+(data.currPage+1)+")'>下一页</a></li></ul>");
					break;
				case data.totalPage:
					$("#pagation").append("<ul><li><a href='javascript:void(0)' onclick='getExpress02(1)'>1</a></li>" +
							"<li><em style='display:block; height:30px; line-height:16px;'>...</em>" +
							"</li><li><a href='javascript:void(0)' onclick='getExpress02("+(data.totalPage-4)+")'>"+(data.totalPage-4)+"</a></li>" +
							"<li><a href='javascript:void(0)' onclick='getExpress02("+(data.totalPage-3)+")'>"+(data.totalPage-3)+"</a></li>" +
							"<li><a href='javascript:void(0)' onclick='getExpress02("+(data.totalPage-2)+")'>"+(data.totalPage-2)+"</a></li>" +
							"<li><a href='javascript:void(0)' onclick='getExpress02("+(data.totalPage-1)+")'>"+(data.totalPage-1)+"</a></li>" +
							"<li><span>"+data.totalPage+"</span></li></ul>");
					break;
				default:"参数错误！！！";
				}
				
			}
			else if(pageNum>=5&&pageNum<=data.totalPage-2){
					$("#pagation").append("<ul><li><a href='javascript:void(0)' onclick='getExpress02(1)'>1</a></li><li>" +
							"<em style='display:block; height:30px; line-height:16px;'>...</em>"+
					        "</li><li><a href='javascript:void(0)' onclick='getExpress02("+(data.currPage-2)+")'>"+(data.currPage-2)+"</a></li>" +
							"<li><a href='javascript:void(0)' onclick='getExpress02("+(data.currPage-1)+")'>"+(data.currPage-1)+"</a></li>" +
							"<li><span>"+data.currPage+"</span></li>" +
							"<li><a href='javascript:void(0)' onclick='getExpress02("+(data.currPage+1)+")'>"+(data.currPage+1)+"</a></li>" +
							"<li><a href='javascript:void(0)' onclick='getExpress02("+(data.currPage+2)+")'>"+(data.currPage+2)+"</a></li>" +
							"<li><em style='display:block; height:30px; line-height:16px;'>...</em>"+
							"</li><li><a href='javascript:void(0)' onclick='getExpress02("+data.totalPage+")'>"+data.totalPage+"</a></li>" +
							"<li><a href='javascript:void(0)'  onclick='getExpress02("+(data.currPage+1)+")'>下一页</a></li></ul>");
			}

		},"json");
	}
	getExpress02(1);
	
}