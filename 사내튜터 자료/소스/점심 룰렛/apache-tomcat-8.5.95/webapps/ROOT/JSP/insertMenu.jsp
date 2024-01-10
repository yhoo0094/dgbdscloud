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
    String menuNm = request.getParameter("menuNm");
    String sql = "INSERT INTO TB_MENU (MENU_NO, MENU_NM) VALUES (?, ?)";
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, menuNo);
    pstmt.setString(2, menuNm);

    int rowsAffected = pstmt.executeUpdate();
    out.println(rowsAffected + " row(s) inserted.");
} catch (ClassNotFoundException | SQLException e) {
    e.printStackTrace();
    out.println("Error: " + e.getMessage());
} finally {
    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
    if (conn != null) try { conn.close(); } catch (SQLException e) {}
}    		
%>