package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.service.GalleryService;
import com.javaex.vo.GalleryVo;

@Controller
public class GalleryController {
	
	@Autowired
	private GalleryService galleryService;
	
	//갤러리 메인
	@RequestMapping(value="/gallery/list", method = {RequestMethod.GET, RequestMethod.POST})
	public String list(Model model) {
		System.out.println("GalleryController.list()");
		
		List<GalleryVo> galleryList = galleryService.exeList();
		model.addAttribute("galleryList", galleryList);
		
		return "gallery/list";
	}
	
	//갤러리 이미지 등록
	@ResponseBody
	@RequestMapping(value="/gallery/upload", method =  RequestMethod.POST )
	public String upload(@RequestParam(value="img", required = false) MultipartFile img, 
										 @RequestParam(value="content") String content,  
										 @RequestParam(value="userNo") int userNo, 
										 Model model) {
		System.out.println("GalleryController.upload()");
		String saveName = galleryService.exeUpload(img, content, userNo);
		model.addAttribute("saveName", saveName);
		return "gallery/list";
	}
	
	
}
