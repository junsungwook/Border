package com.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class BoardDAO {
   String url,id,pwd;
  private static BoardDAO instance=new BoardDAO();
  
  public static BoardDAO getInstance() {
     return instance;
  }
   private Connection getConnection() throws Exception{
      Context initContext = new InitialContext();
      Context envContext = (Context)initContext.lookup("java:/comp/env");
      DataSource ds = (DataSource)envContext.lookup("jdbc/jsp");
      return ds.getConnection();
   }
   public BoardDAO() {
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
   //추가
   public int size(String field,String word) {
      
      Connection con =null;
      Statement st = null;
      ResultSet rs = null;
      String sql="";
      int cnt =0;
     
         try {
         con = getConnection();
         if(field.equals("")) {
        	 sql = "select count(*) from board";
         }else {
                sql="select count(*) from board where "+field+" like '%"+word+"%'";
          }
         
            st = con.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
               cnt=rs.getInt(1);
            }
         } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         }finally {
            closeCon(con,st,rs);
         }
      return cnt;
}
   public void boardInsert(BoardBean b) {
         Connection con= null;
         PreparedStatement ps =  null;
            try {
               con = getConnection();
               String sql = "insert into board (num, writer,subject, content, passwd,email,ip,reg_date) values (board_seq.nextval,?,?,?,?,?,?,SYSDATE)";
               ps = con.prepareStatement(sql);
               ps.setString(1,b.getWriter());
               ps.setString(2, b.getSubject());
               ps.setString(3, b.getContent());
               ps.setString(4, b.getPasswd());
               ps.setString(5, b.getEmail());
               ps.setString(6, b.getIp());
               ps.executeUpdate();
            } catch (Exception e) {
               // TODO Auto-generated catch block
               e.printStackTrace();
            }finally {
               closeCon(con,ps);
            }
            
      }
   
   //전체보기
   public ArrayList<BoardBean> boardList(String field, String search,int startRow,int endRow) {
      ArrayList<BoardBean> arr =new ArrayList<BoardBean>();
      Connection con =null;
      PreparedStatement ps = null;
      ResultSet rs = null;
      String sql="";
      BoardBean b=null;
         try {
            con = getConnection();
            if(field.equals("")) {
               sql = "select * from (select rownum rn,aa.* from (select * from board order by reg_date desc)aa) where rn>=? and rn<=?";
               }else {
                  sql="select * from (select rownum rn,aa.* from (select * from board where "+field+" like '%"+search+"%' order by reg_date desc)aa) where rn>=? and rn<=?";
               }
            ps = con.prepareStatement(sql);
            ps.setInt(1, startRow);
            ps.setInt(2, endRow);
            rs = ps.executeQuery();
            while (rs.next()) {
               b = new BoardBean();
               b.setNum(rs.getInt("num"));
               b.setSubject(rs.getString("subject"));
               b.setWriter(rs.getString("writer"));
               b.setReg_date(rs.getString("reg_date"));
               b.setReadcount(rs.getInt("readcount"));
               b.setIp(rs.getString("ip"));
               arr.add(b);
            }
         } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         }finally {
            closeCon(con,ps,rs);
         }
      return arr;
   }
   //글 보기
   public BoardBean getBoard(int num) {
	      Connection con =null;
	      PreparedStatement ps = null;
	      ResultSet rs = null;
	      String sql="";
	      BoardBean b=null;
	         try {
	        	con=getConnection();
	            sql = "select * from board where num=?";
	            ps = con.prepareStatement(sql);
	            ps.setInt(1, num);
	            rs = ps.executeQuery();
	            while (rs.next()) {
	               b = new BoardBean();
	               b.setNum(rs.getInt("num"));
	               b.setSubject(rs.getString("subject"));
	               b.setWriter(rs.getString("writer"));
	               b.setReg_date(rs.getString("reg_date"));
	               b.setReadcount(rs.getInt("readcount"));
	               b.setIp(rs.getString("ip"));
	               b.setContent(rs.getString("content"));
	               b.setPasswd(rs.getString("passwd"));
	            }
	         } catch (Exception e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	         }finally {
	            closeCon(con,ps,rs);
	         }
	      return b;
	   }
   public boolean delBoard(int num,String passwd) {
	      Connection con =null;
	      PreparedStatement ps = null;
	      ResultSet rs = null;
	      String sql="";
	      boolean b=false;
	         try {
	        	con=getConnection();
	            sql = "select passwd from board where num=?";
	            ps = con.prepareStatement(sql);
	            ps.setInt(1, num);
	            rs = ps.executeQuery();
	            if(rs.next()) {
	            	if(rs.getString("passwd").equals(passwd)) {
	            		sql = "delete from board where num=?";
		            	 PreparedStatement ps1 =con.prepareStatement(sql); 
		            	 ps1.setInt(1, num);
		            	 ps1.executeUpdate();
		            	 b = true;
	            	}	 
	            }
	            System.out.println("dd:"+sql);
	         } catch (Exception e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	         }finally {
	            closeCon(con,ps,rs);
	         }
			return b;
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