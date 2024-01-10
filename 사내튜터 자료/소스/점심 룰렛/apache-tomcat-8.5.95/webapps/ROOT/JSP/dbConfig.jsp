<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%!
public class DBConfig {
    public static final String URL = "jdbc:mysql://[DB엔드 포인트]:3306/LCR";
    public static final String USER = "admin";
    public static final String PASSWORD = "1234";
    public static final String DRIVER = "com.mysql.cj.jdbc.Driver";
}
%>