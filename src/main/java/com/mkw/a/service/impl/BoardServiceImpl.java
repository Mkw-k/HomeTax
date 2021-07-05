package com.mkw.a.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mkw.a.domain.BoardVo;
import com.mkw.a.mapper.BoardMapper;
import com.mkw.a.service.BoardService;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardMapper mapper;
	
	@Override
	public List<BoardVo> viewAll() {
		return mapper.viewAll();
	}

}
