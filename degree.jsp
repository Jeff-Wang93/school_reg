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
                            "INSERT INTO degree VALUES (?, ?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("DEGREE ID")));
                        pstmt.setFloat(2, Float.parseFloat(request.getParameter("DEGREE GPA")));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("DEGREE LOW")));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("DEGREE UPPER")));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("DEPARTMENT ID")));
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
                            "UPDATE degree SET degree_gpa_requirement = ?," +
                            "degree_lower_div_req = ?, degree_upper_div_req = ?," +
                            "degree_department_id =? WHERE degree_id = ?");

                        pstmt.setFloat(1, Float.parseFloat(request.getParameter("DEGREE GPA")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("DEGREE LOW")));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("DEGREE UPPER")));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("DEPARTMENT ID")));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("DEGREE ID")));
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
                            "DELETE FROM degree WHERE degree_id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("DEGREE ID")));
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
                        ("SELECT * FROM degree");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Degree Id</th>
                        <th>Degree GPA Requirement</th>
                        <th>Degree Lower Div Requirement</th>
                        <th>Degree Upper Div Requirement</th>
                        <th>Degree Department ID</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="degree.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="DEGREE ID"  size="10"></th>
                            <th><input value="" name="DEGREE GPA" size="20"></th>
                            <th><input value="" name="DEGREE LOW" size="20"></th>
                            <th><input value="" name="DEGREE UPPER" size="20"></th>
                            <th><input value="" name="DEPARTMENT ID" size="20"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="degree.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <td>
                                <input value="<%= rs.getInt("degree_id") %>" 
                                    name="DEGREE ID" size="10">
                            </td>
    
                            <td>
                                <input value="<%= rs.getFloat("degree_gpa_requirement") %>" 
                                    name="DEGREE GPA" size="20">
                            </td>
    
                            <td>
                                <input value="<%= rs.getInt("degree_lower_div_req") %>" 
                                    name="DEGREE LOW" size="20">
                            </td>
    
                            <td>
                                <input value="<%= rs.getInt("degree_upper_div_req") %>" 
                                    name="DEGREE UPPER" size="20">
                            </td>

                            <td>
                                <input value="<%= rs.getInt("degree_department_id") %>" 
                                    name="DEPARTMENT ID" size="20">
                            </td>
    

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="degree.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("degree_id") %>" name="DEGREE ID">
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
