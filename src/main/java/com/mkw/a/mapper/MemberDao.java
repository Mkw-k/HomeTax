package com.mkw.a.mapper;

import java.util.List;

import com.mkw.a.domain.MemberVo;

public interface MemberDao {
	//회원가입
	boolean regiAf (MemberVo mem);
	//아이디중복확인
	int getId(MemberVo mem);
	//로그인
	MemberVo login(MemberVo mem);
	//회원탈퇴
	boolean memberDelete(MemberVo mem);
	//회원정보수정
	boolean updateMember(MemberVo mem);
	//일반회원의 수 가져오기 
	int getnomalLen();
	//할인회원의 수 가져오기 
	int getdiscountLen();
	//모든 회원정보를 리스트로 가져오기
	List<MemberVo> getMemberList();
}
