<html>

<body>
    <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu.html" />
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
                    Connection conn = DriverManager.getConnection
                        ("jdbc:postgresql:cse132b", 
                            "jeff", "snowman2");

            %>

            <%-- -------- INSERT Code -------- --%>
            <%
                    String classes_action = request.getParameter("classes_action");
                    // Check if an insertion is requested
                    if (classes_action != null && classes_action.equals("classes_insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO classes VALUES (?,?,?,?,?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("classes ID")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("classes LIMIT")));
                        pstmt.setString(3, request.getParameter("classes QUARTER"));
                        pstmt.setString(4, request.getParameter("classes YEAR"));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("course ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (classes_action != null && classes_action.equals("classes_update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE classes SET classes_enrollment_limit = ?," +
                            "classes_quarter = ?," + 
                            "classes_year = ?, course_id = ? WHERE classes_id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("classes LIMIT")));
                        pstmt.setString(2, request.getParameter("classes QUARTER"));
                        pstmt.setString(3, request.getParameter("classes YEAR"));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("course ID")));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("classes ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (classes_action != null && classes_action.equals("classes_delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM classes WHERE classes_id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("classes ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement classes_statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = classes_statement.executeQuery
                        ("SELECT * FROM classes");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>classes ID</th>
                        <th>classes Enrollment Limit</th>
                        <th>classes Quarter</th>
                        <th>classes Year</th>
                        <th>course ID</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="classes_insert" name="classes_action">
                            <th><input value="" name="classes ID" size="10"></th>
                            <th><input value="" name="classes LIMIT"  size="20"></th>
                            <th><input value="" name="classes QUARTER"  size="10"></th>
                            <th><input value="" name="classes YEAR"  size="10"></th>
                            <th><input value="" name="course  ID"  size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="classes_update" name="classes_action">

                            <td>
                                <input value="<%= rs.getInt("classes_id") %>" 
                                    name="classes ID" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getInt("classes_enrollment_limit") %>" 
                                    name="classes LIMIT" size="20">
                            </td>

    
                            <td>
                                <input value="<%= rs.getString("classes_quarter") %>" 
                                    name="classes QUARTER" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("classes_year") %>" 
                                    name="classes YEAR" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getInt("course_id") %>" 
                                    name="course ID" size="10">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="classes_Update">
                            </td>
                        </form>
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="classes_delete" name="classes_action">
                            <input type="hidden" 
                                value="<%= rs.getInt("classes_id") %>" name="classes ID">
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="classes_Delete">
                            </td>
                        </form>
                    </tr>
            <%
                    }
            %>

            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    rs.close();
    
                    // Close the Statement
                    classes_statement.close();
    
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
