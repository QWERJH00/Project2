package pjmember;

import java.sql.ResultSet;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBConnect;
import model1.board.BoardDTO;
import pjboard.PJBoardDTO;


public class PJMemberDAO extends JDBConnect {
	public PJMemberDAO(String drv, String url, String id, String pw) {
		super(drv, url, id, pw);
	}
	// application 내장객체만 매개변수로 전달한 후 DB에 연결한다.
	public PJMemberDAO(ServletContext application) {
		super(application);
	}
	
	/*
	  	사용자가 입력한 아이디,패스워드를 통해 회원테이블을 select한 후
	  	존재하는 정보인 경우 DTO객체에 그 정보를 담아 반환한다.
	*/
	public PJMemberDTO getPJMemberDTO(String uid, String upass) {
		// 로그인을 위한 쿼리문을 실행한 후 회원정보를 저장하기위해 생성
		PJMemberDTO dto = new PJMemberDTO();
		System.out.println(uid+upass);
		
		// 로그인을 위해 인파라미터가 있는 동적 쿼리문 작성
		String query = "SELECT * FROM pjmember WHERE id=? AND pass=?";
		
		try {
			// 쿼리문 실행을 위한 prepared객체 생성 및 인파라미터 설정
			psmt = con.prepareStatement(query);
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			// select 쿼리문을 실행한 후 ResultSet으로 반환받는다.
			rs = psmt.executeQuery();
			System.out.println(query);
			
			// 반환된 ResultSet객체를 통해 회원정보가 있는지 확인한다.
			if(rs.next()) {
				// 정보가 있다면 DTD객체에 회원정보를 저장한다.
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString(3));
				dto.setPhone(rs.getString(4));
				dto.setEmail(rs.getString(5));
				dto.setGender(rs.getString(6));
				System.out.println(dto.toString());
			}
			System.out.println(dto.toString());
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		// 호출한 지점으로 DTO객체를 반환한다. 
		return dto;
	}
	
	public PJMemberDTO selectInfo(String id) 
	{
		PJMemberDTO dto = new PJMemberDTO();
		
	String query = "SELECT * FROM pjmember WHERE id=?";
		try
		{
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			
			if(rs.next()) 
			{
				dto.setId(rs.getString(1));
				dto.setPass(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setPhone(rs.getString(4));
				dto.setEmail(rs.getString(5));
				dto.setGender(rs.getString(6));
			}
		}
		catch (Exception e) {
			System.out.println("정보확인 중 예외 발생");
			e.printStackTrace();
		}
		return dto;
	}
	
	public int editMember(PJMemberDTO dto) {
		int result = 0;
		
		try {
			// 특정 일련번호에 해당하는 게시물을 수정한다.
			String query = "UPDATE pjmember SET "
						 + " name=?, phone=?, email=?, gender=?"
						 + " WHERE id=? ";
			psmt = con.prepareStatement(query);
			// 인파라미터 설정하기
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getPhone());
			psmt.setString(3, dto.getEmail());
			psmt.setString(4, dto.getGender());
			psmt.setString(5, dto.getId());
			System.out.println(dto.toString());
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("게시물 수정 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	
	public int deleteMember(PJMemberDTO dto) {
		int result = 0;
		
		try {
			String query = "DELETE FROM pjmember WHERE id=?";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getId());
			
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("회원탈퇴중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	public int selectMember(Map<String, Object> map) {
		int totalCount = 0;
		// 만약 검색어가 있다면 조건에 맞는 게시물을 카운트 해야 하므로
		// 조건부 (where)로 쿼리문을 추가한다.
		String query = "SELECT COUNT(*) FROM pjmember";
		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " "
				   + " LIKE '%" + map.get("searchWord") + "%'";
		}
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			totalCount = rs.getInt(1);
		}
		catch (Exception e) {
			System.out.println("게시물 카운트 중 예외 발생");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	// 멤버조회
	public List<PJMemberDTO> selectList(Map<String, Object> map){
		
		List<PJMemberDTO> bbs = new Vector<PJMemberDTO>();
		/*
		 	검색조건에 일치하는 게시물을 얻어온 후 각페이지에 출력할
		 	구간까지 설정한 서브 쿼리문 작성
		*/
		String query = "SELECT * FROM ( "
				+ "   SELECT Tb.*, ROWNUM rNum FROM ("
				+ "       SELECT * FROM pjmember ";
		
		// 검색어가 있는 경우에만 where을 추가한다.
		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField")
			+ " LIKE '%" + map.get("searchWord") + "%'";
		}
		// between을 통해 게시물의 구간을 결정할 수 있다.
		query += " ORDER BY id DESC "
				+ " ) Tb "
				+ " ) "
				+ " WHERE rNum BETWEEN ? AND ?";
		
		/*
		 	between절 대신 비교연산자를 통해 쿼리문을 구성할수도 있다.
		 	=> where rNum=? and rNum<=?
		 */
		try {
			// 인파라미터가 있는 쿼리문이므로 prepared객체를 생성한다.
			psmt = con.prepareStatement(query);
			// 인파라미터를 설정한다. 구간의 시작과 끝을 계산한 값이다.
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			// 쿼리문을 실행하고 결과레코드를 ResultSet으로 반환받는다.
			rs = psmt.executeQuery();
			// 결과레코드의 갯수만큼 반복하여 List컬렉션에 저장한다.
			while(rs.next()) {
				PJMemberDTO dto = new PJMemberDTO();
				
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString("name"));
				dto.setPhone(rs.getString("phone"));
				dto.setEmail(rs.getString("email"));
				dto.setGender(rs.getString("gender"));
				
				bbs.add(dto);
			}
		}
		catch (Exception e) {
			System.out.println("회원 조회 중 예외 발생");
			e.printStackTrace();
		}
		return bbs;
	}
	
	public PJMemberDTO MemberView(String id) {
		// 레코드 저장을 위해 dto객체를 생성한다.
		PJMemberDTO dto = new PJMemberDTO();
		// 쿼리문 작성 후 인파라미터를 설정하고 실행한다.
		String query = "SELECT * FROM pjmember WHERE id=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			// 하나의 게시물이므로 if문을 통해 next()함수를 실행한다. 
			if (rs.next()) {
				// 인출한 게시물이 있다면 DTO객체에 저장한다.
				dto.setId(rs.getString(1));
				dto.setPass(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setPhone(rs.getString(4));
				dto.setEmail(rs.getString(5));
				dto.setGender(rs.getString(6));
				
			}
		}
		catch (Exception e) {
			System.out.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		return dto;
	}
	
	public int deleteMember2(PJMemberDTO dto) {
		int result = 0;
		
		try {
			// 인파라미터가 있는 delete 쿼리문 작성
			String query = "DELETE FROM pjmember WHERE id=?";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getId());
			
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("회원 삭제 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	
}
