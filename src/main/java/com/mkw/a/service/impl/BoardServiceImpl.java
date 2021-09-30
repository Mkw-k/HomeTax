package com.mkw.a.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mkw.a.domain.BoardVo;
import com.mkw.a.mapper.BoardDao;
import com.mkw.a.service.BoardService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService{

	private final BoardDao dao;
	
	@Override
	public List<BoardVo> viewAll() {
		return dao.viewAll();
	}

	@Override
	public ArrayList<String> skTest(ArrayList<HashMap<String, Object>> param) {
		
		System.out.println("데이터확인 : " + param.toString());
		
		return dao.skTest(param);
	}

	@Override
	public String skTestReturn(ArrayList<HashMap<String, Object>> param) {
		
		String result = "";
		
		for (int i = 0; i < param.size(); i++) {
			result = dao.skTestReturn(param.get(i));
		}
		return result;
	}

}
