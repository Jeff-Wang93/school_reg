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
                    String review_action = request.getParameter("review_action");
                    // Check if an insertion is requested
                    if (review_action != null && review_action.equals("review_insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO review_info VALUES (?,?,?,?,?,?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("review ID")));
                        pstmt.setString(2, request.getParameter("review TIME"));
                        pstmt.setString(3, request.getParameter("review DATE"));
                        pstmt.setString(4, request.getParameter("review LOCATION"));
                        pstmt.setString(5, request.getParameter("review MANDATORY"));
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
                    if (review_action != null && review_action.equals("review_update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE review_info SET review_info_time = ?," +
                            "review_info_date = ?," + 
                            "review_info_location = ?, review_info_mandatory = ?," +
                            "classes_id = ? WHERE review_info_id = ?");

                        pstmt.setString(1, request.getParameter("review TIME"));
                        pstmt.setString(2, request.getParameter("review DATE"));
                        pstmt.setString(3, request.getParameter("review LOCATION"));
                        pstmt.setString(4, request.getParameter("review MANDATORY"));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("CLASS ID")));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("review ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (review_action != null && review_action.equals("review_delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM review_info WHERE review_info_id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("review ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement review_statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = review_statement.executeQuery
                        ("SELECT * FROM review_info");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>review ID</th>
                        <th>review Time</th>
                        <th>review Date</th>
                        <th>review Location</th>
                        <th>review Mandatory</th>
                        <th>Class ID</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="review.jsp" method="get">
                            <input type="hidden" value="review_insert" name="review_action">
                            <th><input value="" name="review ID" size="10"></th>
                            <th><input value="" name="review TIME"  size="10"></th>
                            <th><input value="" name="review DATE"  size="10"></th>
                            <th><input value="" name="review LOCATION"  size="10"></th>
                            <th><input value="" name="review MANDATORY"  size="12"></th>
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
                        <form action="review.jsp" method="get">
                            <input type="hidden" value="review_update" name="review_action">

                            <td>
                                <input value="<%= rs.getInt("review_info_id") %>" 
                                    name="review ID" size="10">
                            </td>
    
                            <td>
                                <input value="<%= rs.getString("review_info_time") %>" 
                                    name="review TIME" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("review_info_date") %>" 
                                    name="review DATE" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("review_info_location") %>" 
                                    name="review LOCATION" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("review_info_mandatory") %>" 
                                    name="review MANDATORY" size="12">
                            </td>

                            <td>
                                <input value="<%= rs.getInt("classes_id") %>" 
                                    name="CLASS ID" size="10">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="review_Update">
                            </td>
                        </form>
                        <form action="review.jsp" method="get">
                            <input type="hidden" value="review_delete" name="review_action">
                            <input type="hidden" 
                                value="<%= rs.getInt("review_info_id") %>" name="review ID">
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="review_Delete">
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
                    review_statement.close();
    
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
