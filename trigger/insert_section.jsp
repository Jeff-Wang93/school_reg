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
            <b>Insert Section</b>
            <table border="1">
                <tr>
                    <th>Section ID</th>
                    <th>Course ID</th>
                    <th>Enrollment Limit</th>
                    <th>Action</th>
                </tr>

                <tr>
                    <form action="insert_section.jsp">
                        <th><input value ="" name="section id" size="10"></th>
                        <th><input value ="" name="course id" size="10"></th>
                        <th><input value ="" name="enrollment limit" size="10"></th>
                        <th><input type="submit" value="Insert">
                    </form>
                </tr>
            </table>

            <%
                PreparedStatement pstmt1 = conn.prepareStatement(
                    "INSERT INTO current_quarter " + 
                    "VALUES (?,?,?,?,?,?,?,?,?)"
                );
                pstmt1.setInt(1, Integer.parseInt(request.getParameter("section id")));
                pstmt1.setInt(2, Integer.parseInt(request.getParameter("course id")));
                pstmt1.setString(3, "sp");
                pstmt1.setString(4, "2017");
                pstmt1.setString(5, "DEFAULT");
                pstmt1.setString(6, "DEFAULT");
                pstmt1.setString(7, "DEFAULT");
                pstmt1.setString(8, "DEFAULT");
                pstmt1.setInt(9, Integer.parseInt(request.getParameter("enrollment limit")));
                pstmt1.executeUpdate();
                //rs1.close();
            %>
            
            <%
                PreparedStatement pstmt2 = conn.prepareStatement(
                    "INSERT INTO current_enrollment " + 
                    "VALUES (?, ?, ?)"
                );
                pstmt2.setInt(1, Integer.parseInt(request.getParameter("section id")));
                pstmt2.setInt(2, 0);
                pstmt2.setInt(3, Integer.parseInt(request.getParameter("enrollment limit")));
                pstmt2.executeUpdate();
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
