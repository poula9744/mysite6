package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.GuestbookVo;

@Repository
public class GuestbookDao {

	@Autowired
	private SqlSession sqlSession;

	// List
	public List<GuestbookVo> guestList() {

		List<GuestbookVo> guestbookList = sqlSession.selectList("guestbook.select");
		return guestbookList;
	}

	// 등록
	public int guestbookInsert(GuestbookVo guestbookVo) {
		System.out.println("GusetbookDao.guestbookInsert()");

		int count = sqlSession.insert("guestbook.insert", guestbookVo);

		return count;
	}

	// 삭제
	public int guestbookDelete(GuestbookVo guestbookVo) {
		System.out.println("GuestbookDao.guestbookDelete()");
		System.out.println(guestbookVo);
		int count = sqlSession.delete("guestbook.delete", guestbookVo);
		System.out.println(count);
		return count;
	}
	
	//ajax 등록
	public int insertSelectKey(GuestbookVo guestbookVo) {
		System.out.println("GuestbookDao.insertSelectKey()");
		//System.out.println(guestbookVo); //no비어있음
		
		int count = sqlSession.insert("guestbook.insertSelectKey", guestbookVo);
		//System.out.println(guestbookVo); //no있음

		return count;
	}
	
	//데이터 하나 가져오기: no주면 한 명 데이터 가져오기
	public GuestbookVo guestbookSelectOne(int no) {
		System.out.println("GuestbookDao.guestbookSelectOne()");
		
		GuestbookVo gVo = sqlSession.selectOne("guestbook.selectOne", no);

		return gVo;
	}
	
}
