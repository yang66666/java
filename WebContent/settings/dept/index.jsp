<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		var pageNo = 1;
		var pageCount = 5;
		var pageSize = 0;
		var total = 0;
		
		pageList();
		
		function pageList(){
			
			$("#create-code").val("");
			$("#create-name").val("");
			$("#create-manager").val("");
			$("#create-phone").val("");
			$("#create-describe").val("");
			
			$.post(
				"dept/list.do",
				{"pageNo":pageNo},
				function(data){
					pageNo = data.pu.pageNo;
					pageCount = data.pu.pageCount;
					pageSize = data.pu.pageSize;
					total = data.pu.total;
					
					$("#myBody").html("");
					
					$(data.dList).each(function(){
						
						$("#myBody").append("<tr><td><input type='checkbox' name='xz' value='"+this.id+"'/></td><td>"+this.no+"</td><td>"+this.name+"</td><td>"+this.manager+"</td><td>"+this.phone+"</td><td>"+this.description+"</td></tr>");              
						$("#myPageNo").html(pageNo);
						$("#myPageSize").html(pageSize);
						$("#myPageCount").html(pageCount);
						$("#myTotal").html(total);
						
					})
					
					btnCss();
					
				},
				"json"
			)
		}
		
		function btnCss(){
			
			if(pageNo==1){
				$("#proPage").addClass("disabled");
				$("#firstPage").addClass("disabled");
				$("#nextPage").removeClass("disabled");
				$("#lastPage").removeClass("disabled");
				
			}else if(pageNo!=1&&pageNo!=pageSize){
				$("#proPage").removeClass("disabled");
				$("#firstPage").removeClass("disabled");
				$("#nextPage").removeClass("disabled");
				$("#lastPage").removeClass("disabled");
			}else if(pageNo==pageSize){
				$("#proPage").removeClass("disabled");
				$("#firstPage").removeClass("disabled");
				$("#nextPage").addClass("disabled");
				$("#lastPage").addClass("disabled");
			}
			
		}
		
		$("#nextPage").click(function(){
			
			if(pageNo==pageSize){
				return false;
			}
			pageNo++;
			pageList();
		
		})
		
		$("#proPage").click(function(){
			
			if(pageNo==1){
				return false;
			}
			pageNo--;
			pageList();
		
		})
		
		$("#firstPage").click(function(){
			
			if(pageNo==1){
				return false;
			}
			pageNo=1;
			pageList();
		
		})
		
		$("#lastPage").click(function(){
			
			if(pageNo==pageSize){
				return false;
			}
			pageNo=pageSize;
			pageList();
		
		})
		
		$("#bc").click(function(){
			
			
			var no = $("#create-code").val();
			var name = $("#create-name").val();
			var manager = $("#create-manager").val();
			var phone = $("#create-phone").val();
			var description = $("#create-describe").val();
			
			$.post(
				"dept/save.do",
				{"no":no,"name":name,"manager":manager,"phone":phone,"description":description},
				function(data){
					$("#createDeptModal").modal("hide");//关闭模态窗口
					pageNo=1;
					pageList();
					
				}
			)
			
		
		})
		
		$("#bj").click(function(){
			
			var $xz = $("input[name='xz']:checked");
			
			if($xz.length!=1){
				alert("请选择需要编辑的记录");
			}else{
				
				//获取id
				var id = $xz.val();
				
				$.post(
					"dept/edit.do",
					{"id":id},
					function(data){
						
						$("#editDeptModal").modal("show");
						
						$("#edit-id").val(data.id);
						$("#edit-code").val(data.no);
						$("#edit-name").val(data.name);
						$("#edit-manager").val(data.manager);
						$("#edit-phone").val(data.phone);
						$("#edit-describe").val(data.description);
						
						
					},
					"json"
				)
				
			}
			
		})
		
		$("#gx").click(function(){
			
			var id = $("#edit-id").val();
			var no = $("#edit-code").val();
			var name = $("#edit-name").val();
			var manager = $("#edit-manager").val();
			var phone = $("#edit-phone").val();
			var description = $("#edit-describe").val();
			
			
			$.post(
				"dept/update.do",
				{"id":id,"no":no,"name":name,"manager":manager,"phone":phone,"description":description},
				function(data){
					$("#editDeptModal").modal("hide");
					pageNo=1;
					pageList();
				}
			
			)
			
			
		
		})
		
		$("#sc").click(function(){
			
			var $xz = $("input[name='xz']:checked");
			
			if($xz.length==0){
				alert("请选择需要删除的记录");
			}else{
				
				if(confirm("确定要删除吗?")){
					var rel = "";
					for(var i=0;i<$xz.length;i++){
						
						rel += "id="+$xz[i].value;
						
						if(i<$xz.length-1){
							rel+="&";
						}
						
					}
					
					$.post(
						"dept/delete.do",
						rel,
						function(data){
							pageNo = 1;
							pageList();
						}
					
					)
				}else{
					
				}
				
				
				
				
				
			}
			
		})
		
		
		
		
	})
	
