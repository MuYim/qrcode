<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page language="java" pageEncoding="UTF-8"%>

<%@ page contentType="text/html;charset=UTF-8"%>
<title>左边导航</title>
<link rel="stylesheet" type="text/css" href="css/reset.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
<!--框架高度设置-->
<script type="text/javascript">
	$(function() {
		$('.sidenav li').click(function() {
			$(this).siblings('li').removeClass('now');
			$(this).addClass('now');
		});

		$('.erji li').click(function() {
			$(this).siblings('li').removeClass('now_li');
			$(this).addClass('now_li');
		});

		var main_h = $(window).height();
		$('.sidenav').css('height', main_h + 'px');
	})
</script>
<!--框架高度设置-->
</head>

<body>
	<div id="left_ctn">
		<ul class="sidenav">
			<li class="now">
				<div class="nav_m">
					<span><a>功能选择</a></span> <i>&nbsp;</i>
				</div>
				<ul class="erji">
					<li><span><a href="postcard.jsp" target="main">名片生成</a></span></li>
					<li><span><a href="text.html" target="main">文字转换</a></span></li>
					<li><span><a href="url.html" target="main">网页跳转</a></span></li>
				</ul>
			</li>
		</ul>
	</div>
</body>
</html>
