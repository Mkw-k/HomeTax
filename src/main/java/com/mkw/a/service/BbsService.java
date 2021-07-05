package com.mkw.a.service;

import java.util.List;

import com.mkw.a.domain.BbsParam;
import com.mkw.a.domain.BbsVo;

public interface BbsService {

	boolean uploadBbs(BbsVo bbs);

	List<BbsVo> getBbsListData(BbsParam param);

	BbsVo getDetailBbs(int seq);

	boolean deleteBbs(int seq);

	boolean updateBbs(BbsVo vo);

}