</script>
</head>
<body>

	<!-- 我的资料 -->
	<div class="modal fade" id="myInformation" role="dialog">
		<div class="modal-dialog" role="document" style="width: 30%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">我的资料</h4>
				</div>
				<div class="modal-body">
					<div style="position: relative; left: 40px;">
						姓名：<b>张三</b><br><br>
						登录帐号：<b>zhangsan</b><br><br>
						组织机构：<b>1005，市场部，二级部门</b><br><br>
						邮箱：<b>zhangsan@bjpowernode.com</b><br><br>
						失效时间：<b>2017-02-14 10:10:10</b><br><br>
						允许访问IP：<b>127.0.0.1,192.168.100.2</b>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 修改密码的模态窗口 -->
	<div class="modal fade" id="editPwdModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 70%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">修改密码</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="oldPwd" class="col-sm-2 control-label">原密码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="oldPwd" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="newPwd" class="col-sm-2 control-label">新密码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="newPwd" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="confirmPwd" class="col-sm-2 control-label">确认密码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="confirmPwd" style="width: 200%;">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="window.location.href='../login.html';">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 退出系统的模态窗口 -->
	<div class="modal fade" id="exitModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 30%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">离开</h4>
				</div>
				<div class="modal-body"> 
					<p>您确定要退出系统吗？</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="window.location.href='../../login.html';">确定</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 顶部 -->
	<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
		<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2017&nbsp;动力节点</span></div>
		<div style="position: absolute; top: 15px; right: 15px;">
			<ul>
				<li class="dropdown user-dropdown">
					<a href="javascript:void(0)" style="text-decoration: none; color: white;" class="dropdown-toggle" data-toggle="dropdown">
						<span class="glyphicon glyphicon-user"></span> zhangsan <span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="../../workbench/index.html"><span class="glyphicon glyphicon-home"></span> 工作台</a></li>
						<li><a href="../index.html"><span class="glyphicon glyphicon-wrench"></span> 系统设置</a></li>
						<li><a href="javascript:void(0)" data-toggle="modal" data-target="#myInformation"><span class="glyphicon glyphicon-file"></span> 我的资料</a></li>
						<li><a href="javascript:void(0)" data-toggle="modal" data-target="#editPwdModal"><span class="glyphicon glyphicon-edit"></span> 修改密码</a></li>
						<li><a href="javascript:void(0);" data-toggle="modal" data-target="#exitModal"><span class="glyphicon glyphicon-off"></span> 退出</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- 创建部门的模态窗口 -->
	<div class="modal fade" id="createDeptModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-plus"></span> 新增部门</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-code" class="col-sm-2 control-label">编号<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-code" style="width: 200%;" placeholder="编号为四位数字，不能为空，具有唯一性">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-name" class="col-sm-2 control-label">名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-name" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-manager" class="col-sm-2 control-label">负责人</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-manager" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-phone" class="col-sm-2 control-label">电话</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-phone" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 55%;">
								<textarea class="form-control" rows="3" id="create-describe"></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="bc">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改部门的模态窗口 -->
	<div class="modal fade" id="editDeptModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-edit"></span> 编辑部门</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-code" class="col-sm-2 control-label">编号<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-code" style="width: 200%;" placeholder="编号为四位数字，不能为空，具有唯一性">
								<input type="hidden" id="edit-id"/>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-name" class="col-sm-2 control-label">名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-name" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-manager" class="col-sm-2 control-label">负责人</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-manager" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-phone" class="col-sm-2 control-label">电话</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-phone" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 55%;">
								<textarea class="form-control" rows="3" id="edit-describe"></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="gx">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	<div style="width: 95%">
		<div>
			<div style="position: relative; left: 30px; top: -10px;">
				<div class="page-header">
					<h3>部门列表jsp</h3>
				</div>
			</div>
		</div>
		<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px; top:-30px;">
			<div class="btn-group" style="position: relative; top: 18%;">
			  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createDeptModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
			  <button type="button" class="btn btn-default" data-toggle="modal" id="bj"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			  <button type="button" class="btn btn-danger" id="sc"><span class="glyphicon glyphicon-minus"></span> 删除</button>
			</div>
		</div>
		<div style="position: relative; left: 30px; top: -10px;">
			<table class="table table-hover">
				<thead>
					<tr style="color: #B3B3B3;">
						<td><input type="checkbox" /></td>
						<td>编号</td>
						<td>名称</td>
						<td>负责人</td>
						<td>电话</td>
						<td>描述</td>
					</tr>
				</thead>
				<tbody id="myBody">
				
					<%-- <c:if test="${empty dList}">
						<tr>
							<td align="center" colspan="6">
								没有记录
							</td>
						</tr>
					</c:if>
					
					<c:if test="${!empty dList}">
						<c:forEach items="${dList}" var="d">
							<tr style="color: #B3B3B3;">
								<td><input type="checkbox" /></td>
								<td>${d.no}</td>
								<td>${d.name}</td>
								<td>${d.manager}</td>
								<td>${d.phone}</td>
								<td>${d.description}</td>
							</tr>
						</c:forEach>
					</c:if> --%>
				
					<!-- <tr class="active">
						<td><input type="checkbox" /></td>
						<td>1110</td>
						<td>财务部</td>
						<td>张飞</td>
						<td>010-84846005</td>
						<td>description info</td>
					</tr>
					<tr>
						<td><input type="checkbox" /></td>
						<td>1120</td>
						<td>销售部</td>
						<td>关羽</td>
						<td>010-84846006</td>
						<td>description info</td>
					</tr> -->
				</tbody>
			</table>
		</div>
		
		<div style="height: 50px; position: relative;top: 0px; left:30px;">
			<div>
				<button type="button" class="btn btn-default" style="cursor: default;">共<b id="myTotal"></b>条记录</button>
			</div>
			<div class="btn-group" style="position: relative;top: -34px; left: 110px;">
				<button type="button" class="btn btn-default" style="cursor: default;">共<b id="myPageSize"></b>页</button>
				
				<button type="button" class="btn btn-default" style="cursor: default;"><b id="myPageCount"></b>条/页</button>
				<button type="button" class="btn btn-default" style="cursor: default;">第<b id="myPageNo"></b>页</button>
			</div>
			<div style="position: relative;top: -88px; left: 320px;">
				<nav>
					<ul class="pagination">
						<li id="firstPage"><a href="javascript:void(0)">首页</a></li>
						<li id="proPage"><a href="javascript:void(0)">上一页</a></li>
						<li id="nextPage"><a href="javascript:void(0)">下一页</a></li>
						<li id="lastPage"><a href="javascript:void(0)">末页</a></li>
					</ul>
				</nav>
			</div>
		</div>
			
	</div>
</body>
</html>