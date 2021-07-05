package com.mkw.a.controller;


import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mkw.a.domain.BbsParam;
import com.mkw.a.domain.BbsVo;
import com.mkw.a.service.BbsService;
import com.mkw.a.util.PdsUtil;



@Controller
public class BbsController {
	
	@Autowired
	BbsService bbsservice;
	
	@RequestMapping(value = "bbs", method = RequestMethod.GET)
	public String bbs() {
		
		return "board/bbs";
	}
	
	@RequestMapping(value = "writeBbs", method = RequestMethod.GET)
	public String writeBbs(String myid, Model model) {
		
		model.addAttribute("myid", myid);
		
		return "board/writeBbs";
	}
	
	@RequestMapping(value = "writeBbsAf", method = RequestMethod.POST)
	public String writeBbsAf(BbsVo bbs, @RequestParam(value = "fileload", required = false)MultipartFile fileload
								, HttpServletRequest req) {
		
		String filename = fileload.getOriginalFilename();
		bbs.setFilename(filename);
		
		String fupload = req.getServletContext().getRealPath("/upload");
		
		System.out.println("fuload :"+fupload);
		
		String newfilename = PdsUtil.getNewFileName(bbs.getFilename());
		
		bbs.setNewfilename(newfilename);
		
		File file = new File(fupload + "/" +newfilename);
		
		try {
			FileUtils.writeByteArrayToFile(file, fileload.getBytes());
			
			boolean b = bbsservice.uploadBbs(bbs);
			
			if(b) {
				System.out.println("글 업로드 성공");
			}else {
				System.out.println("글 업로드 실패");
			}
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:/bbs";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "getBbsListData", method = RequestMethod.GET)
	public List<BbsVo> getBbsListData(BbsParam param, Model model) {
		
		List<BbsVo> list = bbsservice.getBbsListData(param);
		
		return list;
	}
	
	@RequestMapping(value = "fileDownload", method = RequestMethod.POST)
	public String fileDownload(String newfilename, String filename, int seq, Model model, HttpServletRequest req) {
		
		// 경로
	      // server 경로일 경우
	      String fupload = req.getServletContext().getRealPath("/upload");
	      
	      // 폴더 경로일 경우
	      // String fupload = "d:\\tmp";
	      
	      File downloadFile = new File(fupload + "/" + newfilename);
	      
	      model.addAttribute("downloadFile", downloadFile);
	      model.addAttribute("originalFile", filename);
	      model.addAttribute("seq", seq);
	      
	      return "DownloadView";
	}
	
	
	@RequestMapping(value = "detailBbs", method = RequestMethod.GET)
	public String detailBbs(int seq, Model model) {
		BbsVo vo = bbsservice.getDetailBbs(seq);
		
		model.addAttribute("vo", vo);
		
		return "board/detailBbs";
	}
	
	
	
	@RequestMapping(value = "deleteBbs", method = RequestMethod.GET)
	public String deleteBbs(int seq) {
		boolean b = bbsservice.deleteBbs(seq);
		
		if(b) {
			System.out.println("삭제성공");
		}else {
			System.out.println("삭제실패");
		}
		
		return "redirect:/bbs";
	}
	
	
	@RequestMapping(value = "toUpdateBbs", method = RequestMethod.GET)
	public String toUpdateBbs(int seq, Model model) {
		
		BbsVo vo = bbsservice.getDetailBbs(seq);
		
		model.addAttribute("vo", vo);
		model.addAttribute("isUpdate", "YES");
		
		return "board/writeBbs";
	}
	
	
	@RequestMapping(value = "updateBbs", method = RequestMethod.POST)
	public String updateBbs(BbsVo bbs, @RequestParam(value = "fileload", required = false)MultipartFile fileload
			, HttpServletRequest req) {
		
		String filename = fileload.getOriginalFilename();
		bbs.setFilename(filename);
		
		String fupload = req.getServletContext().getRealPath("/upload");
		
		System.out.println("fuload :"+fupload);
		
		String newfilename = PdsUtil.getNewFileName(bbs.getFilename());
		
		bbs.setNewfilename(newfilename);
		
		File file = new File(fupload + "/" +newfilename);
		
		try {
			FileUtils.writeByteArrayToFile(file, fileload.getBytes());
			boolean b = bbsservice.updateBbs(bbs);
			
			if(b) {
				System.out.println("수정성공");
			}else {
				System.out.println("수정실패");
			}
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/bbs";
	}
	
	
}
