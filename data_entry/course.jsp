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
                            "INSERT INTO course VALUES (?, ?, ?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("COURSE ID")));
                        pstmt.setString(2, request.getParameter("COURSE UNITS"));
                        pstmt.setString(3, request.getParameter("COURSE GRADE TYPE"));
                        pstmt.setString(4, request.getParameter("COURSE NUMBER"));
                        pstmt.setString(5, request.getParameter("COURSE LAB"));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("COURSE DEPARTMENT ID")));
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
                            "UPDATE course SET course_units = ?," + 
                            "course_grade_type = ?, course_number = ?, course_lab = ?," +
                            "course_department_id = ? WHERE course_id = ?");

                        pstmt.setString(1, request.getParameter("COURSE UNITS"));
                        pstmt.setString(2, request.getParameter("COURSE GRADE TYPE"));
                        pstmt.setString(3, request.getParameter("COURSE NUMBER"));
                        pstmt.setString(4, request.getParameter("COURSE LAB"));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("COURSE DEPARTMENT ID")));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("COURSE ID")));
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
                            "DELETE FROM course WHERE course_id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("COURSE ID")));
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
                        ("SELECT * FROM course");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Course ID</th>
                        <th>Course Units</th>
                        <th>Course Grade Type</th>
                        <th>Course Number</th>
                        <th>Course Lab </th>
                        <th>Course Department ID</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="course.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="COURSE ID"  size="20"></th>
                            <th><input value="" name="COURSE UNITS"  size="20"></th>
                            <th><input value="" name="COURSE GRADE TYPE"  size="20"></th>
                            <th><input value="" name="COURSE NUMBER"  size="20"></th>
                            <th><input value="" name="COURSE LAB"  size="20"></th>
                            <th><input value="" name="COURSE DEPARTMENT ID"  size="20"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="course.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <td>
                                <input value="<%= rs.getInt("course_id") %>" 
                                    name="COURSE ID" size="10">
                            </td>
    
                            <td>
                                <input value="<%= rs.getString("course_units") %>" 
                                    name="COURSE UNITS" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("course_grade_type") %>" 
                                    name="COURSE GRADE TYPE" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("course_title") %>" 
                                    name="COURSE NUMBER" size="10">
                            </td>
    
                            <td>
                                <input value="<%= rs.getString("course_lab") %>" 
                                    name="COURSE LAB" size="10">
                            </td>
    
                            <td>
                                <input value="<%= rs.getInt("course_department_id") %>" 
                                    name="COURSE DEPARTMENT ID" size="10">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="course.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("course_id") %>" name="COURSE ID">
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

        <%-- prereq --%>
        <%-- prereq --%>
        <%-- prereq --%>
        <tr>
            <td valign="center">
                <%-- -------- Include menu HTML code -------- --%>
                Prereq Entry
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
                    String pre_action = request.getParameter("pre_action");
                    // Check if an insertion is requested
                    if (pre_action != null && pre_action.equals("pre_insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO course_prereq VALUES (?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("course ID")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("prereq ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (pre_action != null && pre_action.equals("pre_update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE course_prereq SET prereq_id = ? where course_id = ?"); 

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("prereq ID")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("course ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (pre_action != null && pre_action.equals("pre_delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM course_prereq WHERE course_id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("course ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement pre_statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = pre_statement.executeQuery
                        ("SELECT * FROM course_prereq");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Course ID</th>
                        <th>Prereq ID</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="course.jsp" method="get">
                            <input type="hidden" value="pre_insert" name="pre_action">
                            <th><input value="" name="course ID" size="10"></th>
                            <th><input value="" name="prereq ID" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="course.jsp" method="get">
                            <input type="hidden" value="pre_update" name="pre_action">

                            <%-- Get the DEPARTMENT ID, which is a INTEGER --%>
                            <td>
                                <input value="<%= rs.getInt("course_id") %>" 
                                    name="course ID" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getInt("prereq_id") %>" 
                                    name="prereq ID" size="10">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="course.jsp" method="get">
                            <input type="hidden" value="pre_delete" name="pre_action">
                            <input type="hidden" 
                                value="<%= rs.getInt("course_id") %>" name="course ID">
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
                    pre_statement.close();
    
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
