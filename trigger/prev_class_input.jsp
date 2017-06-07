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

            <%
                String action = request.getParameter("action");
                if (action != null && action.equals("prev_insert")) {
                    // begin transaction
                    conn.setAutoCommit(false);

                    PreparedStatement pstmt = conn.prepareStatement(
                        "INSERT INTO previous_class VALUES (?,?,?,?,?,?,?)"
                    );

                    pstmt.setInt(1, Integer.parseInt(request.getParameter("student id")));
                    pstmt.setInt(2, Integer.parseInt(request.getParameter("course id")));
                    pstmt.setString(3, request.getParameter("grade"));
                    pstmt.setString(4, request.getParameter("quarter"));
                    pstmt.setString(5, "2017");
                    pstmt.setString(6, "4");
                    pstmt.setString(7, "Grade");
                    int rowcount = pstmt.executeUpdate();

                    // commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
            %>
            
            <%
                if (action != null && action.equals("prev_update")) {
                    // begin transaction
                    conn.setAutoCommit(false);

                    PreparedStatement pstmt2 = conn.prepareStatement(
                        "UPDATE previous_class SET grade = ? " +
                        "WHERE student_id = ? AND course_id = ? AND quarter = ?"
                    );

                    pstmt2.setString(1, request.getParameter("grade"));
                    pstmt2.setInt(2, Integer.parseInt(request.getParameter("student id")));
                    pstmt2.setInt(3, Integer.parseInt(request.getParameter("course id")));
                    pstmt2.setString(4, request.getParameter("quarter"));
                    int rowcount = pstmt2.executeUpdate();

                    // commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
            %>
            
            <%
                // output the data
                Statement prev_statement = conn.createStatement();
                ResultSet rs = prev_statement.executeQuery(
                    "SELECT * FROM previous_class " 
                );
            %>
            
            <%-- HTML for inserting data --%>
            <table border="1">
                <tr>
                    <th>Student ID</th>
                    <th>Course ID</th>
                    <th>Quarter</th>
                    <th>Grade</th>
                    <th>Action</th>
                </tr>

                <tr>
                    <form action="prev_class_input.jsp" method="get">
                        <input type="hidden" value="prev_insert" name="action">
                        <th><input value="" name="student id" size="10"></th>
                        <th><input value="" name="course id" size="10"></th>
                        <th><input value="" name="quarter" size="10"></th>
                        <th><input value="" name="grade" size="10"></th>
                        <th><input type="submit" value="Insert"></th>
                    </form>
                </tr>

            <% while(rs.next()) { %>
                <tr>
                    <form action="prev_class_input.jsp" method="get">
                        <input type="hidden" value="prev_update" name="action">
                        <td>
                            <input value="<%= rs.getInt("student_id") %>"  
                             name="student id" size="10">
                        </td>
                        <td>
                            <input value="<%= rs.getInt("course_id") %>"  
                             name="course id" size="10">
                        </td>
                        <td>
                            <input value="<%= rs.getString("quarter") %>"  
                             name="quarter" size="10">
                        </td>

                        <td>
                            <input value="<%= rs.getString("grade") %>" 
                             name="grade" size="10">
                        </td>

                        <td>
                            <input type="submit" value="Update">
                        </td>   
                </tr>
            <% } %>

            </table>

            <%-- -------- Close Connection Code -------- --%>
            <%
                // Close the Connection
                    rs.close();
                    prev_statement.close();
                    conn.close();
                } catch (SQLException sqle) {
                    out.println(sqle.getMessage());
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
            
            </td>
        </tr>
    </table>
</body>

</html>
