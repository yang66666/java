<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
	
	String id = request.getParameter("id");
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="jquery/zTree_v3-master/css/zTreeStyle/zTreeStyle.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="jquery/zTree_v3-master/js/jquery.ztree.all.min.js"></script>
<script type="text/javascript">

	$(function(){
		
		var id = "<%=id%>";
		
		showDetail();
		
		function showDetail(){
			$.post(
					"user/detail.do",
					{"id":id},
					function(data){
						
						$("#myLoginAct").html(data.loginAct);
						$("#myName").html(data.name);
						$("#myEmail").html(data.email);
						$("#myExpireTime").html(data.expireTime);
						$("#myAllowIps").html(data.allowIps);
						$("#myLockStatus").html(data.lockStatusText);
						$("#myDeptName").html(data.deptName);
						
					},
					"json"
				)
		}
		
		$("#bj").click(function(){
			
			$.post(
				"user/edit.do",
				{"id":id},
				function(data){
					
					$("#editUserModal").modal("show");
					
					$("#edit-loginActNo").val(data.loginAct);
					$("#edit-username").val(data.name);
					$("#edit-loginPwd").val(data.loginPwd);
					$("#edit-confirmPwd").val(data.loginPwd);
					$("#edit-email").val(data.email);
					$("#edit-expireTime").val(data.expireTime);
					$("#edit-lockStatus").val(data.lockStatus);
					$("#create-org").val(data.deptNo);
					$("#edit-allowIps").val(data.allowIps);
					
					
				},
				"json"
			)
			
		
		})
		
		$("#gx").click(function(){
			
			var loginAct = $("#edit-loginActNo").val();
			var name = $("#edit-username").val();
			var loginPwd = $("#edit-loginPwd").val();
			var loginPwd = $("#edit-confirmPwd").val();
			var email = $("#edit-email").val();
			var expireTime = $("#edit-expireTime").val();
			var lockStatus = $("#edit-lockStatus").val();
			var deptNo = $("#create-org").val();
			var allowIps = $("#edit-allowIps").val();
			
			$.post(
				"user/update.do",
				{"id":id,"loginAct":loginAct,"name":name,"loginPwd":loginPwd,"email":email,"expireTime":expireTime,"lockStatus":lockStatus,"deptNo":deptNo,"allowIps":allowIps},
				function(data){
					$("#editUserModal").modal("hide");
					showDetail();
				}
			)
		
		})
		
		
	
	})

</script>

