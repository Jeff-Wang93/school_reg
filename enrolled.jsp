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
                    String enrolled_action = request.getParameter("enrolled_action");
                    // Check if an insertion is requested
                    if (enrolled_action != null && enrolled_action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO enrolled_student VALUES (?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("student ID")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("classes ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (enrolled_action != null && enrolled_action.equals("enrolled_update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE enrolled_student SET classes_id = ? WHERE student_id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("classes ID")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("student ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (enrolled_action != null && enrolled_action.equals("enrolled_delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM enrolled_student WHERE student_id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("student ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement enrolled_statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = enrolled_statement.executeQuery
                        ("SELECT * FROM enrolled_student");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Student ID</th>
                        <th>Classes ID</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="enrolled.jsp" method="get">
                            <input type="hidden" value="enrolled_insert" name="enrolled_action">
                            <th><input value="" name="student ID" size="10"></th>
                            <th><input value="" name="classes ID" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="enrolled.jsp" method="get">
                            <input type="hidden" value="enrolled_update" name="enrolled_action">

                            <td>
                                <input value="<%= rs.getInt("student_id") %>" 
                                    name="student ID" size="10">
                            </td>
    
                            <td>
                                <input value="<%= rs.getInt("classes_id") %>" 
                                    name="classes ID" size="20">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="enrolled.jsp" method="get">
                            <input type="hidden" value="enrolled_delete" name="enrolled_action">
                            <input type="hidden" 
                                value="<%= rs.getInt("student_id") %>" name="student ID">
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Delete">
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
                    enrolled_statement.close();
    
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
