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
                    String action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO review_info VALUES (?,?,?,?,?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("REVIEW ID")));
                        pstmt.setString(2, request.getParameter("REVIEW TIME"));
                        pstmt.setString(3, request.getParameter("REVIEW LOCATION"));
                        pstmt.setString(4, request.getParameter("REVIEW MANDATORY"));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("CLASS ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE review_info SET review_info_time = ?," +
                            "review_info_location = ?, review_info_mandatory = ?," +
                            "review_info_classes_id = ? WHERE review_info_id = ?");

                        pstmt.setString(1, request.getParameter("REVIEW TIME"));
                        pstmt.setString(2, request.getParameter("REVIEW LOCATION"));
                        pstmt.setString(3, request.getParameter("REVIEW MANDATORY"));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("CLASS ID")));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("REVIEW ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (action != null && action.equals("delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM review_info WHERE review_info_id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("REVIEW ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM review_info");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Review ID</th>
                        <th>Review Time</th>
                        <th>Review Location</th>
                        <th>Review Mandatory</th>
                        <th>Class ID</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="review.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="REVIEW ID" size="10"></th>
                            <th><input value="" name="REVIEW TIME"  size="10"></th>
                            <th><input value="" name="REVIEW LOCATION"  size="10"></th>
                            <th><input value="" name="REVIEW MANDATORY"  size="10"></th>
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
                            <input type="hidden" value="update" name="action">

                            <td>
                                <input value="<%= rs.getString("review_info_id") %>" 
                                    name="REVIEW ID" size="10">
                            </td>
    
                            <td>
                                <input value="<%= rs.getString("review_info_time") %>" 
                                    name="REVIEW TIME" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("review_info_location") %>" 
                                    name="REVIEW LOCATION" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("review_info_mandatory") %>" 
                                    name="REVIEW MANDATORY" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("review_info_classes_id") %>" 
                                    name="CLASS ID" size="10">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="review.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("review_info_id") %>" name="REVIEW ID">
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
                    statement.close();
    
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
