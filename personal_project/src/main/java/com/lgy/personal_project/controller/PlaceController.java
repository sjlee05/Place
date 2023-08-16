package com.lgy.personal_project.controller;

import java.io.File;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.lgy.personal_project.dto.PlaceDto;
import com.lgy.personal_project.service.PlaceService;

import lombok.extern.slf4j.Slf4j;


@Controller
@Slf4j
public class PlaceController {
	@Autowired
	private PlaceService service;

	@RequestMapping("/list")
	public String list(@RequestParam HashMap<String, String> param, String cate,Model model) {
		log.info("@# list");
		
		log.info("cate ====> "+cate);
		model.addAttribute("list", service.list(param));

		return "list";
	}

	@RequestMapping("/write")
	public String write(@RequestParam HashMap<String, String> param, @RequestParam("uploadFile") MultipartFile[] uploadFiles) {
		log.info("@# write");

		uploadFile(param,uploadFiles);
		service.write(param);
		

		return "redirect:list";
	}
	
	@RequestMapping("/write_view")
	public String write_view() {
		log.info("@# write_view");

		return "write_view";
	}
	
	@RequestMapping("/content_view")
	public String notice_content_view(@RequestParam HashMap<String, String> param, Model model, HttpSession session) {
		log.info("@# content_view");

		PlaceDto dto = service.contentView(param);
		

		System.out.println("param.get(\"pno\")"+param.get("pno"));
		System.out.println("dto.getLat()"+dto.getLat());
		System.out.println("dto.getLon()"+dto.getLon());
		model.addAttribute("dto", dto);
		

		return "content_view";
	}

	@RequestMapping("/modify")
	public String modify(@RequestParam HashMap<String, String> param) {
		log.info("@# modify");
		

		service.modify(param);
		

		return "redirect:list";

	}

	@RequestMapping("/modify_view")
	public String modify_view(@RequestParam HashMap<String, String> param
									,Model model) {
		log.info("@# modify_view");

		PlaceDto dto = service.contentView(param);

		model.addAttribute("dto", dto);

		return "modify_view";
	}

	@RequestMapping("/delete")
	public String delete(int pno) {
		log.info("@# delete");

		
		service.delete(pno);
		
		return "redirect:list";

	}
	public void uploadFile(@RequestParam HashMap<String, String> param, @RequestParam("uploadFile") MultipartFile[] uploadFiles) {
	    log.info("@# uploadFile");

	    String uploadFolder = "D:\\dev\\looklike";
//	    String uploadFolder = "\\img";

	    // 현재 날짜 폴더 생성
	    LocalDate currentDate = LocalDate.now();
	    String dateFolder = currentDate.toString();
	    String uploadPath = uploadFolder+ File.separator + dateFolder;

	    File uploadDir = new File(uploadPath);
	    if (!uploadDir.exists()) {
	        uploadDir.mkdirs();
	    }

	    for (MultipartFile uploadFile : uploadFiles) {
	        if (!uploadFile.isEmpty()) {
	            log.info("-----------------------------------------------");
	            log.info("파일 이름 : " + uploadFile.getOriginalFilename());
	            log.info("파일 타입 : " + uploadFile.getContentType());
	            log.info("파일 크기 : " + uploadFile.getSize());


				String uuid = UUID.randomUUID().toString().replace("-", "");

				String originalFileName = uploadFile.getOriginalFilename();
				String extension = originalFileName.substring(originalFileName.lastIndexOf("."));

				String imgPath = uuid + extension;
				File saveFile = new File(uploadPath, imgPath);

	            try {
	                uploadFile.transferTo(saveFile);
	    		    param.put("imgPath", "/"+dateFolder+"/"+imgPath);
	    		    log.info("imgPath ====>"+imgPath);
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	
	        }
	    }
	}
}
