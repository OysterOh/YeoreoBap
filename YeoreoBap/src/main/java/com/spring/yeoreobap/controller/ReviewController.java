package com.spring.yeoreobap.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.yeoreobap.command.ReviewVO;
import com.spring.yeoreobap.command.UserVO;
import com.spring.yeoreobap.review.service.IReviewService;
import com.spring.yeoreobap.util.PageCreator;
import com.spring.yeoreobap.util.PageVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/review")
@Slf4j
public class ReviewController {

	@Autowired
	private IReviewService service;
	
	
	@GetMapping("/reviewList")
	public void reviewList(PageVO vo, Model model) {
		PageCreator pc = new PageCreator(vo, service.getTotal(vo));
		log.info("getTotal : " + service.getTotal(vo));
		System.out.println("store: " + pc.toString());
		log.info(pc.toString());
		
		model.addAttribute("reviewList",service.getList(vo));
		model.addAttribute("pc", pc);
	}
	
	@GetMapping("/reviewList2")
	public void reviewList2(Model model) {
		model.addAttribute("reviewList",service.getList2());
	}
	
	@GetMapping("/reviewRegist")
	public void regist(HttpSession session, Model model) {
		
		String userId = ((UserVO) session.getAttribute("userInfo")).getUserId();
		
		model.addAttribute("party" ,service.getResList1(userId));
		model.addAttribute("attendedParty" ,service.getResList2(userId));
	}
	
	@PostMapping("/regist")
	public String regist(ReviewVO vo) {
		service.regist(vo);
		return "redirect:/review/reviewList";
	}
	
	@GetMapping("/content/{reviewNo}")
	public String getContent(@PathVariable int reviewNo, @ModelAttribute("p") PageVO vo
			, Model model) {
		model.addAttribute("article", service.getArticle(reviewNo));
		return "review/reviewDetail";
	}
	
	@PostMapping("/modify")
	public String modify(@ModelAttribute("article") ReviewVO vo) {
		log.info(vo.toString());
		return "review/reviewModify";
	}
	
	@PostMapping("/update")
	public String update(ReviewVO vo) {
		service.update(vo);
		return "redirect:/review/content/" + vo.getReviewNo();
	}
	
	@PostMapping("/delete")
	public String delete(@ModelAttribute("article") ReviewVO vo) {
		int reviewNo = vo.getReviewNo();
		service.delete(reviewNo);
		return "redirect:/review/reviewList";
	}
	
	
	
}