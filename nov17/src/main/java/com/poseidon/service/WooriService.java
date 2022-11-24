package com.poseidon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poseidon.dao.WooriDAO;
import com.poseidon.dto.BoardDTO;
import com.poseidon.dto.CommentDTO;

@Service
public class WooriService {

	@Autowired
	private WooriDAO wooriDAO;


	public List<BoardDTO> boardList(BoardDTO send) {
		return wooriDAO.boardList(send);
	}

	public int write(BoardDTO dto) {
		return wooriDAO.write(dto);
	}
	
	//컨트롤러 -> 서비스 -> DAO -> sqlSession -> DB
	public BoardDTO detail(BoardDTO dto) {
		return wooriDAO.detail(dto);
	}

	public void delete(BoardDTO dto) {
		wooriDAO.delete(dto);
	}

	public void update(BoardDTO dto) {
		wooriDAO.update(dto);		
	}

	public int commentInsert(CommentDTO dto) {
		return wooriDAO.commentInsert(dto);
	}

	public List<CommentDTO> commentList(BoardDTO dto) {
		return wooriDAO.commentList(dto);
	}

	public int commentDel(CommentDTO dto) {
		return wooriDAO.commentDel(dto);
	}

	public int totalCount() {
		return wooriDAO.totalCount();
	}

}