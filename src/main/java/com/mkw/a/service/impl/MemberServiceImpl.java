package com.mkw.a.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mkw.a.domain.MemberVo;
import com.mkw.a.mapper.MemberDao;
import com.mkw.a.service.MemberService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService{
	
	private final MemberDao memberdao;

	@Override
	public boolean regiAf(MemberVo mem) {
		return memberdao.regiAf(mem);
	}

	@Override
	public int getId(MemberVo mem) {
		return memberdao.getId(mem);
	}

	@Override
	public MemberVo login(MemberVo mem) {
		return memberdao.login(mem);
	}

	@Override
	public boolean memberDelete(MemberVo mem) {
		return memberdao.memberDelete(mem);
	}

	@Override
	public boolean updateMember(MemberVo mem) {
		return memberdao.updateMember(mem);
	}

	@Override
	public int getnomalLen() {
		return memberdao.getnomalLen();
	}

	@Override
	public int getdiscountLen() {
		return memberdao.getdiscountLen();
	}

	@Override
	public List<MemberVo> getMemberList() {
		return memberdao.getMemberList();
	}



}
