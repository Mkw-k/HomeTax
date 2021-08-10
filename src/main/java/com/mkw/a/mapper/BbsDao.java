package com.mkw.a.mapper;

import java.util.List;

import com.mkw.a.domain.BbsParam;
import com.mkw.a.domain.BbsVo;


public interface BbsDao {

	 boolean uploadBbs(BbsVo bbs);

	List<BbsVo> getBbsListData(BbsParam param);

	BbsVo getDetailBbs(int seq);

	boolean deleteBbs(int seq);

	boolean updateBbs(BbsVo vo);

	int getBbsDataCount(BbsParam param);


}
