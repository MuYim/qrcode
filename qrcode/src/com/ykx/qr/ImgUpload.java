package com.ykx.qr;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URLDecoder;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.swetake.util.Qrcode;


public class ImgUpload extends HttpServlet {
	protected void service(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");
		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload sfu = new ServletFileUpload(factory);
		sfu.setFileSizeMax(1024 * 1080);
		
		
		String fileName = "";
		String path = "";
		try {
			List<FileItem> items = sfu.parseRequest(req);
			System.out.println(items.size());

			for (int i = 0; i < items.size(); i++) {
				FileItem item = items.get(i);
				if (!item.isFormField()) {
					ServletContext sctx = getServletContext();
					path = sctx.getRealPath("/upload");
					System.out.println(path);
					fileName = UUID.randomUUID() + ".png";
					;
					System.out.println(fileName);
					fileName = fileName
							.substring(fileName.lastIndexOf("/") + 1);
					File file = new File(path + "\\" + fileName);
					if (!file.exists()) {
						item.write(file);

					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.getWriter().print(fileName);
	}

	
	
}
