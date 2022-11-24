package com.poseidon.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.poseidon.dto.BoardDTO;
import com.poseidon.dto.CommentDTO;

@Repository
public class WooriDAO {
	@Autowired
	private SqlSession sqlSession;



	public List<BoardDTO> boardList(BoardDTO send) {
		return sqlSession.selectList("board.boardList", send);
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

	public int commentInsert(CommentDTO dto) {
		return sqlSession.insert("board.commentInsert", dto);
	}

	public List<CommentDTO> commentList(BoardDTO dto) {
		return sqlSession.selectList("board.commentList", dto);
	}

	public int commentDel(CommentDTO dto) {
		return sqlSession.delete("comment.commentDel", dto);
	}

	public int totalCount() {
		return sqlSession.selectOne("board.totalCount");
	}

}