package com.mkw.a.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import com.mkw.a.service.BbsService;

public class DownloadView extends AbstractView{
	
	@Autowired
	BbsService service;

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		System.out.println("downloadView renderMergedOutputModel");
		
		File file = (File)model.get("downloadFile");
		String originalFile = (String)model.get("originalFile");
		
		System.out.println("originalFile:" + originalFile);
		
		response.setContentType(this.getContentType());
		response.setContentLength((int)file.length());
		
		String userAgent = request.getHeader("user-Agent");
		boolean ie = userAgent.indexOf("MSIE") > -1; // true경우 IE, false일 경우 chrome
		
		String filename = null;
		
		if(ie) {
			filename = URLEncoder.encode(file.getName(), "utf-8");
		}else {
			filename = new String(file.getName().getBytes("utf-8"), "iso-8859-1");
		}
		
		// 이 설정을 안해주면 한글명은 정상으로 나오지 않는다
		originalFile = URLEncoder.encode(originalFile, "utf-8");
		
		response.setHeader("Content-Disposition", "attachment; filename=\"" + originalFile + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Content-Length", "" + file.length());
		response.setHeader("Pragma", "no-cache;"); 
		response.setHeader("Expires", "-1;");
		
		OutputStream out = response.getOutputStream();
		FileInputStream fi = new FileInputStream(file);
		
		FileCopyUtils.copy(fi, out);
		
		/*
		 * int seq = (int) model.get("seq"); service.downcountBbs(seq);
		 */
		
		if(fi != null) {
			fi.close();
		}
		
		
		
		
	}
	
	

}
