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
			
			//高级查询的内容
			var name1 = $("#name1").val();
			var dept1 = $("#dept1").val();
			var lock1 = $("#lock1").val();
			var time1 = $("#time1").val();
			var time2 = $("#time2").val();
			
			
			$.post(
				"user/list.do?aaab="+new Date().getTime(),
				{"mnum":Math.random(),"pageNo":pageNo,"name1":name1,"dept1":dept1,"lock1":lock1,"time1":time1,"time2":time2},
				function(data){
					
					$("#myBody").html("");
					pageNo = data.pu.pageNo;
					pageCount = data.pu.pageCount;
					pageSize = data.pu.pageSize;
					total = data.pu.total;
					
					$(data.uList).each(function(){
						
						$("#myBody").append("<tr class='active'><td><input type='checkbox' name='xz' value='"+this.id+"'/></td><td>1</td><td><a  href='settings/qx/user/detail.jsp?id="+this.id+"'>"+this.loginAct+"</a></td><td>"+this.name+"</td><td>"+this.deptName+"</td><td>"+this.email+"</td><td>"+this.expireTime+"</td><td>"+this.allowIps+"</td><td><a href='javascript:void("+this.id+");' id='zt' style='text-decoration: none;'>"+this.lockStatusText+"</a></td><td>"+this.createBy+"</td><td>"+this.createTime+"</td><td>"+this.editBy+"</td><td>"+this.editTime+"</td></tr>");
					
					})
					$("#myPageNo").html(pageNo);
						$("#myPageSize").html(pageSize);
						$("#myPageCount").html(pageCount);
						$("#myTotal").html(total);
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
		
		
		$("#cx").click(function(){
			
			pageList();
			
			/* var name1 = $("#name1").val();
			var dept1 = $("#dept1").val();
			var lock1 = $("#lock1").val();
			var time1 = $("#time1").val();
			var time2 = $("#time2").val(); */
		})
		
		$("#bc").click(function(){
			//alert(new Date().getTime());
			var loginAct = $("#create-loginActNo").val();
			var name = $("#create-username").val();
			var loginPwd = $("#create-loginPwd").val();
			var email = $("#create-email").val();
			var expireTime = $("#create-expireTime").val();
			var lockStatus = $("#create-lockStatus").val();
			var deptNo = $("#create-org").val();//部门编号
			var allowIps = $("#create-allowIps").val();
			
			$.post(
				"user/save.do?aaa="+new Date().getTime(),
				{"mnum":Math.random(),"loginAct":loginAct,"name":name,"loginPwd":loginPwd,"email":email,"expireTime":expireTime,"lockStatus":lockStatus,"deptNo":deptNo,"allowIps":allowIps},
				function(data){
					
					$("#createUserModal").modal("hide");
					
					pageNo = 1;
					pageList();
				}
				
			)
		
		})
		
		$("#sc").click(function(){
			
			var $xz = $("input[name='xz']:checked");
			
			var param = "";
			
			for(var i=0;i<$xz.length;i++){
				
				param += "id="+$($xz[i]).val();
				
				if(i<$xz.length-1){
					param+="&"
				}
			
			}
			
			$.post(
				"user/delete.do",
				param,
				function(data){
					pageNo=1;
					pageList();
				}
			)
			
		
		})
		
		$("body").delegate("#zt","click",function(){
			
			var param = this+"";
			
			$.post(
				"user/changeLs.do",
				{"param":param},
				function(data){
					pageList();
				}
			)
			
			
		});
	
	})

