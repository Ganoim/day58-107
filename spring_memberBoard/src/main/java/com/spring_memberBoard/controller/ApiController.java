package com.spring_memberBoard.controller;

import java.io.IOException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring_memberBoard.dto.Bus;
import com.spring_memberBoard.service.ApiService;

@Controller
public class ApiController {

	@Autowired
	private ApiService apisvc;

	@RequestMapping(value = "/busapi")
	public ModelAndView busapi() throws Exception {
		System.out.println("버스도착정보 페이지 이동요청 - /busapi");
		ModelAndView mav = new ModelAndView();

		// 1. 버스 도착 정보 조회
		ArrayList<Bus> result = apisvc.getBusArrive();
		mav.addObject("busList", result);

		// 2. 버스도착정보 페이지
		mav.setViewName("BusList");

		return mav;
	}
	
	@RequestMapping(value = "/busapi_ajax")
	public ModelAndView busapi_ajax() {
		System.out.println("busapi_ajax 요청");
		ModelAndView mav = new ModelAndView();
		
		
		
		mav.setViewName("BusArriveInfo");
		
		return mav;
	}
	
	@RequestMapping(value = "/getBusArr")
	public @ResponseBody String getBusArr(String nodeId, String routeno) {
		System.out.println("버스 도착정보 조회 요청 = /getBusArr");
		System.out.println("nodeId : " + nodeId);
		System.out.println("routeno : " + routeno);
		//1. SERVICE - 도착정보 조회 기능 호출
		String arrInfoList = null;
			try {
				arrInfoList = apisvc.getBusArrInfoList(nodeId, routeno);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		
			
		//2. 도착정보 반환
		return arrInfoList;
	}
	
	@RequestMapping(value = "/getBusSttn")
	public @ResponseBody String getBusSttn(String lati, String longti) {
		System.out.println("좌표기반 근접정류소 목록조회 = /getBusSttn");
		
		String sttnList = null;
		try {
			sttnList = apisvc.getBusSttnLost(lati, longti);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		return sttnList;
	}
	
	@RequestMapping(value = "/getBusGps")
	public @ResponseBody String getBusGps(String routeid) {
		System.out.println("노선별버스위치 목록조회 = /getBusSttn");
		
		String busbus = null;
		try {
			busbus = apisvc.getBusRouteId(routeid);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		return busbus;
	}
	
	
	
	
	
	
	

}
