package com.poseidon.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poseidon.dao.CommentDAO;
import com.poseidon.dto.CommentDTO;

@Service
public class CommentService {
	
	@Autowired
	private CommentDAO commentDAO;

	public CommentDTO repairComment(CommentDTO update) {
		return commentDAO.repairComment(update);
	}

	public void updateComment(CommentDTO dto) {
		commentDAO.updateComment(dto);
		
	}
}
