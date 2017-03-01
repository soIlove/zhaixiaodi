$('#userList').datagrid({
	url : 'admin/list',
	loadMsg: "数据加载中...",
	pagination : true, //底部显示分页工具栏
	toolbar : '#toolSignIn',
	pageList : [ 5, 10, 15, 20, 25, 30 ],/* 每页的条数(可选) */
	fitColumns : true,// 自适应
	singleSelect : true,// 只能选择一条(单选)
	columns : [ [{field : 'uuid',title : '用户编号',width : 70,align : 'center'},
				{field : 'uname',title : '姓名',width : 85,align : 'center'},
				{field : 'usex',title : '性别',width : 70,align : 'center'},
				{field : 'uphone',title : '电话',width : 110,align : 'center'},
				{field : 'uemail',title : '邮箱',width : 130,align : 'center'},
				{field : 'uaddr',title : '地址',width : 130,align : 'center'},
				{field : 'utype',title : '用户身份',width : 85,align : 'center',
					formatter : function(value, row, index) {
						if (row.utype == 1	 ) {
							return "待递员";
						} else {
							return "普通用户";
					}
		}
				},
				{field : 'upicture',title : '照片',width : 130,align : 'center',
					formatter : function(value, row, index) {
									if (row.upicture == null	|| row.upicture == "\\upload\\") {
										return "<img width='100' src='image/1.jpg'/>"
									} else {
										return "<img width='100' src='"	+ row.upicture + "'/>"
								}
					}
				},
				{field : 'opr',title : '操作',width : 100,align : 'center',
					formatter : function(value, row, index) {
								var oprStr =  '<a class="modifyBtn" href="javascript:void(0)" onclick="openUpdate('
											+ index
											+ ')">删除</a>  '
											+ '<script>$(".modifyBtn").linkbutton({iconCls: "icon-edit"});  </script>';
									return oprStr;
								}

							}, ] ]
				});



//搜索员工
function searchSignInInfo() {
	var tel = $("#tel").val();
	$.get(	"zxd/search?tel=" + tel,
			 function(data) {
				 $('#userList').datagrid('loadData', {
					 total : 0,
					 rows : []
				 });
						if (data != null) {
							for (var i = 0; i < data.length; i++) {
								$('#userList').datagrid('appendRow',{
									uuid : data[i].uuid,
									uname : data[i].uname,
									usex : data[i].usex,
									uphone : data[i].uphone,
									uemail : data[i].uemail,
									uaddr : data[i].uaddr,
									utype : function(value,	row, index) { 
										if (row.utype == 1	 ) {
											return "待递员";
										} else {
											return "普通用户";
										} 
									},
									upicture : function(value,	row, index) { 
										if (row.upicture == null	|| row.upicture == "\\upload\\") {
											return "<img width='100' src='image/1.jpg'/>";
										} else {
											return "<img width='100' src='"	+ row.upicture + "'/>";
										}
									},
									
									opr : function(value, row, index) { 
										var oprStr =  '<a class="modifyBtn" href="javascript:void(0)" onclick="openUpdate('
											+ index
											+ ')">删除</a>  '
											+ '<script>$(".modifyBtn").linkbutton({iconCls: "icon-edit"});  </script>';
									return oprStr;
									}
									
								});
							}
						}
					}, "json");
	$("#tel").val("");//清空搜索框
}


$("#modifyDiv").dialog({
	title : "用户修改",
	closable : false,
});

$(".closeBtn").linkbutton({
	iconCls : "icon-cancel",
	onClick : function() {
		$("#modifyDiv").dialog("close");

	}
});
$(".updateBtn").linkbutton({
	iconCls : "icon-ok",
	onClick : function() {
		$("#modifyForm").submit();
	}
});

$("#modifyDiv").dialog("close");

$("#modifyForm").form(
		{
			url : "user/modify",
			success : function(data) {
				if (data == null || data == "") {
					$.messager.alert("用户修改", "没有权限", "warning");
					$("#modifyDiv").dialog("close");
					return;
				}
				if (data.trim() == "true") {
					$("#modifyDiv").dialog("close");
					$('#userList').datagrid("reload");

				} else {
					$.messager.show({
						title : '修改信息',
						msg : '修改失败!!',
						showType : 'show',
						style : {
							top : document.body.scrollTop
									+ document.documentElement.scrollTop,
							bottom : ''
						}
					});

				}
			}

		});

function openUpdate(index) {
	$("#modifyDiv").dialog("open");
	var row = $("#userList").datagrid("getRows")[index];
	// alert(JSON.stringify(row));
	$("#uid").val(row.id);
	$("#uname").val(row.name);
	$("#ubirthday").val(row.birthday);
	$("#ugender").val(row.gender);
	$("#ucareer").val(row.career);
	$("#uaddress").val(row.address);
	$("#umobile").val(row.mobile);
	if (row.picPath != "\\upload\\") {
		$("#pic").attr("src", row.picPath);
	} else {
		$("#pic").attr("src", "image/1.jpg");
	}
}

function changePic(obj) {
	$("#pic").attr("src", window.URL.createObjectURL(obj.files[0]));
}
