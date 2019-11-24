package com.ykx.qr;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.swetake.util.Qrcode;



public class QrcodeController extends HttpServlet{
	public void service(HttpServletRequest request,HttpServletResponse response) throws IOException{

		//1.设置编码
		request.setCharacterEncoding("utf-8");
		
		//2.引入com.swetake.util.Qrcode;
		//创建qrcode句柄
		Qrcode qrhand=new Qrcode();
		
		//3.设置纠错级别
		qrhand.setQrcodeErrorCorrect('M');//qrcode官网查询
		
		//4.设置编码模式：二进制
		qrhand.setQrcodeEncodeMode('B');//qrcode官网查询
		
		//5.设置版本1-40
		qrhand.setQrcodeVersion(15);//qrcode官网查询
		
		//6.获取图片缓冲对象
		//定义图片的大小
		int width=235,height=235;//15版本生成的大小
		//创建图片对象
		BufferedImage image=new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		
		//7.获取制图工具
		Graphics2D grap=image.createGraphics();
		//设置二维码的背景颜色：白色
		grap.setBackground(Color.white);
		grap.clearRect(0, 0, width, height);//选择背景颜色的区域
		//设置画笔颜色，即二维码的颜色:黑色
		grap.setColor(Color.black);
		
		//8.从前端获取要生成的二维码的内容,并生成二维码
		String content=request.getParameter("content");
		//将二维码的内容以gbk的方式转换为字节数组
		byte[] contentBytes=content.getBytes("gbk");		
		//通过Qrcode获取二维数组 0 1
		boolean[][] codeout=qrhand.calQrcode(contentBytes);
		//便利二维数组，生成二维码
		for(int i=0;i<codeout.length;i++){
			for(int j=0;j<codeout.length;j++)
				if(codeout[i][j]){//1画，0不画
					grap.fillRect(j*3+2,i*3+2,3,3);
				}
		}
		//8.释放资源
		grap.dispose();
		image.flush();
		
		//9.二维码保存
		//设置图片名称
		String fileName=UUID.randomUUID()+".png";
		//图片存储路径
		File file=new File(this.getServletContext().getRealPath("/qrcode")+"/"+fileName);
		//将缓存中的图片保存到硬盘
		ImageIO.write(image, "png", file);
		
		//在控制台打印二维码内容，和图片名称
		System.out.println(content);
		response.getWriter().print(fileName);
		
		
	}
}
