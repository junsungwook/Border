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
         ResultSet rs = null;
         int number = 1;
         String sql="";
            try {
               con = getConnection();
               //부모글
               int num = b.getNum();
               int ref=b.getRef();
               int re_step=b.getRe_step();
               int re_level=b.getRe_level();
               ps=con.prepareStatement("select max(num) from board");
               rs=ps.executeQuery();
               if(rs.next()) {
            	   number = rs.getInt(1)+1;
               }
               //새글일 때와 답변글을 구분하는 if else
               if(num!=0) { //답변글
            	   sql="update board set re_step = re_step+1 where ref=? and re_step>?";
            	   ps=con.prepareStatement(sql);
            	   ps.setInt(1, ref);
            	   ps.setInt(2, re_step);
            	   ps.executeUpdate();
            	   re_step=re_step+1;
            	   re_level=re_level+1;
               }
               else { //새글일때   writeForm에서 넘긴 값이 있어서 안넘겨도 무방 
            	   ref = number;
            	   re_step=0;
            	   re_level=0;
               }
               sql = "insert into board (num,writer,email,passwd,reg_date,readcount,ref,re_step,re_level,content,ip,subject) values(board_seq.nextval,?,?,?,SYSDATE,0,?,?,?,?,?,?)";
               ps = con.prepareStatement(sql);
               ps.setString(1, b.getWriter());
               ps.setString(2, b.getEmail());
               ps.setString(3, b.getPasswd());
               ps.setInt(4, ref);
               ps.setInt(5, re_step);
               ps.setInt(6, re_level);
               ps.setString(7, b.getContent());
               ps.setString(8, b.getIp());
               ps.setString(9, b.getSubject());
               ps.executeUpdate();
            } catch (Exception e) {
               // TODO Auto-generated catch block
               e.printStackTrace();
            }finally {
               closeCon(con,ps,rs);
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
               sql = "select * from (select rownum rn,aa.* from (select * from board order by ref desc,re_step asc)aa) where rn>=? and rn<=?";
               }else {
                  sql="select * from (select rownum rn,aa.* from (select * from board where "+field+" like '%"+search+"%' order by ref desc,re_step asc)aa) where rn>=? and rn<=?";
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
               b.setContent(rs.getString("content"));
               b.setPasswd(rs.getString("passwd"));
               b.setEmail(rs.getString("email"));
               b.setRef(rs.getInt("ref"));
               b.setRe_step(rs.getInt("re_step"));
               b.setRe_level(rs.getInt("re_level"));
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
	      String sql1="";
	      BoardBean b = null;
	         try {
	        	con=getConnection();
	            sql = "select * from board where num=?";
	            ps = con.prepareStatement(sql);
	            ps.setInt(1, num);
	            rs = ps.executeQuery();
	            if (rs.next()) {
	               b = new BoardBean();
	               b.setNum(rs.getInt("num"));
	               b.setSubject(rs.getString("subject"));
	               b.setWriter(rs.getString("writer"));
	               b.setReg_date(rs.getString("reg_date"));
	               b.setReadcount(rs.getInt("readcount")+1);
	               b.setIp(rs.getString("ip"));
	               b.setContent(rs.getString("content"));
	               b.setPasswd(rs.getString("passwd"));
	               b.setEmail(rs.getString("email"));
	               b.setRef(rs.getInt("ref"));
	               b.setRe_step(rs.getInt("re_step"));
	               b.setRe_level(rs.getInt("re_level"));
	            }
	            sql1 = "update board set readcount=? where num=?";
	           	PreparedStatement ps1 =con.prepareStatement(sql1); 
	           	ps1.setInt(1, b.getReadcount());
	           	ps1.setInt(2, num);
	           	ps1.executeUpdate();
	         } catch (Exception e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	         }finally {
	            closeCon(con,ps,rs);
	         }
	      return b;
	   }
   //댓글 쓰기
   public void commentInsert(CommentBean cb) {
       Connection con= null;
       PreparedStatement ps =  null;
       ResultSet rs = null;
       String sql="";
          try {
             con = getConnection();
             sql = "insert into commentboard (cnum,userid,regdate,msg,bnum) values(cnum_seq.nextval,?,sysdate,?,?)";
             ps = con.prepareStatement(sql);
             ps.setString(1, cb.getUserid());
             ps.setString(2, cb.getMsg());
             ps.setInt(3, cb.getBnum());
             ps.executeUpdate();
          } catch (Exception e) {
             // TODO Auto-generated catch block
             e.printStackTrace();
          }finally {
             closeCon(con,ps,rs);
          }
          
    }
   //댓글 뿌리기
   public ArrayList<CommentBean> commentList(int bnum) {
       Connection con= null;
       PreparedStatement ps =  null;
       ResultSet rs = null;
       ArrayList<CommentBean> arr = new ArrayList<>();
       String sql="";
          try {
             con = getConnection();
             sql = "select * from commentboard where bnum=? order by cnum desc";
             ps = con.prepareStatement(sql);
             ps.setInt(1, bnum);
             rs = ps.executeQuery();
             while(rs.next()) {
            	 CommentBean cb = new CommentBean();
            	 cb.setCnum(rs.getInt("cnum"));
            	 cb.setUserid(rs.getString("userid"));
            	 cb.setRegdate(rs.getString("regdate"));
            	 cb.setMsg(rs.getString("msg"));
            	 cb.setBnum(rs.getInt("bnum")); 
 				 arr.add(cb);
             }
          } catch (Exception e) {
             // TODO Auto-generated catch block
             e.printStackTrace();
          }finally {
             closeCon(con,ps,rs);
          }
          return arr;
          
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
	         } catch (Exception e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	         }finally {
	            closeCon(con,ps,rs);
	         }
			return b;
	   }
   //수정
   public boolean updateBoard(BoardBean bean) {
	      Connection con =null;
	      PreparedStatement ps = null;
	      ResultSet rs = null;
	      Statement st = null;
	      String sql="";
	      boolean b=false;
	         try {
	        	con=getConnection();
	            sql = "select passwd from board where num=?";
	            ps = con.prepareStatement(sql);
	            ps.setInt(1, bean.getNum());
	            rs = ps.executeQuery();
	            if(rs.next()) {
	            	if(rs.getString("passwd").equals(bean.getPasswd())) {
	            		sql = "update board set writer='"+bean.getWriter()+"',email='"+bean.getEmail()+"',content='"+bean.getContent()+"',subject='"+bean.getSubject()+"' where num="+bean.getNum();
	            		st = con.createStatement();
	                    st.executeQuery(sql);
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