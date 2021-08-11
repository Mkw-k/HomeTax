package com.mkw.a.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.mkw.a.domain.BoardVo;

public interface BoardService {
	public List<BoardVo> viewAll();

	public ArrayList<String> skTest(ArrayList<HashMap<String, Object>> param);

	public String skTestReturn(ArrayList<HashMap<String, Object>> param);
}
