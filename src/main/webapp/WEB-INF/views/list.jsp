<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script type="text/javascript"
	src="${APP_PATH}/static/js/jquery-1.12.4.js"></script>
<!-- Bootstrap -->
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>员工信息管理系统(SSM-CRUD)</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>

		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${PageInfo.list}" var="emp">
						<tr>
							<th>${emp.empId }</th>
							<th>${emp.empName }</th>
							<th>${emp.gender=="m"?"男":"女" }</th>
							<th>${emp.email }</th>
							<th>${emp.department.deptName }</th>
							<th>
								<button class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编辑

								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
							</th>
						</tr>
					</c:forEach>

				</table>

			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row"></div>
		<!-- 分页文字信息 -->
		<div class="col-md-6">
			当前${PageInfo.pageNum}页,总${PageInfo.pages},总${PageInfo.total}记录</div>
		<!-- 分页条信息 -->
		<div class="col-md-6">
			<nav aria-label="Page navigation">
				<ul class="pagination">
					<li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
					<c:if test="${PageInfo.hasPreviousPage }">
						<li><a href="${APP_PATH}/emps?pn=${PageInfo.pageNum-1}"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>


					<c:forEach items="${PageInfo.navigatepageNums }" var="pageNum">
						<c:if test="${pageNum == PageInfo.pageNum }">
							<li class="active"><a href="#">${pageNum }</a></li>
						</c:if>
						<c:if test="${pageNum != PageInfo.pageNum }">
							<li><a href="${APP_PATH}/emps?pn=${pageNum }">${pageNum }</a></li>
						</c:if>

					</c:forEach>
					<c:if test="${PageInfo.hasNextPage }">
						<li><a href="${APP_PATH}/emps?pn=${PageInfo.pageNum+1}"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</c:if>

					<li><a href="${APP_PATH}/emps?pn=${PageInfo.pages}">末页</a></li>
				</ul>
			</nav>
		</div>
	</div>
</body>
</html>