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
                    String lab_action = request.getParameter("lab_action");
                    // Check if an insertion is requested
                    if (lab_action != null && lab_action.equals("lab_insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO lab_info VALUES (?,?,?,?,?,?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("lab ID")));
                        pstmt.setString(2, request.getParameter("lab TIME"));
                        pstmt.setString(3, request.getParameter("lab DATE"));
                        pstmt.setString(4, request.getParameter("lab LOCATION"));
                        pstmt.setString(5, request.getParameter("lab MANDATORY"));
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
                    if (lab_action != null && lab_action.equals("lab_update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE lab_info SET lab_info_time = ?," +
                            "lab_info_date = ?," + 
                            "lab_info_location = ?, lab_info_mandatory = ?," +
                            "classes_id = ? WHERE lab_info_id = ?");

                        pstmt.setString(1, request.getParameter("lab TIME"));
                        pstmt.setString(2, request.getParameter("lab DATE"));
                        pstmt.setString(3, request.getParameter("lab LOCATION"));
                        pstmt.setString(4, request.getParameter("lab MANDATORY"));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("CLASS ID")));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("lab ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (lab_action != null && lab_action.equals("lab_delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM lab_info WHERE lab_info_id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("lab ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement lab_statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = lab_statement.executeQuery
                        ("SELECT * FROM lab_info");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>lab ID</th>
                        <th>lab Time</th>
                        <th>lab Date</th>
                        <th>lab Location</th>
                        <th>lab Mandatory</th>
                        <th>Class ID</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="lab.jsp" method="get">
                            <input type="hidden" value="lab_insert" name="lab_action">
                            <th><input value="" name="lab ID" size="10"></th>
                            <th><input value="" name="lab TIME"  size="10"></th>
                            <th><input value="" name="lab DATE"  size="10"></th>
                            <th><input value="" name="lab LOCATION"  size="10"></th>
                            <th><input value="" name="lab MANDATORY"  size="12"></th>
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
                        <form action="lab.jsp" method="get">
                            <input type="hidden" value="lab_update" name="lab_action">

                            <td>
                                <input value="<%= rs.getInt("lab_info_id") %>" 
                                    name="lab ID" size="10">
                            </td>
    
                            <td>
                                <input value="<%= rs.getString("lab_info_time") %>" 
                                    name="lab TIME" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("lab_info_date") %>" 
                                    name="lab DATE" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("lab_info_location") %>" 
                                    name="lab LOCATION" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("lab_info_mandatory") %>" 
                                    name="lab MANDATORY" size="12">
                            </td>

                            <td>
                                <input value="<%= rs.getInt("classes_id") %>" 
                                    name="CLASS ID" size="10">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="lab_Update">
                            </td>
                        </form>
                        <form action="lab.jsp" method="get">
                            <input type="hidden" value="lab_delete" name="lab_action">
                            <input type="hidden" 
                                value="<%= rs.getInt("lab_info_id") %>" name="lab ID">
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="lab_Delete">
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
                    lab_statement.close();
    
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
