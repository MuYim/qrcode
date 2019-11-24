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

		//1.���ñ���
		request.setCharacterEncoding("utf-8");
		
		//2.����com.swetake.util.Qrcode;
		//����qrcode���
		Qrcode qrhand=new Qrcode();
		
		//3.���þ�����
		qrhand.setQrcodeErrorCorrect('M');//qrcode������ѯ
		
		//4.���ñ���ģʽ��������
		qrhand.setQrcodeEncodeMode('B');//qrcode������ѯ
		
		//5.���ð汾1-40
		qrhand.setQrcodeVersion(15);//qrcode������ѯ
		
		//6.��ȡͼƬ�������
		//����ͼƬ�Ĵ�С
		int width=235,height=235;//15�汾���ɵĴ�С
		//����ͼƬ����
		BufferedImage image=new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		
		//7.��ȡ��ͼ����
		Graphics2D grap=image.createGraphics();
		//���ö�ά��ı�����ɫ����ɫ
		grap.setBackground(Color.white);
		grap.clearRect(0, 0, width, height);//ѡ�񱳾���ɫ������
		//���û�����ɫ������ά�����ɫ:��ɫ
		grap.setColor(Color.black);
		
		//8.��ǰ�˻�ȡҪ���ɵĶ�ά�������,�����ɶ�ά��
		String content=request.getParameter("content");
		//����ά���������gbk�ķ�ʽת��Ϊ�ֽ�����
		byte[] contentBytes=content.getBytes("gbk");		
		//ͨ��Qrcode��ȡ��ά���� 0 1
		boolean[][] codeout=qrhand.calQrcode(contentBytes);
		//������ά���飬���ɶ�ά��
		for(int i=0;i<codeout.length;i++){
			for(int j=0;j<codeout.length;j++)
				if(codeout[i][j]){//1����0����
					grap.fillRect(j*3+2,i*3+2,3,3);
				}
		}
		//8.�ͷ���Դ
		grap.dispose();
		image.flush();
		
		//9.��ά�뱣��
		//����ͼƬ����
		String fileName=UUID.randomUUID()+".png";
		//ͼƬ�洢·��
		File file=new File(this.getServletContext().getRealPath("/qrcode")+"/"+fileName);
		//�������е�ͼƬ���浽Ӳ��
		ImageIO.write(image, "png", file);
		
		//�ڿ���̨��ӡ��ά�����ݣ���ͼƬ����
		System.out.println(content);
		response.getWriter().print(fileName);
		
		
	}
}
