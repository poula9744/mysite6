package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.BoardDao;
import com.javaex.vo.BoardVo;

@Service
public class BoardService {

	@Autowired
	private BoardDao boardDao;

	//////////////////////////////////////////
	// 일반게시판 //
	//////////////////////////////////////////
	// 리스트
	public List<BoardVo> exeList() {
		System.out.println("BoardService.exeList()");

		List<BoardVo> boardList = boardDao.boardList();

		return boardList;
	}

	// 삭제
	public int exeDelete(BoardVo boardVo) {
		System.out.println("BoardService.exeDelete()");

		int count = boardDao.boardDelete(boardVo);
		System.out.println(count);
		return count;
	}

	// 등록
	public int exeInsert(BoardVo boardVo) {
		System.out.println("BoardService.exeInsert()");

		return boardDao.boardInsert(boardVo);
	}

	// read
	public BoardVo exeSelectOne(int no) {
		System.out.println("BoardService.exeSelectOne()");

		return boardDao.boardSelectOne(no);
	}

	// 수정
	public int exeModify(BoardVo boardVo) {
		System.out.println("BoardService.exeModify()");

		int count = boardDao.boardModify(boardVo);

		return count;
	}

	// 검색
	public List<BoardVo> exeSearch(String search) {
		System.out.println("BoardService.exeSearch()");

		List<BoardVo> boardList = boardDao.searchList(search);

		return boardList;
	}

	//////////////////////////////////////////
	// 댓글게시판 //
	//////////////////////////////////////////
	// 댓글 list
	public List<BoardVo> exeCommentList() {
		System.out.println("BoardService.exeCommentList()");

		List<BoardVo> commentList = boardDao.CommentList();

		return commentList;
	}

	// 등록
	public int exeCommentInsert(BoardVo commentVo) {
		System.out.println("BoardService.exeCommentInsert()");

		return boardDao.commentInsert(commentVo);
	}

	// read
	public BoardVo exeCommentSelectOne(int no) {
			System.out.println("BoardService.exeSelectOne()");

			return boardDao.commentSelectOne(no);
		}

	// 수정
	public int exeCommentModify(BoardVo commentVo) {
		System.out.println("BoardService.exeCommentModify()");

		int count = boardDao.commentModify(commentVo);

		return count;
	}
}
