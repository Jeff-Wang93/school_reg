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
                    String discussion_action = request.getParameter("discussion_action");
                    // Check if an insertion is requested
                    if (discussion_action != null && discussion_action.equals("discussion_insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO discussion_info VALUES (?,?,?,?,?,?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("discussion ID")));
                        pstmt.setString(2, request.getParameter("discussion TIME"));
                        pstmt.setString(3, request.getParameter("discussion DATE"));
                        pstmt.setString(4, request.getParameter("discussion LOCATION"));
                        pstmt.setString(5, request.getParameter("discussion MANDATORY"));
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
                    if (discussion_action != null && discussion_action.equals("discussion_update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE discussion_info SET discussion_info_time = ?," +
                            "discussion_info_date = ?," + 
                            "discussion_info_location = ?, discussion_info_mandatory = ?," +
                            "classes_id = ? WHERE discussion_info_id = ?");

                        pstmt.setString(1, request.getParameter("discussion TIME"));
                        pstmt.setString(2, request.getParameter("discussion DATE"));
                        pstmt.setString(3, request.getParameter("discussion LOCATION"));
                        pstmt.setString(4, request.getParameter("discussion MANDATORY"));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("CLASS ID")));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("discussion ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (discussion_action != null && discussion_action.equals("discussion_delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM discussion_info WHERE discussion_info_id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("discussion ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement discussion_statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = discussion_statement.executeQuery
                        ("SELECT * FROM discussion_info");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>discussion ID</th>
                        <th>discussion Time</th>
                        <th>discussion Date</th>
                        <th>discussion Location</th>
                        <th>discussion Mandatory</th>
                        <th>Class ID</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="discussion.jsp" method="get">
                            <input type="hidden" value="discussion_insert" name="discussion_action">
                            <th><input value="" name="discussion ID" size="10"></th>
                            <th><input value="" name="discussion TIME"  size="10"></th>
                            <th><input value="" name="discussion DATE"  size="10"></th>
                            <th><input value="" name="discussion LOCATION"  size="10"></th>
                            <th><input value="" name="discussion MANDATORY"  size="12"></th>
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
                        <form action="discussion.jsp" method="get">
                            <input type="hidden" value="discussion_update" name="discussion_action">

                            <td>
                                <input value="<%= rs.getInt("discussion_info_id") %>" 
                                    name="discussion ID" size="10">
                            </td>
    
                            <td>
                                <input value="<%= rs.getString("discussion_info_time") %>" 
                                    name="discussion TIME" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("discussion_info_date") %>" 
                                    name="discussion DATE" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("discussion_info_location") %>" 
                                    name="discussion LOCATION" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("discussion_info_mandatory") %>" 
                                    name="discussion MANDATORY" size="12">
                            </td>

                            <td>
                                <input value="<%= rs.getInt("classes_id") %>" 
                                    name="CLASS ID" size="10">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="discussion_Update">
                            </td>
                        </form>
                        <form action="discussion.jsp" method="get">
                            <input type="hidden" value="discussion_delete" name="discussion_action">
                            <input type="hidden" 
                                value="<%= rs.getInt("discussion_info_id") %>" name="discussion ID">
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="discussion_Delete">
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
                    discussion_statement.close();
    
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
