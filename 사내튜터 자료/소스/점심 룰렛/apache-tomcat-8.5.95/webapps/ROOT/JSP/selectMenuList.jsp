<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, org.json.simple.JSONArray, org.json.simple.JSONObject" %>
<%@ include file="dbConfig.jsp" %>
<%
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

try {
    Class.forName(DBConfig.DRIVER);
    conn = DriverManager.getConnection(DBConfig.URL, DBConfig.USER, DBConfig.PASSWORD);
    stmt = conn.createStatement();

    String sql = "SELECT * FROM TB_MENU";
    rs = stmt.executeQuery(sql);

    JSONArray menuArray = new JSONArray();
    while (rs.next()) {
    	JSONObject menuObject = new JSONObject();
        menuObject.put("MENU_NO", rs.getInt("MENU_NO"));
        menuObject.put("MENU_NM", rs.getString("MENU_NM"));
        menuArray.add(menuObject);
    }
    
    out.print(menuArray.toJSONString());
} catch (ClassNotFoundException | SQLException e) {
    e.printStackTrace();
} finally {
    if (rs != null) try { rs.close(); } catch (SQLException e) {}
    if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
    if (conn != null) try { conn.close(); } catch (SQLException e) {}
}
%>