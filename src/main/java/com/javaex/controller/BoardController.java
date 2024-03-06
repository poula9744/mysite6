package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.BoardService;
import com.javaex.vo.BoardVo;

@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;

	// 게시판 리스트
	@RequestMapping(value = "/board/list", method = { RequestMethod.GET, RequestMethod.POST })
	public String boardList(Model model) {
		System.out.println("BoardController.boardList()");

		List<BoardVo> boardList = boardService.exeList();
		model.addAttribute("boardList", boardList);

		return "/board/list";
	}

	// 삭제
	@RequestMapping(value = "/board/delete", method = { RequestMethod.GET, RequestMethod.POST })
	public String boardDelete(@ModelAttribute BoardVo boardVo) {
		System.out.println("BoardController.boardList()");

		boardService.exeDelete(boardVo);

		return "redirect:/board/list";
	}

	// 등록폼
	@RequestMapping(value = "/board/writeform", method = { RequestMethod.GET, RequestMethod.POST })
	public String boardWriteForm() {
		System.out.println("BoardController.boardWriteForm()");

		return "/board/writeForm";
	}

	// 등록
	@RequestMapping(value = "/board/write", method = { RequestMethod.GET, RequestMethod.POST })
	public String boardWrite(@ModelAttribute BoardVo boardVo) {
		System.out.println("BoardController.boardWrite()");

		boardService.exeInsert(boardVo);

		return "redirect:/board/list";
	}

	// read
	@RequestMapping(value = "/board/read", method = { RequestMethod.GET, RequestMethod.POST })
	public String boardRead(@RequestParam(value = "no") int no, Model model) {
		System.out.println("BoardController.boardRead()");

		BoardVo boardVo = boardService.exeSelectOne(no);
		model.addAttribute("boardVo", boardVo);

		return "/board/read";
	}

	// 수정폼
	@RequestMapping(value = "/board/modifyform", method = { RequestMethod.GET, RequestMethod.POST })
	public String boardModifyForm(@RequestParam(value = "no") int no, Model model) {
		System.out.println("BoardController.boardModifyForm()");

		BoardVo boardVo = boardService.exeSelectOne(no);
		model.addAttribute("boardVo", boardVo);

		return "/board/modifyForm";
	}

	// 수정
	@RequestMapping(value="/board/modify", method = { RequestMethod.GET, RequestMethod.POST })
	public String boardModify(@ModelAttribute BoardVo boardVo) {
		System.out.println("BoardController.boardModify()");
		
		int count = boardService.exeModify(boardVo);
		
		if (count == 1) {
			return "redirect:/board/list";
		} else {
			System.out.println("수정 실패");
			return "redirect:/main";
		}
	}
}
