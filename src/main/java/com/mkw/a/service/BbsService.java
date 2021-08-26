package com.mkw.a.service;

import java.io.FileWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.mkw.a.domain.BbsParam;
import com.mkw.a.domain.BbsVo;

public interface BbsService {

	boolean uploadBbs(BbsVo bbs, MultipartFile fileload, HttpServletRequest req);

	List<BbsVo> getBbsListData(BbsParam param);

	BbsVo getDetailBbs(int seq);

	boolean deleteBbs(int seq);

	boolean updateBbs(BbsVo vo);

	int getBbsDataCount(BbsParam param);

}
