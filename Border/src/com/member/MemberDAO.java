package com.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	private static MemberDAO instance = new MemberDAO();
	ArrayList<Member> arr ;
	public static MemberDAO getInstance(){
		return instance;
	}
	private Connection getConnection() throws Exception{
		Context initContext = new InitialContext();
		Context envContext = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/jsp");
		return ds.getConnection();
	}

	 String url,id,pwd;
	 
	public MemberDAO() {
		try {
		         Class.forName("oracle.jdbc.driver.OracleDriver");
		         url ="jdbc:oracle:thin:@localhost:1521:xe";
		         id = "scott";
		         pwd = "TIGER";
		      } 
		      catch (ClassNotFoundException e) {
		         e.printStackTrace();
		      }
		}
	public String idcheck(String id) {
		Connection con =null;
		Statement st = null;
		ResultSet rs = null;
		String check="ok";
			try {
				con = getConnection();
				st = con.createStatement();
				String sql = "select * from memberDB where userid='"+id+"'";
				rs = st.executeQuery(sql);
				if(rs.next()) {
					check="no";
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeCon(con, st,rs);
			}
			System.out.println(check);
			return check.trim();
	}
	public void memberInsert(Member mb) {
		Connection con= null;
		PreparedStatement ps =  null;
			try {
				con = getConnection();
				String sql = "Insert into memberDB values (?,?,?,?,?,?,?,?)";
				ps = con.prepareStatement(sql);
				ps.setString(1,mb.getName());
				ps.setString(2, mb.getUserid());
				ps.setString(3, mb.getPwd());
				ps.setString(4, mb.getEmail());
				ps.setString(5, mb.getPhone());
				ps.setInt(6, mb.getAdmin());
				ps.setString(7, mb.getZipcode());
				ps.setString(8, mb.getAddr());
				ps.executeUpdate();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeCon(con,ps);
			}
			
	}
	public void memberDelete(Member mb) {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			con = getConnection();
			String sql = "Delete from memberdb where userid=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, mb.getUserid());
			ps.executeUpdate();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			closeCon(con,ps);
		}
	}
	public void memberUpdate(Member mb) {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			con = getConnection();
			String sql = "Update memberdb set name=?,pwd=?,email=?,phone=?,admin=?,zipcode=?,addr=? where userid='"+mb.getUserid()+"'";
			ps = con.prepareStatement(sql);
			ps.setString(1,mb.getName());
			ps.setString(2, mb.getPwd());
			ps.setString(3, mb.getEmail());
			ps.setString(4, mb.getPhone());
			ps.setInt(5, mb.getAdmin());
			ps.setString(6, mb.getZipcode());
			ps.setString(7, mb.getAddr());
			ps.executeUpdate();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			closeCon(con,ps);
		}
	
	}
	public Member memberView(String userid) {
		Connection con =null;
		Statement st = null;
		ResultSet rs = null;
		Member mb=null;
			try {
				con = getConnection();
				st = con.createStatement();
				String sql = "select * from memberdb where userid='"+userid+"'";
				rs = st.executeQuery(sql);
				if (rs.next()) {
					mb = new Member();
					mb.setName(rs.getString("name"));
					mb.setUserid(rs.getString("userid"));
					mb.setPwd(rs.getString("pwd"));
					mb.setEmail(rs.getString("email"));
					mb.setPhone(rs.getString("phone"));
					mb.setAdmin(rs.getInt("admin"));
					mb.setZipcode(rs.getString("zipcode"));
					mb.setAddr(rs.getString("addr"));
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeCon(con, st,rs);
			}
			return mb;
		}
	public ArrayList<Member> memberSearch(String selsch, String textsch){
		Connection con = null;
		Statement st = null;
		ResultSet rs =null;
		arr = new ArrayList<>();
		try {
			con = getConnection();
			st = con.createStatement();
			String sql="";
			if(textsch=="1"||textsch=="2") {
				int num= Integer.parseInt(textsch);
					sql = "select * from memberdb where " +selsch+"="+num;
				}else {
					sql = "select * from memberdb where " +selsch+" like '%"+textsch+"%'";
				}
			rs = st.executeQuery(sql);
			while (rs.next()) {
				Member mb = new Member();
				mb.setName(rs.getString("name"));
				mb.setUserid(rs.getString("userid"));
				mb.setPwd(rs.getString("pwd"));
				mb.setEmail(rs.getString("email"));
				mb.setPhone(rs.getString("phone"));
				mb.setAdmin(rs.getInt("admin"));
				mb.setZipcode(rs.getString("zipcode"));
				mb.setAddr(rs.getString("addr"));
				arr.add(mb);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeCon(con, st,rs);
		}
		return arr;
	}
	public ArrayList<Member> memberList(){
		Connection con = null;
		Statement st = null;
		ResultSet rs =null;
		arr = new ArrayList<>();
		try {
			con = getConnection();
			st = con.createStatement();
			String sql = "select * from memberdb";
			rs = st.executeQuery(sql);
			while (rs.next()) {
				Member mb = new Member();
				mb.setName(rs.getString("name"));
				mb.setUserid(rs.getString("userid"));
				mb.setPwd(rs.getString("pwd"));
				mb.setEmail(rs.getString("email"));
				mb.setPhone(rs.getString("phone"));
				mb.setAdmin(rs.getInt("admin"));
				mb.setZipcode(rs.getString("zipcode"));
				mb.setAddr(rs.getString("addr"));
				arr.add(mb);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeCon(con, st,rs);
		}
		return arr;
	}
	public HashMap<String,String> gethm(){
		Connection con = null;
		Statement st = null;
		ResultSet rs =null;
		HashMap<String, String> hm = new HashMap<String, String>();
		arr = new ArrayList<>();
		try {
			con = getConnection();
			st = con.createStatement();
			String sql = "select * from memberdb";
			rs = st.executeQuery(sql);
			while (rs.next()) {	
				hm.put(rs.getString("userid"),rs.getString("pwd"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeCon(con, st,rs);
		}
		return hm;
	}
	public int AdminCheck(String userid) {
		int admin =0;
		Connection con = null;
		Statement st = null;
		ResultSet rs =null;
		HashMap<String, String> hm = new HashMap<String, String>();
		arr = new ArrayList<>();
		try {
			con = getConnection();
			st = con.createStatement();
			String sql = "select admin from memberdb where userid='"+userid+"'";
			rs = st.executeQuery(sql);
			if (rs.next()) {	
				admin =rs.getInt("admin");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeCon(con, st,rs);
		}
		return admin;
	}
	public int userCheck(String userid, String pwd) {
		HashMap<String, String> hm= gethm();
		int result=0;
		if(hm.containsKey(userid)){
			if(hm.get(userid).equals(pwd)) {
				result=1;
			}else {result=0;}
		}else{
			result=-1;
		}
		return result;
	}
	public int membercnt() {
		return arr.size();
	}
	private void closeCon(Connection con, PreparedStatement ps){
		
		try {
			if(con!=null)con.close();
			if(ps!=null)ps.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
}
private void closeCon(Connection con,Statement st, ResultSet rs){
	
	try {
		if(con!=null)con.close();
		if(st!=null)st.close();
		if(rs!=null)rs.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
}
	

}
