package com.mkw.a.service.impl;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mkw.a.domain.BbsParam;
import com.mkw.a.domain.BbsVo;
import com.mkw.a.mapper.BbsDao;
import com.mkw.a.service.BbsService;
import com.mkw.a.util.PdsUtil;

@Service
public class BbsServiceImpl implements BbsService {
	
	private static final Logger logger = LoggerFactory.getLogger(BbsServiceImpl.class);

	@Autowired
	BbsDao bbsdao;

	@Override
	public boolean uploadBbs(BbsVo bbs, MultipartFile fileload, HttpServletRequest req) {
		
		boolean result = false;
		
		try {
			
			String pattern = "yyyyMMdd";
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);

			String yymmdd = simpleDateFormat.format(new Date());
			logger.debug("폴더명 >>> " + yymmdd);
			
			String patter2 = "yyyy-MM-dd HH:mm:ssZ";
			simpleDateFormat = new SimpleDateFormat(patter2);
			String yymmddhhmmss = simpleDateFormat.format(new Date());
			logger.debug("현재시간 >>> " + yymmddhhmmss);
			
			String dirStr = "D:/Temp/"+yymmdd +"";
			
			//경로를 문자열로 받을 수도 있다
		    File newFile = new File(dirStr);
		   
		    if(newFile.mkdir()){   //만드려는 디렉토리가 하나일 경우
		    	logger.debug(" <<<< 디렉토리를 생성했습니다. >>>> ");
		    }else{
		    	logger.debug(" <<<< 디렉토리를 생성하지 못했습니다. >>>> ");
		    }
		    
		    File loggerfile = new File(dirStr+"/logger.txt");
		    logger.debug("경로 및 파일명 확인 >>> "+ dirStr+"/logger.txt");
		    
			FileWriter fw = new FileWriter(loggerfile, true);
			
			System.out.println("writeBbsAf :" +bbs.toString());
			fw.write("입력시간 >>> " + yymmddhhmmss + "\r\n");
			fw.write("writeBbsAf :" +bbs.toString() + "\r\n");
			
			//filename 취득 
			String filename = fileload.getOriginalFilename();
			bbs.setFilename(filename);	//원본 파일명을 설정
			fw.write("파일네임 >>> "+ filename + "\r\n");
			
			//upload 경로 설정 
			//server(tomcat) 
			String fupload = req.getServletContext().getRealPath("/upload");
			System.out.println("fuload :"+fupload);
			fw.write("파일경로 >>> "+ fupload+ "\r\n");
			
			String newfilename = PdsUtil.getNewFileName(bbs.getFilename());
			bbs.setNewfilename(newfilename);
			fw.write("뉴파일네임 >>> "+ newfilename+ "\r\n");
			
			File file = new File(fupload + "/" +newfilename);
			fw.write("파일 풀네임(경로포함/뉴파일네임) >>> "+ file+ "\r\n");
			System.out.println("파일 풀네임(경로포함/뉴파일네임) >>> "+ file+ "\r\n");
			
				
			FileUtils.writeByteArrayToFile(file, fileload.getBytes());
			
			result = bbsdao.uploadBbs(bbs);
			fw.write("글 업로드 성공여부 >>> "+ result+ "\r\n");
			fw.write("완료 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>\r\n");
			
			if(!result) {
				throw new SQLException();
			}
			
			fw.flush();
			fw.close();
		
		} catch (IOException e) {
			System.out.println("BbsServiceImpl >>> uploadBbs  IOException Fail");
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO: handle exception
			
		}catch (NullPointerException e) {
			// TODO Auto-generated catch block
			System.out.println(">>> BbsServiceImpl >>> uploadBbs >>> NPE Fail");
			e.printStackTrace();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(">>> BbsServiceImpl >>> uploadBbs >>> Exception Fail");
			e.printStackTrace();
		}
		
			
		return result;
	}
	

	@Override
	public List<BbsVo> getBbsListData(BbsParam param) {

		//페이지에 뿌려질 글수 
		int pagePost = 10;
		
		//paging 처리
		int nowPage = param.getPnum();
		int start = nowPage * pagePost + 1; 	//1  11
		int end = (nowPage + 1) * pagePost; 	//10 20

		System.out.println("nowPage ="+nowPage);
		System.out.println("start ="+start);
		System.out.println("end ="+end);
 
		param.setStart(start);
		param.setEnd(end);
		
		System.out.println("*********************param******************");
		System.out.println(param.toString());
		
		return bbsdao.getBbsListData(param);
	}

	@Override
	public BbsVo getDetailBbs(int seq) {
		return bbsdao.getDetailBbs(seq);
	}

	@Override
	public boolean deleteBbs(int seq) {
		return bbsdao.deleteBbs(seq);
	}

	@Override
	public boolean updateBbs(BbsVo vo) {
		return bbsdao.updateBbs(vo);
	}

	@Override
	public int getBbsDataCount(BbsParam param) {
		return bbsdao.getBbsDataCount(param);
	}


	@Override
	public ArrayList<HashMap<String, Object>> getAutocomIdTitle() {
		
		ArrayList<HashMap<String, Object>> resultMap = new ArrayList<HashMap<String, Object>>();
		
		resultMap = bbsdao.getAutocomIdTitle(); 
		
		System.out.println("결과 확인 : " + resultMap.toString());
		
		return resultMap;
	}


	@Override
	public HashMap<String, Object> commentRegi(HashMap<String, Object> param) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		System.out.println("**********commentRegi**********");
		System.out.println("파라미터 확인 >>>");
		System.out.println(param.toString());
		
		boolean b = bbsdao.commentRegi(param);
		
		if(b) {
			resultMap.put("result", "success!");
		}else {
			resultMap.put("result", "fail!");
		}
		
		return resultMap;
	}


	@Override
	public HashMap<String, Object> loadComment(HashMap<String, Object> param) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		System.out.println("**********loadComment**********");
		System.out.println("파라미터 확인 >>>");
		System.out.println(param.toString());
		
		ArrayList<HashMap<String, Object>> resultList= bbsdao.loadComment(param);
		
		return null;
	}

	
}
