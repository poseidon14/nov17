package com.poseidon.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.poseidon.dto.CommentDTO;
import com.poseidon.service.CommentService;

@Controller
public class CommentController {
	
	@Autowired
	private CommentService commentService; 
	
	@GetMapping("/repairComment")
	public ModelAndView repairComment(
							@RequestParam(value = "cno") int cno,
							@RequestParam(value = "bno") int bno, HttpSession session) {
		ModelAndView mv = new ModelAndView("redirect:/");
		//내글만 보이게 하기 -> 다른사람글은 수정 못하게 하기
		if(session.getAttribute("id") != null) {
			
			CommentDTO update = new CommentDTO();
			update.setC_no(cno);
			update.setMid((String) session.getAttribute("id"));
			update.setBoard_no(bno);
			
			mv.setViewName("repairComment");
			CommentDTO dto = commentService.repairComment(update);
			if(dto != null) {
				mv.addObject("dto", dto);
				
			} else {
				mv.setViewName("redirect:/error");
			}
			//System.out.println(dto);
			//System.out.println(dto == null);//같은 객체?
			
		}
		return mv;
	}
	
	@PostMapping("/repairComment")
	public String repairComment1(@RequestParam(value = "cno") int cno,
								@RequestParam(value = "bno") int bno,
								@RequestParam(value = "comment") String comment,
								HttpSession session) {
		if(session.getAttribute("id") != null) {
			CommentDTO dto = new CommentDTO();
			dto.setC_no(cno);
			//dto.setBoard_no(bno);
			dto.setC_comment(comment);
			dto.setMid((String)session.getAttribute("id"));
			
			commentService.updateComment(dto);
			
		}
		return "redirect:/detail?bno="+bno;//어디로 가야?
	}
}





