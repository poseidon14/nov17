package com.poseidon.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.poseidon.dto.CommentDTO;

@Repository
public class CommentDAO {
	
	@Autowired
	private SqlSession sqlSession;

	public CommentDTO repairComment(CommentDTO update) {
		return sqlSession.selectOne("comment.repairComment", update);
	}

	public void updateComment(CommentDTO dto) {
		sqlSession.update("comment.updateComment", dto);
	}
}