</head>
<body>
	
	
	<!-- 分配许可的模态窗口 -->
	<div class="modal fade" id="assignRoleForUserModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">为<b>张三</b>分配角色</h4>
				</div>
				<div class="modal-body">
					<table width="90%" border="0" cellspacing="0" cellpadding="0" align="center">
						<tr>
							<td width="42%">
								<div class="list_tit" style="border: solid 1px #D5D5D5; background-color: #F4F4B5;">
									张三，未分配角色列表
								</div>
							</td>
							<td width="15%">
								&nbsp;
							</td>
							<td width="43%">
								<div class="list_tit" style="border: solid 1px #D5D5D5; background-color: #F4F4B5;">
									张三，已分配角色列表
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<select size="15" name="srcList" id="srcList"
									style="width: 100%" multiple="multiple">
									<option>
										总裁
									</option>
									<option>
										市场部普通职员
									</option>
									<option>
										市场总监
									</option>
									<option>
										销售部销售员
									</option>
									<option>
										销售总监
									</option>
								</select>
							</td>
							<td>
								<p align="center">
									<a href="javascript:void(0);" title="分配角色"><span class="glyphicon glyphicon-chevron-right" style="font-size: 20px;"></span></a>
								</p>
								<br><br>
								<p align="center">
									<a href="javascript:void(0);" title="撤销角色"><span class="glyphicon glyphicon-chevron-left" style="font-size: 20px;"></span></a>
								</p>
							</td>
							<td>
								<select name="destList" size="15" multiple="multiple"
									id="destList" style="width: 100%">
									<option>
										副总裁
									</option>
								</select>
							</td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 编辑用户的模态窗口 -->
	<div class="modal fade" id="editUserModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改用户</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="edit-loginActNo" class="col-sm-2 control-label">登录帐号<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-loginActNo">
							</div>
							<label for="edit-username" class="col-sm-2 control-label">用户姓名</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-username">
							</div>
						</div>
						<div class="form-group">
							<label for="edit-loginPwd" class="col-sm-2 control-label">登录密码<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="password" class="form-control" id="edit-loginPwd">
							</div>
							<label for="edit-confirmPwd" class="col-sm-2 control-label">确认密码<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="password" class="form-control" id="edit-confirmPwd">
							</div>
						</div>
						<div class="form-group">
							<label for="edit-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-email">
							</div>
							<label for="edit-expireTime" class="col-sm-2 control-label">失效时间</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-expireTime">
							</div>
						</div>
						<div class="form-group">
							<label for="edit-lockStatus" class="col-sm-2 control-label">锁定状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-lockStatus">
								  <option></option>
								  <option value="1">启用</option>
								  <option value="0">锁定</option>
								</select>
							</div>
							<label for="create-org" class="col-sm-2 control-label">部门名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-org">
							</div>
						</div>
						<div class="form-group">
							<label for="edit-allowIps" class="col-sm-2 control-label">允许访问的IP</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-allowIps" style="width: 280%" placeholder="多个用逗号隔开">
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

	<div>
		<div style="position: relative; left: 30px; top: -10px;">
			<div class="page-header">
				<h3>用户明细 <small>张三</small></h3>
			</div>
			<div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 80%;">
				<button type="button" class="btn btn-default" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left"></span> 返回</button>
			</div>
		</div>
	</div>
	
	<div style="position: relative; left: 60px; top: -50px;">
		<ul id="myTab" class="nav nav-pills">
			<li class="active"><a href="#role-info" data-toggle="tab">用户信息<%=id%></a></li>
			<li><a href="#permission-info" data-toggle="tab">许可信息</a></li>
		</ul>
		<div id="myTabContent" class="tab-content">
			<div class="tab-pane fade in active" id="role-info">
				<div style="position: relative; top: 20px; left: -30px;">
					<div style="position: relative; left: 40px; height: 30px; top: 20px;">
						<div style="width: 300px; color: gray;">登录帐号</div>
						<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="myLoginAct"></b></div>
						<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
					</div>
					<div style="position: relative; left: 40px; height: 30px; top: 40px;">
						<div style="width: 300px; color: gray;">用户姓名</div>
						<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="myName"></b></div>
						<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
					</div>
					<div style="position: relative; left: 40px; height: 30px; top: 60px;">
						<div style="width: 300px; color: gray;">邮箱</div>
						<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="myEmail"></b></div>
						<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
					</div>
					<div style="position: relative; left: 40px; height: 30px; top: 80px;">
						<div style="width: 300px; color: gray;">失效时间</div>
						<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="myExpireTime"></b></div>
						<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
					</div>
					<div style="position: relative; left: 40px; height: 30px; top: 100px;">
						<div style="width: 300px; color: gray;">允许访问IP</div>
						<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="myAllowIps"></b></div>
						<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
					</div>
					<div style="position: relative; left: 40px; height: 30px; top: 120px;">
						<div style="width: 300px; color: gray;">锁定状态</div>
						<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="myLockStatus"></b></div>
						<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
					</div>
					<div style="position: relative; left: 40px; height: 30px; top: 140px;">
						<div style="width: 300px; color: gray;">部门名称</div>
						<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="myDeptName"></b></div>
						<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
						<button style="position: relative; left: 76%; top: -40px;" type="button" class="btn btn-default" data-toggle="modal" id="bj"><span class="glyphicon glyphicon-edit"></span> 编辑1</button>
					</div>
				</div>
			</div>
			<div class="tab-pane fade" id="permission-info">
				<div style="position: relative; top: 20px; left: 0px;">
					<ul id="treeDemo" class="ztree" style="position: relative; top: 15px; left: 15px;"></ul>
					<div style="position: relative;top: 30px; left: 76%;">
						<button type="button" class="btn btn-default" data-toggle="modal" data-target="#assignRoleForUserModal"><span class="glyphicon glyphicon-edit"></span> 分配角色</button>
					</div>
				</div>
			</div>
		</div>
	</div>	
	
</body>
</html>