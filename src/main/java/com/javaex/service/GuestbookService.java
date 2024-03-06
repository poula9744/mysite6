package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.GuestbookDao;
import com.javaex.vo.GuestbookVo;

@Service
public class GuestbookService {

	@Autowired
	private GuestbookDao guestbookDao;

	// list
	public List<GuestbookVo> exeList() {

		return guestbookDao.guestList();
	}

	// 등록
	public void exeInsert(GuestbookVo guestbookVo) {
		System.out.println("GuestbookService.exeInsert()");

		guestbookDao.guestbookInsert(guestbookVo);
	}

	// 삭제
	public void exeDelete(GuestbookVo guestbookVo) {
		System.out.println("GuestbookService.exeDelete()");

		guestbookDao.guestbookDelete(guestbookVo);
	}
}
