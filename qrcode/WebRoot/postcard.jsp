<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html style="height:100%;wigth:100%">
<head>
<title>个人名片</title>

<meta name="keywords" content="keyword1,keyword2,keyword3">
<meta name="description" content="this is my page">
<meta name="content-type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="style/index.css">
<link rel="stylesheet" href="style/bootstrap-theme.min.css">

</head>
<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="js/jquery.form.js"></script>
<script type="text/javascript" src="js/html2canvas.js"></script>

<link rel="stylesheet" type="text/css"
	href="js/Huploadify/Huploadify.css" />
<script type="text/javascript" src="js/Huploadify/jquery.Huploadify.js"></script>

<script type="text/javascript">
	var filename = "";
	function MM_preloadImages() { //v3.0
		var d = document;
		if (d.images) {
			if (!d.MM_p)
				d.MM_p = new Array();
			var i, j = d.MM_p.length, a = MM_preloadImages.arguments;
			for (i = 0; i < a.length; i++)
				if (a[i].indexOf("#") != 0) {
					d.MM_p[j] = new Image;
					d.MM_p[j++].src = a[i];
				}
		}
	}

	function MM_swapImgRestore() { //v3.0
		var i, x, a = document.MM_sr;
		for (i = 0; a && i < a.length && (x = a[i]) && x.oSrc; i++)
			x.src = x.oSrc;
	}

	function MM_findObj(n, d) { //v4.01
		var p, i, x;
		if (!d)
			d = document;
		if ((p = n.indexOf("?")) > 0 && parent.frames.length) {
			d = parent.frames[n.substring(p + 1)].document;
			n = n.substring(0, p);
		}
		if (!(x = d[n]) && d.all)
			x = d.all[n];
		for (i = 0; !x && i < d.forms.length; i++)
			x = d.forms[i][n];
		for (i = 0; !x && d.layers && i < d.layers.length; i++)
			x = MM_findObj(n, d.layers[i].document);
		if (!x && d.getElementById)
			x = d.getElementById(n);
		return x;
	}

	function MM_swapImage() { //v3.0
		var i, j = 0, x, a = MM_swapImage.arguments;
		document.MM_sr = new Array;
		for (i = 0; i < (a.length - 2); i += 3)
			if ((x = MM_findObj(a[i])) != null) {
				document.MM_sr[j++] = x;
				if (!x.oSrc)
					x.oSrc = x.src;
				x.src = a[i + 2];
			}
	}
	function fileupload() {
		$("#fileform").ajaxSubmit(
				function(data) {
					if (data != "") {
						filename = data;
						$("#upload-img").attr(
								"src",
								"http://127.0.0.1:8080/qrcode/upload/"
										+ filename);
					}

				});
	}

	$(function() {
		$("#begin").click(function() {
			createCode();
			logo();

		});

	});
	function logo() {
		if(filename!=""){
			$("#logo_img").attr("src",
					"http://127.0.0.1:8080/qrcode/upload/" + filename);
		}
		else{
			$("#logo_img").attr("src",
					"images/default_head_image.png");
		}
		$("#logo_img").attr("height", "60px");
		$("#logo_img").attr("width", "60px");
	}
	function createCode() {
		var name = "", company = "", title = "", tel = "", address = "", email = "";
		name = $("#name").val();
		company = $("#company").val();
		title = $("#position").val();
		tel = $("#phone").val();
		address = $("#address").val();
		email = $("#email").val();

		var str = "BEGIN:VCARD\nFN:" + name + "\nORG:" + company + "\nTITLE:"
				+ title + "\nTEL:" + tel + "\nADR:" + address + "\nEMAIL:"
				+ email + "\nEND:VCARD";
		$.ajax({
			type : "post",
			url : "qrcode",
			data : {
				content : str
			},
			success : function(data) {
				$("#qr_img").fadeIn("slow");
				$("#qr_img").attr("src", "qrcode/" + data);
			}
		});

	}

	function print() {
		html2canvas($("#er"), {
			onrendered : function(canvas) {
				$("#print").attr('href', canvas.toDataURL());
				$("#print").attr('download', 'myjobdeer.png');
				//$('#print').css('display','inline-block');
			}
		});
	}

	function clean() {
		$("form").find(':input').not(':button,:submit,:reset').val('')
				.removeAttr('checked').removeAttr('selected');
		$("#qr_img").attr("src", "");
		$("#upload-img").attr("src", "images/default_head_image.png");
	}
</script>
<body
	style="background:url(images/bg.jpg);background-size:contain;background-repeat:no-repeat;">
	<div id="content">
		<div id="form_in">
			<div id="form">
				<div id="text">
					<form action="#" method="post" id="postcardform">
						<p>
							<label>姓名：</label><input type="text" name="name" id="name"
								value="" />
						</p>
						<p>
							<label>公司：</label><input type="text" name="company" id="company"
								value="" />
						</p>
						<p>
							<label>职位：</label><input type="text" name="position"
								id="position" value="" />
						</p>
						<p>
							<label>电话：</label><input type="text" name="phone" id="phone"
								value="" />
						</p>
						<p>
							<label>E-mail：</label><input type="text" name="email" id="email"
								value="" />
						</p>
						<p>
							<label>地址：</label><input type="text" name="address" id="address"
								value="" />
						</p>


					</form>
				</div>
				<div id="er">
					<img src="" id="qr_img" /> 
					<img src="" id="logo_img" class="zj" />
				</div>
			</div>
		</div>
		<div class="avator" id="avator">
			<img border="0" id="upload-img" src="images/default_head_image.png"
				alt="" width="90" height="90"></img>

			<form action="ImgUpload" method="post" enctype="multipart/form-data"
				id="fileform">
				<div class="upload pointer" id="upload-btn">
					<div class="uploadClick">上传</div>
					<input type="file" id="file" class="uploadfile" name="fileName"
						onchange="fileupload()" style="margin-left: -39.5px;" />
				</div>
			</form>
		</div>
		<div id="button">
			<a id="print" class="btn btn-success" onclick="print()">打印</a> 
			<a class="btn btn-success" onclick="clean()">清空</a> 
			<input type="button" id="begin" class="btn btn-success" value="生成"/>
		</div>
	</div>
</body>
</html>
