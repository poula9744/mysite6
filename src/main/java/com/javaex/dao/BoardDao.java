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
	
	//리스트
	public List<BoardVo> boardList(){
		System.out.println("BoardDao.boardList()");
		List<BoardVo> boardList = sqlSession.selectList("board.select");
		System.out.println(boardList);
		return boardList;
	}
	
	//삭제
	public int boardDelete(BoardVo boardVo) {
		
		return sqlSession.delete("board.delete", boardVo);
	}
	
	//등록
	public int boardInsert(BoardVo boardVo) {
		
		return sqlSession.insert("board.insert", boardVo);
	}
	
	//read
	public BoardVo boardSelectOne(int no) {
		
		return sqlSession.selectOne("board.selectOne", no);
	}
	
	//수정
	public int boardModify(BoardVo boardVo) {
		
		return sqlSession.update("board.modify", boardVo);
	}
	
}
