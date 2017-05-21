<html>

<body>
    <table border="1">
        <tr>
            <td valign="center">
                <%-- -------- Include menu HTML code -------- --%>
                Probation Entry
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
                    String pro_action = request.getParameter("pro_action");
                    // Check if an insertion is requested
                    if (pro_action != null && pro_action.equals("pro_insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO  probation VALUES (?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("student ID")));
                        pstmt.setString(2, request.getParameter("start"));
                        pstmt.setString(3, request.getParameter("end"));
                        pstmt.setString(4, request.getParameter("description"));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (pro_action != null && pro_action.equals("pro_update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE probation SET probation_description = ?" +
                            "WHERE probation_start = ? AND probation_student_id = ?"); 

                        pstmt.setString(1, request.getParameter("description"));
                        pstmt.setString(2, request.getParameter("start"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("student ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (pro_action != null && pro_action.equals("pro_delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM probation WHERE probation_start = ?" + 
                            "AND probation_student_id = ?");

                        pstmt.setString(1, request.getParameter("start"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("student ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement req_statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = req_statement.executeQuery
                        ("SELECT * FROM probation");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Student ID</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Description</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="prereq.jsp" method="get">
                            <input type="hidden" value="pro_insert" name="pro_action">
                            <th><input value="" name="student ID" size="10"></th>
                            <th><input value="" name="start" size="10"></th>
                            <th><input value="" name="end" size="10"></th>
                            <th><input value="" name="description" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="prereq.jsp" method="get">
                            <input type="hidden" value="pro_update" name="pro_action">

                            <%-- Get the DEPARTMENT ID, which is a INTEGER --%>
                            <td>
                                <input value="<%= rs.getInt("probation_student_id") %>" 
                                    name="student ID" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("probation_start") %>" 
                                    name="start" size="10">
                            </td>
    
                            <%-- Get the DEPARTMENT TITLE --%>
                            <td>
                                <input value="<%= rs.getString("probation_end") %>" 
                                    name="end" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("probation_description") %>" 
                                    name="description" size="10">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="prereq.jsp" method="get">
                            <input type="hidden" value="pro_delete" name="pro_action">
                            <input type="hidden" 
                                value="<%= rs.getInt("probation_student_id") %>" name="student ID">
                            <input type="hidden" 
                                value="<%= rs.getInt("probation_start") %>" name="start">

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
                    req_statement.close();
    
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
