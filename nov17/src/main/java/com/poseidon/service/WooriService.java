package com.poseidon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poseidon.dao.WooriDAO;
import com.poseidon.dto.BoardDTO;
import com.poseidon.dto.LoginDTO;

@Service
public class WooriService {

	@Autowired
	private WooriDAO wooriDAO;

	public LoginDTO login(LoginDTO dto) {
		if(dto.getId() != null || dto.getPw() != null) {
			return wooriDAO.login(dto);			
		} else {
			dto.setCount(0);
			return dto;
		}
	}

	public List<BoardDTO> boardList() {
		return wooriDAO.boardList();
	}

	public int write(BoardDTO dto) {
		return wooriDAO.write(dto);
	}

}