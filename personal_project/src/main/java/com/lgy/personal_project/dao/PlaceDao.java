package com.lgy.personal_project.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.lgy.personal_project.dto.PlaceDto;

public interface PlaceDao {
	public ArrayList<PlaceDto> list(HashMap<String, String> param);
	public void write(HashMap<String, String> param);
	public PlaceDto contentView(HashMap<String, String> param);
	public void modify(HashMap<String, String> param);
	public void delete(int pno);
	public void upHit(HashMap<String, String> param);
}
