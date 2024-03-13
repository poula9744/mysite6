package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.javaex.service.GuestbookService;
import com.javaex.vo.GuestbookVo;

@Controller
public class GuestbookController {

	@Autowired
	private GuestbookService guestbookService;

	// 게스트북: addList
	@RequestMapping(value = "/guestbook/addlist", method = { RequestMethod.GET, RequestMethod.POST })
	public String addList(Model model) {
		System.out.println("GuestbookController.addList()");

		List<GuestbookVo> guestbookList = guestbookService.exeList();
		model.addAttribute("guestbookList", guestbookList);

		return "/guestbook/addList";
	}

	// 등록
	@RequestMapping(value = "/guestbook/insert", method = { RequestMethod.GET, RequestMethod.POST })
	public String guestInsert(@ModelAttribute GuestbookVo guestbookVo) {
		System.out.println("GuestbookController.GuestInsert()");

		guestbookService.exeInsert(guestbookVo);

		return "redirect:/guestbook/addlist";
	}

	// 삭제폼
	@RequestMapping(value = "/guestbook/deleteform", method = { RequestMethod.GET, RequestMethod.POST })
	public String guestDeleteForm() {
		System.out.println("GuestbookController.deleteForm()");

		return "/guestbook/deleteForm";
	}

	// 삭제
	@RequestMapping(value = "/guestbook/delete", method = { RequestMethod.GET, RequestMethod.POST })
	public String guestDelete(@ModelAttribute GuestbookVo guestbookVo) {
		System.out.println("GuestbookController.deleteForm()");

		guestbookService.exeDelete(guestbookVo);
		return "redirect:/guestbook/addlist";
	}
	
	
	
	
	/////////////////////////////////////////////////
	//ajax 방명록 메인
	@RequestMapping(value="/guestbook/ajaxindex", method = { RequestMethod.GET, RequestMethod.POST })
	public String ajaxIndex() {
		System.out.println("GuestbookController.ajaxIndex()");
		
		
		return "/guestbook/ajaxIndex";
	}

}
