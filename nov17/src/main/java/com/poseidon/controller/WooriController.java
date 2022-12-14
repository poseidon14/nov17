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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.poseidon.dto.BoardDTO;
import com.poseidon.dto.CommentDTO;
import com.poseidon.service.WooriService;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class WooriController {

	@Autowired
	private WooriService wooriService;

	@RequestMapping(value = "/")
	public String index(HttpServletRequest request) throws Exception {
		//ModelAndView mv = new ModelAndView("index");
		return "index";
	}

	@GetMapping(value = "/main")
	public ModelAndView main(@RequestParam(value="pageNo", required=false, defaultValue="1") int pageNo, 
								HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("main");
		//페이징을 사용하기 위해서 먼저 할일
		//pageNo
		//전체 글 수  220 / 10 = 22
		int totalCount = wooriService.totalCount();//
		//System.out.println("전체 글 수 : " + totalCount);
		
		//페이지네이션인포
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(pageNo);//현재 페이지 번호
		paginationInfo.setPageSize(10);//페이지 리스트에 게시되는 페이지 건수
		paginationInfo.setRecordCountPerPage(10);//한 페이지당 게시되는 게시물 건 수
		paginationInfo.setTotalRecordCount(totalCount);//전체 게시물 건 수
		
		//startPage = 페이지 리스트의 첫 페이지 번호
		int startPage = paginationInfo.getFirstRecordIndex();//죄송해요 ㅠㅠ
		//lastPage = 	페이지 리스트의 마지막 페이지 번호
		int lastPage = paginationInfo.getRecordCountPerPage();
		//System.out.println("startPage : " + startPage);
		//System.out.println("lastPage : " + lastPage);
		
		BoardDTO send = new BoardDTO();//db에 보내주기 위해서
		send.setStartPage(startPage);
		send.setLastPage(lastPage);
		
		List<BoardDTO> list = wooriService.boardList(send);
		//System.out.println(list);
		mv.addObject("list", list);//게시글 10
		mv.addObject("paginationInfo", paginationInfo);//페이지네이션
		//mv.addObject("pageNo", pageNo);//페이지번호?
		return mv;
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
	//그냥 페이지를 열기만 한다  = String
	//데이터를 붙여서 열어야 한다 = ModelAndView
	
	@GetMapping("/detail")
	public ModelAndView detail(HttpServletRequest request) {//bno=글번호
		ModelAndView mv = new ModelAndView("detail");
		if(request.getParameter("bno") != null) {//숫자인데 왜?			
			//System.out.println(request.getParameter("bno"));
			int bno = Integer.parseInt(request.getParameter("bno"));
			BoardDTO dto = new BoardDTO();
			dto.setBoard_no(bno);
			//컨트롤러 -> 서비스 -> DAO -> sqlSession -> DB
			BoardDTO detail = wooriService.detail(dto);//bno -> dto
			//System.out.println(detail.getBoard_title());
			//System.out.println(detail.getBoard_content());
			//System.out.println(detail.getBoard_no());
			mv.addObject("detail", detail);//붙여주세요.
			//댓글도 불러와서 mv에 붙이기
			//System.out.println("댓글 수 : " + detail.getCommentcount());
			if(detail.getCommentcount() != 0) {
				List<CommentDTO> commentList = wooriService.commentList(dto);
				mv.addObject("commentList", commentList);
				System.out.println("댓글 수 : " + commentList.size());
			}
		} else {
			//작업 안 하면 됩니다.
		}
		
		return mv;
	}
	
	@GetMapping("/delete")
	public String delete(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if(session.getAttribute("id") != null) {
			//출력문으로 bno를 찍어주세요.
			//System.out.println(request.getParameter("bno"));
			
			int bno = Integer.parseInt(request.getParameter("bno"));
			BoardDTO dto = new BoardDTO();
			dto.setBoard_no(bno);
			dto.setMid((String) session.getAttribute("id"));
			
			wooriService.delete(dto);//void 반환타입이 없습니다.
			return "redirect:/main";
		}else {
			//로그인 안 함 = /로 던지기
			return "redirect:/";
		}
		
	}
	//수정하기 -> DB 그내용 가져오기 -> 화면에 출력 -> 수정 -> 저장 -> DB저장
	
	//수정하기 2022-11-22
	@GetMapping("/update")
	public ModelAndView update(HttpSession session, @RequestParam(value = "bno", required = true) int bno) {
		//@RequestParam(value = "bno", required = true) int bno
		//파라미터로 들어오는 값을 자동 변환, 필수값으로 지정
		
		ModelAndView mv = new ModelAndView("redirect:/");
		//로그인 검사 + bno검사
		if(session.getAttribute("id") != null) {
			//System.out.println("param이 잡은 bno : " + bno);
			//데이터 가져오기
			BoardDTO dto = new BoardDTO();
			dto.setBoard_no(bno);
			dto.setMid((String) session.getAttribute("id"));
			
			BoardDTO result = wooriService.detail(dto);//변경할겁니다.

			System.out.println(result.getBoard_no());
			System.out.println(result.getBoard_title());
			System.out.println(result.getBoard_content());
			
			mv.addObject("update", result);
			
			mv.setViewName("update");
		}
		
		return mv;
	}
	
	@PostMapping("/update")
	public String update(HttpServletRequest request){//데이터 받아서 DB에 보내고, 페이지 이동
		//System.out.println(request.getParameter("bno"));
		//System.out.println(request.getParameter("title"));
		//System.out.println(request.getParameter("content"));
		
		BoardDTO dto = new BoardDTO();
		//int bno = Integer.parseInt(request.getParameter("bno"));
		dto.setBoard_no(Integer.parseInt(request.getParameter("bno")));
		dto.setBoard_title(request.getParameter("title"));
		dto.setBoard_content(request.getParameter("content"));
		//세션
		HttpSession session = request.getSession();
		dto.setMid((String)session.getAttribute("id"));//이것도 가야 합니다.
		
		wooriService.update(dto);
		
		return "redirect:/detail?bno="+request.getParameter("bno");
	}
	
	@PostMapping("/comment")
	public String commentInput(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if(session.getAttribute("id") != null) {
			//System.out.println(request.getParameter("comment"));
			//System.out.println(request.getParameter("bno"));
			//System.out.println(session.getAttribute("id"));
			//데이터베이스에 저장하기
			CommentDTO dto = new CommentDTO();
			dto.setBoard_no(Integer.parseInt(request.getParameter("bno")));
			dto.setC_comment(request.getParameter("comment"));
			dto.setMid((String)session.getAttribute("id"));
			
			//Controller -> service -> dao -> sqlsession ->db
			int result = wooriService.commentInsert(dto);
			
			System.out.println("저장결과 : " + result);
			
			return "redirect:/detail?bno="+request.getParameter("bno");
		}else {			
			return "redirect:/";
		}
	}
	//REST API
	@PostMapping("/commentDel")
	public @ResponseBody String commentDel(@RequestParam(value="bno") int bno,
					@RequestParam(value="cno") int cno, HttpSession session) {
		int result = 0;
		if(session.getAttribute("id") != null){		
			System.out.println(bno);
			System.out.println(cno);
			System.out.println(session.getAttribute("id"));
			
			//데이터베이스로 보내서 삭제하는 명령 필요
			CommentDTO dto = new CommentDTO();
			dto.setBoard_no(bno);
			dto.setC_no(cno);
			dto.setMid((String)session.getAttribute("id"));
			
			result = wooriService.commentDel(dto);
			return result+"";
		}else {
			return "9";					
		}
	}
}