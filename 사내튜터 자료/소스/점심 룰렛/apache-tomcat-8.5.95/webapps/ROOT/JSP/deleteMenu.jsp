<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbConfig.jsp" %>
<%
Connection conn = null;
PreparedStatement pstmt = null;

try {
	Class.forName(DBConfig.DRIVER);
    conn = DriverManager.getConnection(DBConfig.URL, DBConfig.USER, DBConfig.PASSWORD);

    int menuNo = Integer.parseInt(request.getParameter("menuNo"));
    String sql = "DELETE FROM TB_MENU WHERE MENU_NO = ?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, menuNo);

    int rowsAffected = pstmt.executeUpdate();
    out.println(rowsAffected + " row(s) deleted.");
} catch (ClassNotFoundException | SQLException e) {
    e.printStackTrace();
    out.println("Error: " + e.getMessage());
} finally {
    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
    if (conn != null) try { conn.close(); } catch (SQLException e) {}
}    		
%>