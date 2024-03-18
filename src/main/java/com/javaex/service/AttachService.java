package com.javaex.service;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.dao.AttachDao;
import com.javaex.vo.AttachVo;

@Service
public class AttachService {
	
	@Autowired
	private AttachDao attachDao;
	
	public String exeUpload(MultipartFile file) {
		System.out.println("AttachService.exeUpload()");
		System.out.println(file.getOriginalFilename());
		
		//파일저장 폴더
		String saveDir = "C:\\javaStudy\\upload";
		
		//(0)파일관련 정보수집
			//오리지날 파일명
		String orgName = file.getOriginalFilename();
		System.out.println("orgName: " + orgName); //orgName: Gangho-dong.jpg
		
			//확장자
		String exName = orgName.substring(orgName.lastIndexOf("."));
		System.out.println("exName: " + exName); //exName: .jpg
		//System.out.println(orgName.substring(4)); //ho-dong.jpg
		//System.out.println(orgName.lastIndexOf(".")); //11   .이 몇 번째에 있나
		
			//저장 파일명(겹치지 않아야 한다)
		String saveName = System.currentTimeMillis() + UUID.randomUUID().toString()+exName;
		System.out.println("saveName: " + saveName);
		//saveName: 1710729439983d88754e6-08fe-43ca-afc1-7ccc53637ff8.jpg
		
			//파일 사이즈
		long fileSize = file.getSize();
		System.out.println("fileSize: " + fileSize); //fileSize: 49876
		
			//파일 전체 경로(전체파일명 포함)
		String filePath = saveDir + "\\" + saveName;
		System.out.println("filePath: " + filePath);
		//filePath: C:\javaStudy\\upload\1710730071714 0a372705-172f-4a75-a250-91e8279f4299.jpg

		
		
		//(1)파일 정보를 DB에 저장
			//*vo로 묶어주고
		AttachVo attachVo = new AttachVo(orgName, saveName, filePath, fileSize);
		System.out.println(attachVo);
		
			//*db에 저장
		//dao의 메소드 호출해서 저장
		attachDao.saveFile(attachVo);
		System.out.println("....DB저장완료");
		
		//(2)파일을 하드디스크에 저장
			//파일저장
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
}
