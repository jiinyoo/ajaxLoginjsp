package login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Login {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;

	public Login() throws Exception {

		Class.forName("com.mysql.jdbc.Driver"); // 라이브러리를 찾아라
		String db = "jdbc:mysql://localhost:3306/second";
		conn = DriverManager.getConnection(db, "root", "1234");
	}

	public void useridCheck(HttpServletRequest request) throws Exception {
		String userid = request.getParameter("userid");
		String sql = "select count(*) as cnt from member where userid=?";

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		rs = pstmt.executeQuery();
		rs.next();
		rs.getBoolean("cnt");
		if (rs.getBoolean("cnt")) {
			request.setAttribute("cnt", "1");

		} else {
			request.setAttribute("cnt", "0");
		}

	}

	public void emailCheck(HttpServletRequest request) throws Exception {
		String email = request.getParameter("email");

		String sql = "select count(*) as cnt from member where email=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, email);
		ResultSet rs = pstmt.executeQuery();
		rs.next();

		if (rs.getBoolean("cnt")) {
			request.setAttribute("cnt", "1");
		} else {
			request.setAttribute("cnt", "0");
		}
		;

	}

	public void memberOk(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {

		request.setCharacterEncoding("utf-8");
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd1");
		String email = request.getParameter("email");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");

		String sql = "insert into member(userid, pwd, email, name, phone,writeday) values(?,?,?,?,?,now())";

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		pstmt.setString(2, pwd);
		pstmt.setString(3, email);
		pstmt.setString(4, name);
		pstmt.setString(5, phone);

		pstmt.executeUpdate();

		String sql2 = "select count(*) as cnt,name,userid from member where userid=?";
		PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		pstmt2.setString(1, userid);
		ResultSet rs = pstmt2.executeQuery();
		rs.next();

		if (rs.getBoolean("cnt")) {
			session.setAttribute("userid", rs.getString("userid"));
			session.setAttribute("name", rs.getString("name"));
			response.sendRedirect("index.jsp");
		} else {
			response.sendRedirect("login.jsp");
		}
		;

		pstmt.close();
		pstmt2.close();
		conn.close();

	}

	public void login(HttpServletRequest request)
	{
		String cnt=request.getParameter("cnt");
		request.setAttribute("cnt", cnt);
	}
	
	
	public void loginOk(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");

		String sql = "select count(*) as cnt, name from member where userid=? and pwd=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		pstmt.setString(2, pwd);

		
		ResultSet rs = pstmt.executeQuery();
		rs.next();

		if (rs.getBoolean("cnt")) {
			session.setAttribute("userid", userid);
			session.setAttribute("name", rs.getString("name"));

			response.sendRedirect("index.jsp");
		} else {
			response.sendRedirect("login.jsp");
			request.setAttribute("cnt", "0");

		}

	}

 
	  public void loginCheck(HttpServletRequest request) throws Exception { 
		  String userid=request.getParameter("userid"); 
		  String pwd=request.getParameter("pwd");
		  
		  String sql = "select count(*) as cnt, name from member where userid=? and pwd=?";
		  pstmt = conn.prepareStatement(sql);
		  pstmt.setString(1, userid);
		  pstmt.setString(2, pwd);
		  
		  ResultSet rs = pstmt.executeQuery();
		  rs.next();
		  String cnt=rs.getString("cnt");
		  request.setAttribute("cnt", cnt);
		  
	  }
	  
	  
	  public void logout(HttpServletResponse response, HttpSession session) throws Exception {
		  session.invalidate();
		  response.sendRedirect("index.jsp");
	  }
	 
	  
	  
	  public void memberView(HttpServletRequest request, HttpSession session, HttpServletResponse response) throws Exception
	  {
		  if(session.getAttribute("userid")!=null) {
			  String userid=session.getAttribute("userid").toString();
			  String sql="select * from member where userid=?";
			  pstmt=conn.prepareStatement(sql);
			  pstmt.setString(1, userid);
			  rs=pstmt.executeQuery();
			  rs.next();
			  memberDto mdto = new memberDto();
			  mdto.setUserid(rs.getString("userid"));
			  mdto.setEmail(rs.getString("email"));
			  mdto.setName(rs.getString("name"));
			  mdto.setPhone(rs.getString("phone"));
			  mdto.setPwd(rs.getString("pwd"));
			  mdto.setWriteday(rs.getString("writeday"));
			  
			  request.setAttribute("mdto", mdto);
			 
			  
		  }else {
			  response.sendRedirect("login.jsp");
		  }
	  }

}
