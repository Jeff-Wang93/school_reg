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
                    String lecture_action = request.getParameter("lecture_action");
                    // Check if an insertion is requested
                    if (lecture_action != null && lecture_action.equals("lecture_insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO lecture_info VALUES (?,?,?,?,?,?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("lecture ID")));
                        pstmt.setString(2, request.getParameter("lecture TIME"));
                        pstmt.setString(3, request.getParameter("lecture DATE"));
                        pstmt.setString(4, request.getParameter("lecture LOCATION"));
                        pstmt.setString(5, request.getParameter("lecture MANDATORY"));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("CLASS ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (lecture_action != null && lecture_action.equals("lecture_update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE lecture_info SET lecture_info_time = ?," +
                            "lecture_info_date = ?," + 
                            "lecture_info_location = ?, lecture_info_mandatory = ?," +
                            "classes_id = ? WHERE lecture_info_id = ?");

                        pstmt.setString(1, request.getParameter("lecture TIME"));
                        pstmt.setString(2, request.getParameter("lecture DATE"));
                        pstmt.setString(3, request.getParameter("lecture LOCATION"));
                        pstmt.setString(4, request.getParameter("lecture MANDATORY"));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("CLASS ID")));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("lecture ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (lecture_action != null && lecture_action.equals("lecture_delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM lecture_info WHERE lecture_info_id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("lecture ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement lecture_statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = lecture_statement.executeQuery
                        ("SELECT * FROM lecture_info");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>lecture ID</th>
                        <th>lecture Time</th>
                        <th>lecture Date</th>
                        <th>lecture Location</th>
                        <th>lecture Mandatory</th>
                        <th>Class ID</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="lecture.jsp" method="get">
                            <input type="hidden" value="lecture_insert" name="lecture_action">
                            <th><input value="" name="lecture ID" size="10"></th>
                            <th><input value="" name="lecture TIME"  size="10"></th>
                            <th><input value="" name="lecture DATE"  size="10"></th>
                            <th><input value="" name="lecture LOCATION"  size="10"></th>
                            <th><input value="" name="lecture MANDATORY"  size="12"></th>
                            <th><input value="" name="CLASS ID"  size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="lecture.jsp" method="get">
                            <input type="hidden" value="lecture_update" name="lecture_action">

                            <td>
                                <input value="<%= rs.getInt("lecture_info_id") %>" 
                                    name="lecture ID" size="10">
                            </td>
    
                            <td>
                                <input value="<%= rs.getString("lecture_info_time") %>" 
                                    name="lecture TIME" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("lecture_info_date") %>" 
                                    name="lecture DATE" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("lecture_info_location") %>" 
                                    name="lecture LOCATION" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("lecture_info_mandatory") %>" 
                                    name="lecture MANDATORY" size="12">
                            </td>

                            <td>
                                <input value="<%= rs.getInt("classes_id") %>" 
                                    name="CLASS ID" size="10">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="lecture_Update">
                            </td>
                        </form>
                        <form action="lecture.jsp" method="get">
                            <input type="hidden" value="lecture_delete" name="lecture_action">
                            <input type="hidden" 
                                value="<%= rs.getInt("lecture_info_id") %>" name="lecture ID">
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="lecture_Delete">
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
                    lecture_statement.close();
    
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
