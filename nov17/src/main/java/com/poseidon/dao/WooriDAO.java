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
		return sqlSession.selectList("board.boardList");// 파라미터가 없어요.
	}

	public int write(BoardDTO dto) {
		return sqlSession.insert("board.write", dto);
	}

	// 컨트롤러 -> 서비스 -> DAO -> sqlSession -> DB
	public BoardDTO detail(BoardDTO dto) {
		return sqlSession.selectOne("board.detail", dto);
	}

	public void delete(BoardDTO dto) {
		sqlSession.delete("board.delete", dto);
	}

	public void update(BoardDTO dto) {
		sqlSession.update("board.update", dto);
	}

}