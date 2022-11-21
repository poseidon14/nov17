package com.poseidon.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.poseidon.dto.BoardDTO;
import com.poseidon.dto.LoginDTO;
import com.poseidon.service.WooriService;

@Controller
public class WooriController {

	@Autowired
	private WooriService wooriService;

	@RequestMapping(value = "/")
	public ModelAndView index(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("index");
		return mv;
	}

	@GetMapping(value = "/main")
	public ModelAndView main(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("main");
		//DB에 데이터 요청하기
		List<BoardDTO> list = wooriService.boardList();
		//System.out.println(list);
		mv.addObject("list", list);
		return mv;
	}

	@PostMapping("/login")
	public String login(LoginDTO dto, HttpServletRequest request) {
		LoginDTO result = wooriService.login(dto);
		if (result.getCount() == 1) {
			// 세션만들어주기
			HttpSession session = request.getSession();
			session.setAttribute("name", result.getName());
			session.setAttribute("id", dto.getId());
			return "redirect:/main";
		} else {
			return "redirect:/";
		}
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		if(session.getAttribute("name") != null || session.getAttribute("id") != null) {			
			session.invalidate();// 모두 초기화!!!!!
		}
		return "redirect:/";// 컨트롤러 다시 돌아가기
	}

	
	//2022-11-21 빅데이터 처리시스템 개발 / 빅데이터 처리시스템 설계하기
	@PostMapping("/write")
	public String write(HttpServletRequest request) throws UnsupportedEncodingException {
		//한글설정
		request.setCharacterEncoding("UTF-8");
		//로그인 했는지 여부를 먼저 물어보기

		//세션에서 사용자 정보 가저오기
		HttpSession session = request.getSession();
		if(session.getAttribute("id") != null 
									&& request.getParameter("title") != null 
									&& request.getParameter("content") != null) {
			//데이터베이스에 글 저장하기
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			BoardDTO dto = new BoardDTO();
			dto.setBoard_title(title);
			dto.setBoard_content(content);
			dto.setName((String) session.getAttribute("id"));
			//dto.setMno(3); 번호를 모릅니다. 단, id는 알고 있습니다. 그래서 id를....
			int result = wooriService.write(dto);
			
			if(result == 1) {
				return "redirect:/main?result=ok";//정상
			} else {
				return "redirect:/main?result=error";//문제 발생
			}
		} else {
			return "redirect:/";//로그인 화면으로 던지기
		}
	}
	
	
}