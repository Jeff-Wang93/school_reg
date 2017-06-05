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
            <b>Check for faculty teaching conflicts</b>
            <table border="1">
                <tr>
                    <th>Faculty Name</th>
                    <th>Section ID</th>
                </tr>

                <tr>
                    <form action="faculty.jsp">
                        <th><input value ="" name="faculty name" size="10"></th>
                        <th><input value ="" name="section id" size="10"></th>
                        <th><input type="submit" value="Submit">
                    </form>
                </tr>
            </table>

            <%
                PreparedStatement get_course_id = conn.prepareStatement(
                    "SELECT course_id " +
                    "FROM current_quarter " + 
                    "WHERE section_number = ? "
                );
                get_course_id.setInt(1, Integer.parseInt(request.getParameter("section id")));
                ResultSet temp = get_course_id.executeQuery();
                temp.next();
                int course_id = temp.getInt(1);

                PreparedStatement pstmt = conn.prepareStatement(
                    "INSERT INTO faculty_teaching VALUES (?,?,?,?,?)"
                );
                pstmt.setString(1, request.getParameter("faculty name"));
                pstmt.setInt(2, course_id);
                pstmt.setInt(3, Integer.parseInt(request.getParameter("section id")));
                pstmt.setString(4, "sp");
                pstmt.setString(5, "2017");
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
