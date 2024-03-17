package com.javaex.controller.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.BoardService;
import com.javaex.vo.BoardVo;

@Controller
public class ApiBoardController {

	@Autowired
	private BoardService boardService;

	//////////////////////////////////////////
	// /ajax 댓글게시판 //
	//////////////////////////////////////////
	// ajax 댓글 게시판
	@RequestMapping(value = "/board/commentlist", method = { RequestMethod.GET, RequestMethod.POST })
	public String ajaxCommentList() {
		System.out.println("ApiBoardController.ajaxCommentList()");

		return "/board/commentList";
	}

	// 게시판 리스트
	@ResponseBody
	@RequestMapping(value = "/api/board/comments", method = RequestMethod.GET)
	public List<BoardVo> commentList() {
		System.out.println("BoardController.commentList()");

		List<BoardVo> commentList = boardService.exeCommentList();
		System.out.println(commentList);
		return commentList;
	}
	
	// 댓글 read
	@RequestMapping(value = "/board/commentreads", method = { RequestMethod.GET, RequestMethod.POST })
	public String ajaxCommentRead() {
		System.out.println("ApiBoardController.ajaxCommentRead()");

		return "/board/commentRead";
	}


	@ResponseBody 
	@RequestMapping(value = "/api/board/commentread/{no}", method = { RequestMethod.GET })
	public BoardVo commentRead(@PathVariable(value = "no") int no, Model model) {
		System.out.println("BoardController.commentread()");
		System.out.println(no);
		BoardVo commentVo = boardService.exeCommentSelectOne(no);
		return commentVo;
	}
}
