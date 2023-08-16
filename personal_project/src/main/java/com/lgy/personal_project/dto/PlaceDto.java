package com.lgy.personal_project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PlaceDto {
	private int pno;
	private String title;
	private String content;
	private String address;
	private String imgPath;
	private String cate;
	private String lat;
	private String lon;
}