</script>
</head>
<body>

	<!-- 创建用户的模态窗口 -->
	<div class="modal fade" id="createUserModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增用户</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-loginActNo" class="col-sm-2 control-label">登录帐号<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-loginActNo">
							</div>
							<label for="create-username" class="col-sm-2 control-label">用户姓名</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-username">
							</div>
						</div>
						<div class="form-group">
							<label for="create-loginPwd" class="col-sm-2 control-label">登录密码<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="password" class="form-control" id="create-loginPwd">
							</div>
							<label for="create-confirmPwd" class="col-sm-2 control-label">确认密码<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="password" class="form-control" id="create-confirmPwd">
							</div>
						</div>
						<div class="form-group">
							<label for="create-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-email">
							</div>
							<label for="create-expireTime" class="col-sm-2 control-label">失效时间</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-expireTime">
							</div>
						</div>
						<div class="form-group">
							<label for="create-lockStatus" class="col-sm-2 control-label">锁定状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-lockStatus">
								  <option></option>
								  <option>启用</option>
								  <option>锁定</option>
								</select>
							</div>
							<label for="create-org" class="col-sm-2 control-label">部门<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-org" placeholder="输入部门名称，自动补全">
							</div>
						</div>
						<div class="form-group">
							<label for="create-allowIps" class="col-sm-2 control-label">允许访问的IP</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-allowIps" style="width: 280%" placeholder="多个用逗号隔开">
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
	
	
	<div>
		<div style="position: relative; left: 30px; top: -10px;">
			<div class="page-header">
				<h3>用户列表123</h3>
			</div>
		</div>
	</div>
	
	<div class="btn-toolbar" role="toolbar" style="position: relative; height: 80px; left: 30px; top: -10px;">
		<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
		  
		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">用户姓名1</div>
		      <input class="form-control" type="text" id="name1">
		    </div>
		  </div>
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">部门名称1</div>
		      <input class="form-control" type="text" id="dept1">
		    </div>
		  </div>
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">锁定状态1</div>
			  <select class="form-control" id="lock1">
			  	  <option></option>
			      <option value="0">锁定</option>
				  <option value="1">启用</option>
			  </select>
		    </div>
		  </div>
		  <br><br>
		  
		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">失效时间</div>
			  <input class="form-control" type="text" id="time1" />
		    </div>
		  </div>
		  
		  ~
		  
		  <div class="form-group">
		    <div class="input-group">
			  <input class="form-control" type="text" id="time2" />
		    </div>
		  </div>
		</form>
		<button class="btn btn-default" id="cx">查询</button>
	</div>
	
	
	<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px; width: 110%; top: 20px;">
		<div class="btn-group" style="position: relative; top: 18%;">
		  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createUserModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
		  <button type="button" class="btn btn-danger" id="sc"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
		
	</div>
	
	
	<div style="position: relative; left: 30px; top: 40px; width: 110%">
		<table class="table table-hover">
			<thead>
				<tr style="color: #B3B3B3;">
					<td><input type="checkbox" /></td>
					<td>序号</td>
					<td>登录帐号</td>
					<td>用户姓名</td>
					<td>部门名称</td>
					<td>邮箱</td>
					<td>失效时间</td>
					<td>允许访问IP</td>
					<td>锁定状态</td>
					<td>创建者</td>
					<td>创建时间</td>
					<td>修改者</td>
					<td>修改时间</td>
				</tr>
			</thead>
			<tbody id="myBody">
				<!-- <tr class="active">
					<td><input type="checkbox" /></td>
					<td>1</td>
					<td><a  href="detail.html">zhangsan</a></td>
					<td>张三</td>
					<td>市场部</td>
					<td>zhangsan@bjpowernode.com</td>
					<td>2017-02-14 10:10:10</td>
					<td>127.0.0.1,192.168.100.2</td>
					<td><a href="javascript:void(0);" onclick="window.confirm('您确定要锁定该用户吗？');" style="text-decoration: none;">启用</a></td>
					<td>admin</td>
					<td>2017-02-10 10:10:10</td>
					<td>admin</td>
					<td>2017-02-10 20:10:10</td>
				</tr>
				<tr>
					<td><input type="checkbox" /></td>
					<td>2</td>
					<td><a  href="detail.html">lisi</a></td>
					<td>李四</td>
					<td>市场部</td>
					<td>lisi@bjpowernode.com</td>
					<td>2017-02-14 10:10:10</td>
					<td>127.0.0.1,192.168.100.2</td>
					<td><a href="javascript:void(0);" onclick="window.confirm('您确定要启用该用户吗？');" style="text-decoration: none;">锁定</a></td>
					<td>admin</td>
					<td>2017-02-10 10:10:10</td>
					<td>admin</td>
					<td>2017-02-10 20:10:10</td>
				</tr> -->
			</tbody>
		</table>
	</div>
	
	<div style="height: 50px; position: relative;top: 30px; left: 30px;">
		
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