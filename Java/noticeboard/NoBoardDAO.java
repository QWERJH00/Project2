package noticeboard;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBConnect;
import pjboard.PJBoardDTO;

public class NoBoardDAO extends JDBConnect {
	
	public NoBoardDAO(ServletContext application) {
		super(application);
	}
	
	// 게시물의 갯수를 카운트한다.
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
		// 만약 검색어가 있다면 조건에 맞는 게시물을 카운트 해야 하므로
		// 조건부 (where)로 쿼리문을 추가한다.
		String query = "SELECT COUNT(*) FROM noticeboard";
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
		
	// 페이징 기능 추가
		public List<NoBoardDTO> selectList(Map<String, Object> map){
			
			List<NoBoardDTO> bbs = new Vector<NoBoardDTO>();
			/*
			 	검색조건에 일치하는 게시물을 얻어온 후 각페이지에 출력할
			 	구간까지 설정한 서브 쿼리문 작성
			*/
			String query = "SELECT * FROM ( "
					+ "   SELECT Tb.*, ROWNUM rNum FROM ("
					+ "       SELECT * FROM noticeboard ";
			
			// 검색어가 있는 경우에만 where을 추가한다.
			if (map.get("searchWord") != null) {
				query += " WHERE " + map.get("searchField")
				+ " LIKE '%" + map.get("searchWord") + "%'";
			}
			// between을 통해 게시물의 구간을 결정할 수 있다.
			query += " ORDER BY num DESC "
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
					NoBoardDTO dto = new NoBoardDTO();
					
					dto.setNum(rs.getString("num"));
					dto.setId(rs.getString("id"));
					dto.setTitle(rs.getString("title"));
					dto.setContent(rs.getString("content"));
					dto.setPostdate(rs.getDate("postdate"));
					dto.setOfile(rs.getString("ofile"));
					dto.setSfile(rs.getString("sfile"));
					dto.setDowncount(rs.getInt("downcount"));
					dto.setVisitcount(rs.getInt("visitcount"));
					
					bbs.add(dto);
				}
			}
			catch (Exception e) {
				System.out.println("게시물 조회 중 예외 발생");
				e.printStackTrace();
			}
			return bbs;
		}
	
		public int insertWrite(NoBoardDTO dto) {
			int result = 0;
			
			try {
				/*
				 	인파라미터가 있는 동적쿼리문으로 insert문 작성
				 	게시물의 일련번호는 시퀀스를 통해서 자동부여받고,
				 	조회수의 경우에는 0을 입력한다.
				*/
				String query = "INSERT INTO noticeboard ( "
						+ " num, id, title, content, ofile, sfile) "
						+ " VALUES ( "
						+ " seq_board_num.NEXTVAL, ?, ?, ?, ?, ?)";
				
				// 동적쿼리문이므로 prepared객체를 통해 인파라미터를 채워준다.
				psmt = con.prepareStatement(query);
				psmt.setString(1, dto.getId());
				psmt.setString(2, dto.getTitle());
				psmt.setString(3, dto.getContent());
				psmt.setString(4, dto.getOfile());
				psmt.setString(5, dto.getSfile());
				// insert로 실행하여 입력된 행의 갯수를 반환한다.
				result = psmt.executeUpdate();
			}
			catch (Exception e) {
				System.out.println("게시물 입력 중 예외 발생");
				e.printStackTrace();
			}
			return result;
		}
		
		public NoBoardDTO selectView(String num) {
			// 레코드 저장을 위해 dto객체를 생성한다.
			NoBoardDTO dto = new NoBoardDTO();
			// 쿼리문 작성 후 인파라미터를 설정하고 실행한다.
			String query = "SELECT * FROM noticeboard WHERE num=?";
			try {
				psmt = con.prepareStatement(query);
				psmt.setString(1, num);
				rs = psmt.executeQuery();
				// 하나의 게시물이므로 if문을 통해 next()함수를 실행한다. 
				if (rs.next()) {
					// 인출한 게시물이 있다면 DTO객체에 저장한다.
					dto.setNum(rs.getString(1));
					dto.setId(rs.getString(2));
					dto.setTitle(rs.getString(3));
					dto.setContent(rs.getString(4));
					dto.setPostdate(rs.getDate(5));
					dto.setOfile(rs.getString(6));
					dto.setSfile(rs.getString(7));
					dto.setDowncount(rs.getInt(8));;
					dto.setVisitcount(rs.getInt(9));
				}
			}
			catch (Exception e) {
				System.out.println("게시물 상세보기 중 예외 발생");
				e.printStackTrace();
			}
			return dto;
		}
		
		public void updateVisitCount(String num) 
		{

			/*
			 	게시물의 일련번호를 통해 visitcount를 1증가시킨다.
			 	해당 컬럼은 number타입이므로 사칙연산이 가능하다.
			*/
			String query = "UPDATE noticeboard SET "
						 + " visitcount=visitcount+1 "
						 + " WHERE num=?";
			
			try 
			{
				psmt = con.prepareStatement(query);
				psmt.setString(1, num);
				psmt.executeQuery();
			}
			catch (Exception e) {
				System.out.println("게시물 조회수 증가 중 예외 발생");
				e.printStackTrace();
			}
		}
		
		public int updateEdit(NoBoardDTO dto) {
			int result = 0;
			
			try {
				// 특정 일련번호에 해당하는 게시물을 수정한다.
				String query = "UPDATE noticeboard SET "
							 + " title=?, content=?, ofile=?, sfile=? "
							 + " WHERE num=? ";
				psmt = con.prepareStatement(query);
				// 인파라미터 설정하기
				psmt.setString(1, dto.getTitle());
				psmt.setString(2, dto.getContent());
				psmt.setString(3, dto.getOfile());
				psmt.setString(4, dto.getSfile());
				psmt.setString(5, dto.getNum());
				
				result = psmt.executeUpdate();
			}
			catch (Exception e) {
				System.out.println("게시물 수정 중 예외 발생");
				e.printStackTrace();
			}
			return result;
	}
		
		public int deletePost(NoBoardDTO dto) {
			int result = 0;
			
			try {
				// 인파라미터가 있는 delete 쿼리문 작성
				String query = "DELETE FROM noticeboard WHERE num=?";
				
				psmt = con.prepareStatement(query);
				psmt.setString(1, dto.getNum());
				
				result = psmt.executeUpdate();
			}
			catch (Exception e) {
				System.out.println("게시물 삭제 중 예외 발생");
				e.printStackTrace();
			}
			return result;
		}
}

