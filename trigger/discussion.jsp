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
            <b>Check for discussion meeting conflicts</b>
            <table border="1">
                <tr>
                    <th>discussion Time</th>
                    <th>discussion Day</th>
                    <th>Section ID</th>
                </tr>

                <tr>
                    <form action="discussion.jsp">
                        <th><input value ="" name="discussion time" size="10"></th>
                        <th><input value ="" name="discussion day" size="10"></th>
                        <th><input value ="" name="section id" size="10"></th>
                        <th><input type="submit" value="Submit">
                    </form>
                </tr>
            </table>

            <%
                PreparedStatement pstmt = conn.prepareStatement(
                    "INSERT INTO discussion_info (discussion_info_time, discussion_info_day, section_id) " +
                    "VALUES (?,?,?)"
                );
                pstmt.setString(1, request.getParameter("discussion time"));
                pstmt.setString(2, request.getParameter("discussion day"));
                pstmt.setInt(3, Integer.parseInt(request.getParameter("section id")));
                ResultSet rs = pstmt.executeQuery();
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
