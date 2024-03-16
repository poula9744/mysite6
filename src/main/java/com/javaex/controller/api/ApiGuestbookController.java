package com.javaex.controller.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.GuestbookService;
import com.javaex.vo.GuestbookVo;

@Controller
public class ApiGuestbookController {
	
	@Autowired
	private GuestbookService guestbookService;

	@ResponseBody  //return의 데이터를 json으로 변경해서 응답문서(response)의 Body에 붙여서 보내줘
	@RequestMapping(value="/api/guestbooks", method = RequestMethod.GET )
	public List<GuestbookVo> list() {
		System.out.println("ApiGuestbookController.list()");
		
		List<GuestbookVo> guestbookList = guestbookService.exeList();
		System.out.println(guestbookList);
		
		return guestbookList;
	}
	
	//등록
	@ResponseBody
	@RequestMapping(value="/api/guestbooks", method = RequestMethod.POST)
	public GuestbookVo add(@RequestBody GuestbookVo guestbookVo) {
		System.out.println("ApiGuestbookController.add()");

		
		GuestbookVo gVo = guestbookService.exeAddandGuest(guestbookVo);

		
		return gVo;
	}
	
	//삭제
	@ResponseBody
	@RequestMapping(value="/api/guestbooks/{no}", method = RequestMethod.DELETE)
	public int delete(@PathVariable("no") int no, @ModelAttribute GuestbookVo guestbookVo) {
		System.out.println("ApiGuestbookController.delete()");

		int count = guestbookService.exeDeleteandGuest(guestbookVo);
		
		return count;
	}
	
}
