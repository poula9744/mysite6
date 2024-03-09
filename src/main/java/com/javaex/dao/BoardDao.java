package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.BoardVo;

@Repository
public class BoardDao {

	@Autowired
	private SqlSession sqlSession;

	//////////////////////////////////////////
	// 일반게시판 //
	//////////////////////////////////////////

	// 리스트
	public List<BoardVo> boardList() {
		System.out.println("BoardDao.boardList()");
		List<BoardVo> boardList = sqlSession.selectList("board.select");
		System.out.println(boardList);
		return boardList;
	}

	// 삭제
	public int boardDelete(BoardVo boardVo) {

		return sqlSession.delete("board.delete", boardVo);
	}

	// 등록
	public int boardInsert(BoardVo boardVo) {

		return sqlSession.insert("board.insert", boardVo);
	}

	// read
	public BoardVo boardSelectOne(int no) {
		sqlSession.update("board.updateHit", no);
		return sqlSession.selectOne("board.selectOne", no);
	}

	// 수정
	public int boardModify(BoardVo boardVo) {

		return sqlSession.update("board.modify", boardVo);
	}

	// 검색
	public List<BoardVo> searchList(String search) {
		System.out.println("BoardDao.searchList()");
		List<BoardVo> boardList = sqlSession.selectList("board.search", search);
		System.out.println(boardList);
		return boardList;
	}

	//////////////////////////////////////////
	// 댓글게시판 //
	//////////////////////////////////////////
	// 댓글 list
	// 리스트
	public List<BoardVo> CommentList() {
		System.out.println("BoardDao.CommentList()");
		List<BoardVo> commentList = sqlSession.selectList("board.commentSelect");
		System.out.println(commentList);
		return commentList;
	}

	// 등록
	public int commentInsert(BoardVo commentVo) {
		int count = sqlSession.insert("board.commentInsert", commentVo);
		System.out.println(count);
		return count;
	}

	// read
	public BoardVo commentSelectOne(int no) {
		sqlSession.update("board.commentUpdateHit", no);
		return sqlSession.selectOne("board.commentSelectOne", no);
	}

	// 수정
	public int commentModify(BoardVo commentVo) {

		return sqlSession.update("board.commentModify", commentVo);
	}

}
