package com.lgy.personal_project.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lgy.personal_project.dao.PlaceDao;
import com.lgy.personal_project.dto.PlaceDto;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service("PlaceService")
public class PlaceServiceImpl implements PlaceService{

	@Autowired
	private SqlSession sqlsession;	
	
	@Override
	public ArrayList<PlaceDto> list(HashMap<String, String> param) {
		log.info("@# PlaceServiceImpl.list() start");

		PlaceDao dao = sqlsession.getMapper(PlaceDao.class);

		log.info("@# PlaceServiceImpl.list() end");
		return 	dao.list(param);

	}

	@Override
	public void write(HashMap<String, String> param) {
		log.info("@# PlaceServiceImpl.write() start");

		PlaceDao dao = sqlsession.getMapper(PlaceDao.class);
		log.info("ServiceImpl ====>"+param.get("imgPath"));
		dao.write(param);

		log.info("@# PlaceServiceImpl.write() end");
	}

	
	
	@Override
	public PlaceDto contentView(HashMap<String, String> param) {
		log.info("@# PlaceServiceImpl.contentView() start");

		PlaceDao dao = sqlsession.getMapper(PlaceDao.class);
		PlaceDto dto = dao.contentView(param);
		log.info("@# PlaceServiceImpl.contentView() end");
		return dto;
	}

	@Override
	public void modify(HashMap<String, String> param) {
		log.info("@# PlaceServiceImpl.modify() start");

		PlaceDao dao = sqlsession.getMapper(PlaceDao.class);
		dao.modify(param);

		log.info("@# PlaceServiceImpl.modify() end");
	}

	@Override
	public void delete(int pno) {
		log.info("@# PlaceServiceImpl.delete() start");

		PlaceDao dao = sqlsession.getMapper(PlaceDao.class);
		dao.delete(pno);

		log.info("@# PlaceServiceImpl.delete() end");
	}
}
