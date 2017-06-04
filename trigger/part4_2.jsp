<html>

<body>
    <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="tmenu.html" />
            </td>
            <td>

            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>
    
            <%-- -------- Open Connection Code -------- --%>
            <%
                try {
                    // Load Oracle Driver class file
                    DriverManager.registerDriver
                        (new org.postgresql.Driver());
    
                    // Make a connection to the Oracle datasource "cse132b"
                    Connection conn = DriverManager.getConnection(
                        "jdbc:postgresql:cse132b",
                        "jeff", "snowman2"
                    );

            %>

            <%-- HTML form insert code --%>
            <b>Check for enrollment limit on insert</b>
            <table border="1">
                <tr>
                    <th>Student ID</th>
                    <th>Section ID</th>
                    <th>Units</th>
                    <th>Grade Type</th>
                </tr>

                <tr>
                    <form action="part4_2.jsp">
                        <th><input value ="" name="student id" size="10"></th>
                        <th><input value ="" name="section id" size="10"></th>
                        <th><input value ="" name="units" size="10"></th>
                        <th><input value ="" name="grade" size="10"></th>
                        <th><input type="submit" value="Submit">
                    </form>
                </tr>
            </table>

            <%
                PreparedStatement pstmt = conn.prepareStatement(
                    "INSERT INTO enrolled_student " +
                    "VALUES (?,?,?,?)"
                );
                pstmt.setInt(1, Integer.parseInt(request.getParameter("student id")));
                pstmt.setInt(2, Integer.parseInt(request.getParameter("section id")));
                pstmt.setString(3, request.getParameter("units"));
                pstmt.setString(4, request.getParameter("grade"));
                ResultSet rs = pstmt.executeQuery();
                while(rs.next())
                    out.println(rs.getString(1));
            %>

            <%-- -------- Close Connection Code -------- --%>
            <%
                // Close the Connection
                    conn.close();
                } catch (SQLException sqle) {
                    out.println(sqle.getMessage());
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
                </table>
            </td>
        </tr>
    </table>
</body>

</html>
