package com.mkw.a.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mkw.a.domain.BbsParam;
import com.mkw.a.domain.BbsVo;
import com.mkw.a.mapper.BbsMapper;
import com.mkw.a.service.BbsService;

@Service
public class BbsServiceImpl implements BbsService {

	@Autowired
	BbsMapper bbsmapper;

	@Override
	public boolean uploadBbs(BbsVo bbs) {
		return bbsmapper.uploadBbs(bbs);
	}

	@Override
	public List<BbsVo> getBbsListData(BbsParam param) {
		return bbsmapper.getBbsListData(param);
	}

	@Override
	public BbsVo getDetailBbs(int seq) {
		return bbsmapper.getDetailBbs(seq);
	}

	@Override
	public boolean deleteBbs(int seq) {
		return bbsmapper.deleteBbs(seq);
	}

	@Override
	public boolean updateBbs(BbsVo vo) {
		return bbsmapper.updateBbs(vo);
	}

	@Override
	public int getBbsDataCount(BbsParam param) {
		return bbsmapper.getBbsDataCount(param);
	}
}
