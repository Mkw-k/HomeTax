package com.mkw.a.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mkw.a.domain.MemberVo;
import com.mkw.a.mapper.MemberMapper;
import com.mkw.a.service.MemberService;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberMapper mapper;

	@Override
	public boolean regiAf(MemberVo mem) {
		return mapper.regiAf(mem);
	}

	@Override
	public int getId(MemberVo mem) {
		return mapper.getId(mem);
	}

	@Override
	public MemberVo login(MemberVo mem) {
		return mapper.login(mem);
	}

	@Override
	public boolean memberDelete(MemberVo mem) {
		return mapper.memberDelete(mem);
	}

	@Override
	public boolean updateMember(MemberVo mem) {
		return mapper.updateMember(mem);
	}

	@Override
	public int getnomalLen() {
		return mapper.getnomalLen();
	}

	@Override
	public int getdiscountLen() {
		return mapper.getdiscountLen();
	}

	@Override
	public List<MemberVo> getMemberList() {
		return mapper.getMemberList();
	}

}
