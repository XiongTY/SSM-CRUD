<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="images/bitbug_favicon.ico"
	type="image/x-icon" />
<meta charset="UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script type="text/javascript"
	src="${APP_PATH}/static/js/jquery-3.4.1.js"></script>
<!-- Bootstrap -->
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>


	<!-- 员工修改的模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">员工修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update-static">
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_update_input" placeholder="email@guigu.com">
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender_update_input" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender_update_input" value="F"> 女
								</label>
							</div>
						</div>

						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_update_select">

								</select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">关闭</button>
							<button type="button" class="btn btn-primary" id="emp_update_btn">修改保存</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>










	<!-- 员工添加的模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control"
									id="empName_add_input" placeholder="empName">
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_add_input" placeholder="email@guigu.com">
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender_add_input" value="M" checked="checked">
									男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender_add_input" value="F"> 女
								</label>
							</div>
						</div>

						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_add_select">

								</select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">关闭</button>
							<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
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
				<button class="btn btn-primary" id="emp_add_modal-btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>

		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_tables">
					<thead>
						<tr>
							<th><input type="checkbox" id="check_all" /></th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>

			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row"></div>
		<!-- 分页文字信息 -->
		<div class="col-md-6" id="page_info_area"></div>
		<!-- 分页条信息 -->
		<div class="col-md-6" id="page_nav_area"></div>
	</div>
	<script type="text/javascript">
		
			var totalRecord,currentPage;
			//1.页面加载完后,直接发送一个ajax请求,要到分页数据
			$(function() {
				to_page(1);
			});

			function to_page(pn) {
				$.ajax({
					url : "${APP_PATH}/emps",
					data : "pn=" + pn,
					type : "GET",
					success : function(result) {
						//console.log(result)
						//1.解析并显示员工数据
						build_emps_table(result);
						//2.解析并显示分页信息
						build_page_info(result);
						//解析显示分页条
						build_page_nav(result);

					}
				});
			}

			function build_emps_table(result) {
				//清空table表格
				$("#emps_tables tbody").empty();
				var emps = result.extend.PageInfo.list;
				$
						.each(
								emps,
								function(index, item) {
									var checkBoxTd=$("<td><input type ='checkbox' class='check_item'/></td>")
									var empIdTd = $("<td></td>").append(
											item.empId);
									var empNameTd = $("<td></td>").append(
											item.empName);
									var genderTd = $("<td></td>").append(
											item.gender == 'M' ? "男" : "女");
									var emailTd = $("<td></td>").append(
											item.email);
									var deptNameTd = $("<td></td>").append(
											item.department.deptName);
									
									var editBtn = $("<button></button>")
											.addClass("btn btn-primary btn-sm edit_btn")
											.append(
													$("<span></span>")
															.addClass(
																	"glyphicon glyphicon-pencil"))
											.append("编辑");
									//
									editBtn.attr("edit-id",item.empId);
									var delBtn = $("<button></button>")
											.addClass("btn btn-danger btn-sm delete_btn")
											.append(
													$("<span></span>")
															.addClass(
																	"glyphicon glyphicon-trash"))
											.append("删除");
									delBtn.attr("del-id",item.empId);
									
									var btnTd = $("<td></td>").append(editBtn)
											.append(" ").append(delBtn);

									//append执行玩之后会返回原来的内容
									$("<tr></tr>").append(checkBoxTd).append(empIdTd).append(
											empNameTd).append(genderTd).append(
											emailTd).append(deptNameTd).append(
											btnTd).appendTo(
											"#emps_tables tbody");
								});
			}

			//解析显示分页信息
			function build_page_info(result) {
				$("#page_info_area").empty();
				$("#page_info_area").append(
						"当前" + result.extend.PageInfo.pageNum + "页,总"
								+ result.extend.PageInfo.pages + "页,总"
								+ result.extend.PageInfo.total + "记录");
				totalRecord=result.extend.PageInfo.total;
				currentPage=result.extend.PageInfo.pageNum;
			}

			//解析显示分页条
			function build_page_nav(result) {
				$("#page_nav_area").empty();
				//page_nav_area
				var ul = $("<ul></ul>").addClass("pagination");
				//构建元素		
				var firstPageLi = $("<li></li>").append(
						$("<a></a>").append("首页").attr("href", "#"));
				var prePageLi = $("<li></li>").append(
						$("<a></a>").append("&laquo;"));
				if (result.extend.PageInfo.hasPreviousPage == false) {
					firstPageLi.addClass("disabled");
					prePageLi.addClass("disabled");
				} else {

					//为元素添加翻页
					firstPageLi.click(function() {
						to_page(1);
					});

					prePageLi.click(function() {
						to_page(result.extend.PageInfo.pageNum - 1);
					});
				}

				var nextPageLi = $("<li></li>").append(
						$("<a></a>").append("&raquo;"));
				var lastPageLi = $("<li></li>").append(
						$("<a></a>").append("末页").attr("href", "#"));
				if (result.extend.PageInfo.hasNextPage == false) {
					nextPageLi.addClass("disabled");
					lastPageLi.addClass("disabled");
				} else {

					//为元素添加翻页
					nextPageLi.click(function() {
						to_page(result.extend.PageInfo.pageNum + 1);
					});

					lastPageLi.click(function() {
						to_page(result.extend.PageInfo.pages);
					});
				}

				//添加首页和前一页
				ul.append(firstPageLi).append(prePageLi);
				//添加页码
				$.each(result.extend.PageInfo.navigatepageNums, function(index,
						item) {
					var numLi = $("<li></li>")
							.append($("<a></a>").append(item));
					if (result.extend.PageInfo.pageNum == item) {
						numLi.addClass("active");
					}
					numLi.click(function() {
						to_page(item);
					});
					ul.append(numLi);
				});
				//添加后一页和末页
				ul.append(nextPageLi).append(lastPageLi);

				var navEle = $("<nav></nav>").append(ul);
				navEle.appendTo("#page_nav_area")
			}

			//点击新增淡出模态框
			$("#emp_add_modal-btn").click(function() {
				//发送请求,查部门信息,显示在下拉列表
				getDepts("#dept_add_select");
			
				//弹出
				$("#empAddModal").modal({
					backdrop : "static"
				});
			});
			
			//查出所有部门信息并显示在下拉列表中
			function getDepts(ele){
				//清空之前下拉列表的值
				$(ele).empty();
				$.ajax({
					url:"${APP_PATH}/depts",
					type:"GET",
					success:function(result){
						//console.log(result);
						//显示部门信息在下拉列表中
						//$("#dept_add_select")
						$.each(result.extend.depts,function(){
							var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
							optionEle.appendTo(ele);
						});
					}
				});
			}
			
			function validate_aa_form(){
				//1.拿到要校验的数据
				var empName=$("#empName_add_input").val();
				var regName = /^([a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
				if(!regName.test(empName)){
					alert("用户名格式错误,应该是2-5位中文,6-16英文或数字组合");
					return false;
				}
				
				var email=$("#email_add_input").val();
				var regEmali = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
				if(!regEmali.test(email)){
					alert("邮箱格式不正确");
					return false;
				}
				
				return true;
				
				
			}
			
			
			
			//点击保存,保存员工
			$("#emp_save_btn").click(function(){
				//对数据进行校验
				if(!validate_aa_form()){
					return false;
				}
				
				
				$.ajax({
					url:"${APP_PATH}/emp",
					type:"POST",
					data:$("#empAddModal form").serialize(),
					success:function(result){
						//alert(result.msg);
						//员工保存成功
						//关闭模态框
						$("#empAddModal").modal('hide');
						//来到最后一页显示工程保存的数据
						//发送ajax显示最后一页数据
						to_page(totalRecord);
					}
				})
			});
			
			

			$(document).on("click",".edit_btn",function(){
				//1.查出部门信息,并显示部门列表
				getDepts("#dept_update_select");
				//2.查出员工信息
				getEmp($(this).attr("edit-id"));
				//传递员工id给更新按钮
				$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
				//3.弹出模态框
				$("#empUpdateModal").modal({
					backdrop : "static"
				});
			});
			
			function getEmp(id){
				$.ajax({
					url:"${APP_PATH}/emp/"+id,
					type:"GET",
					success:function(result){
					var empData = result.extend.emp;
					$("#empName_update-static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
					}
				});
			}
			
			
			//点击更新，更新员工信息
			$("#emp_update_btn").click(function(){
				//验证邮箱是否合法
				var email=$("#email_update_input").val();
				var regEmali = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
				if(!regEmali.test(email)){
					alert("邮箱格式不正确");
					return false;
				}
				
				//发送ajax请求保存更新
				$.ajax({
					url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
					type:"POST",
					data:$("#empUpdateModal form").serialize()+"&_method=PUT",
					success:function(result){
						$("#empUpdateModal").modal("hide");
						to_page(currentPage);
					}
				});
				
			});
			
			
			//单个删除
			$(document).on("click",".delete_btn",function(){
				//弹出删除对话框
				//alert($(this).parents("tr").find("td:eq(1)").text());
				var empName = $(this).parents("tr").find("td:eq(2)").text();
				var empId = $(this).attr("del-id");
				if(confirm("确认删除["+empName+"]吗?")){
					$.ajax({
						url:"${APP_PATH}/emp/"+empId,
						type:"DELETE",
						success:function(result){
							alert(result.msg);
							to_page(currentPage);
						}
					});
				}	
			});
			
			//全选/全不选
			$("#check_all").click(function(){
				//attr获取checked是undefined
				//原生的属性用prop获取值,attr获取自定义属性的值
				$(this).prop("checked");
				$(".check_item").prop("checked",$(this).prop("checked"));
				
			});
			
			$(document).on("click",".check_item",function(){
				var flag = $(".check_item:checked").length==$(".check_item").length;
				$("#check_all").prop("checked",flag);
			});
			
			//点击全部删除就批量删除
			$("#emp_delete_all_btn").click(function(){
				//$(".check_item:checked")
				var empNames="";
				var del_idstr="";
				$.each($(".check_item:checked"),function(){
				empNames +=	$(this).parents("tr").find("td:eq(2)").text()+",";
				//组装员工id字符串
				del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
				});
				empNames = empNames.substring(0,empNames.length-1);
				del_idstr=del_idstr.substring(0,del_idstr.length-1);
				if(confirm("确认删除["+empNames+"]吗?")){
					$.ajax({
						url:"${APP_PATH}/emp/"+del_idstr,
						type:"DELETE",
						success:function(result){
							alert(result.msg);
							to_page(currentPage);
						}
					});
				}
			});
			
			
		</script>
</body>
</html>