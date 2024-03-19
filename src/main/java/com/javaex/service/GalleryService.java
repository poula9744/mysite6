package com.javaex.service;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.dao.GalleryDao;
import com.javaex.vo.GalleryVo;

@Service
public class GalleryService {

	@Autowired
	private GalleryDao galleryDao;
	
	public List<GalleryVo> exeList(){
		System.out.println("GalleryService.exeList()");
		
		List<GalleryVo> galleryList = galleryDao.galleryList();
		
		return galleryList;
	}
	
	public String exeUpload(MultipartFile file, String content, int userNo) {
		System.out.println("GalleryService.exeUpload()");
		
		//파일저장 폴더
		String saveDir = "C:\\javaStudy\\upload";
		
		//(0)파일관련 정보수집
		String orgName = file.getOriginalFilename();
		String exName = orgName.substring(orgName.lastIndexOf("."));
		String saveName = System.currentTimeMillis() + UUID.randomUUID().toString() + exName;
		long fileSize = file.getSize();
		String filePath = saveDir + "\\" + saveName;
		System.out.println(filePath);
		
		//(1)파일 정보를 DB에 저장
		GalleryVo galleryVo = new GalleryVo(userNo, content, filePath, orgName, saveName, fileSize);
		System.out.println(galleryVo);
		galleryDao.saveFile(galleryVo);
		System.out.println("DB저장완료");
		//(2)파일을 하드디스크에 저장
		try {
			byte[] fileData = file.getBytes();
		
			OutputStream os = new FileOutputStream(filePath);
			BufferedOutputStream bos = new BufferedOutputStream(os);
			bos.write(fileData);
			bos.close();
		
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return saveName;
	}
	
	public int exeDelete(GalleryVo galleryVo) {
		System.out.println("GalleryService.exeDelete()");
		int count = galleryDao.galleryDelete(galleryVo);
		return count;
	}
}
