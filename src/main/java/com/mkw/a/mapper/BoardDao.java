package com.mkw.a.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.mkw.a.domain.BoardVo;

public interface BoardDao {

	public List<BoardVo> viewAll();

	public ArrayList<String> skTest(ArrayList<HashMap<String, Object>> param);

	public String skTestReturn(HashMap<String, Object> hashMap);
}
