package com.javaex.vo;

public class BoardVo {
	
	//필드
	private int no;
	private int userNo;
	private String title;
	private String content;
	private int hit;
	private String regDate;
	private int groupNo;
	private int orderNo;
	private int depth;
	
	private String name;
	
	private String search;
	
	//생성자
	public BoardVo() {
		super();
	}
	
	

	public BoardVo(String title, String name) {
		super();
		this.title = title;
		this.name = name;
	}



	public BoardVo(int no, int userNo, String title, String content) {
		super();
		this.no = no;
		this.userNo = userNo;
		this.title = title;
		this.content = content;
	}
	
	


	public BoardVo(int no, int userNo, String title, String content, int hit, String regDate, String name) {
		super();
		this.no = no;
		this.userNo = userNo;
		this.title = title;
		this.content = content;
		this.hit = hit;
		this.regDate = regDate;
		this.name = name;
	}


	public BoardVo(int no, int userNo, String title, String content, int hit, String regDate, int groupNo, int orderNo,
			int depth, String name) {
		super();
		this.no = no;
		this.userNo = userNo;
		this.title = title;
		this.content = content;
		this.hit = hit;
		this.regDate = regDate;
		this.groupNo = groupNo;
		this.orderNo = orderNo;
		this.depth = depth;
		this.name = name;
	}




	//메소드 - g/s
	public int getNo() {
		return no;
	}


	public void setNo(int no) {
		this.no = no;
	}


	public int getUserNo() {
		return userNo;
	}


	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public int getHit() {
		return hit;
	}


	public void setHit(int hit) {
		this.hit = hit;
	}


	public String getRegDate() {
		return regDate;
	}


	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}


	public int getGroupNo() {
		return groupNo;
	}


	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}


	public int getOrderNo() {
		return orderNo;
	}


	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}


	public int getDepth() {
		return depth;
	}


	public void setDepth(int depth) {
		this.depth = depth;
	}


	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
	
	public String getSearch() {
		return search;
	}



	public void setSearch(String search) {
		this.search = search;
	}



	//메소드 - 일반
	@Override
	public String toString() {
		return "BoardVo [no=" + no + ", userNo=" + userNo + ", title=" + title + ", content=" + content + ", hit=" + hit
				+ ", regDate=" + regDate + ", groupNo=" + groupNo + ", orderNo=" + orderNo + ", depth=" + depth
				+ ", name=" + name + "]";
	}



	
	
}
