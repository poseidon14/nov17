package com.poseidon.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poseidon.dao.LoginDAO;
import com.poseidon.dto.LoginDTO;

@Service
public class LoginService {
	
	@Autowired
	private LoginDAO loginDAO;
	
	public LoginDTO login(LoginDTO dto) {
		if(dto.getId() != null || dto.getPw() != null) {
			return loginDAO.login(dto);			
		} else {
			dto.setCount(0);
			return dto;
		}
	}

}
