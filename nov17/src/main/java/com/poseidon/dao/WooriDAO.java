package com.poseidon.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.poseidon.dto.BoardDTO;
import com.poseidon.dto.LoginDTO;

@Repository
public class WooriDAO {
	@Autowired
	private SqlSession sqlSession;

	public LoginDTO login(LoginDTO dto) {
		return sqlSession.selectOne("login.login", dto);
	}

	public List<BoardDTO> boardList() {
		return sqlSession.selectList("board.boardList");//파라미터가 없어요.
	}

	public int write(BoardDTO dto) {
		return sqlSession.insert("board.write", dto);
	}

}