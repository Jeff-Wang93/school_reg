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
                            "INSERT INTO classes VALUES (?, ?, ?, ?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("classes ID")));
                        pstmt.setString(2, request.getParameter("classes TITLE"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("classes LIMIT")));
                        pstmt.setString(4, request.getParameter("classes QUARTER"));
                        pstmt.setString(5, request.getParameter("classes YEAR"));
                        pstmt.setString(6, request.getParameter("classes INSTRUCTOR"));
                        pstmt.setInt(7, Integer.parseInt(request.getParameter("course ID")));
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
                            "UPDATE classes SET classes_enrollment_limit =?," +
                            "classes_quarter = ?, classes_year = ?, classes_course_id = ?" +
                            "classes_title = ?, classes_instructor = ?" +
                            "where classes_id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("classes LIMIT")));
                        pstmt.setString(2, request.getParameter("classes QUARTER"));
                        pstmt.setString(3, request.getParameter("classes YEAR"));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("course ID")));
                        pstmt.setString(5, request.getParameter("classes TITLE"));
                        pstmt.setString(6, request.getParameter("classes INSTRUCTOR"));
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
                    if (action != null && action.equals("delete")) {

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
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM classes ");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>classes ID</th>
                        <th>classes title</th>
                        <th>classes enrollment limit</th>
                        <th>classes quarter</th>
                        <th>classes year</th>
                        <th>classes instructor</th>
                        <th>course id</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="classes ID"  size="10"></th>
                            <th><input value="" name="classes TITLE" size="10"></th>
                            <th><input value="" name="classes LIMIT"  size="20"></th>
                            <th><input value="" name="classes QUARTER"  size="10"></th>
                            <th><input value="" name="classes YEAR"  size="10"></th>
                            <th><input value="" name="classes INSTRUCTOR"  size="10"></th>
                            <th><input value="" name="course ID" size="10"></th>
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
                            <input type="hidden" value="update" name="action">

                            <td>
                                <input value="<%= rs.getInt("classes_id") %>" 
                                    name="classes ID" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("classes_title") %>" 
                                    name="classes TITLE" size="10">
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
                                <input value="<%= rs.getString("classes_instructor") %>" 
                                    name="classes INSTRUCTOR" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getInt("classes_course_id") %>" 
                                    name="course ID" size="10">
                            </td>

    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("classes_id") %>" name="classes ID">
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

        <%-- LECTURE --%>
        <%-- LECTURE --%>
        <%-- LECTURE --%>
        <tr>
            <td valign="center">
                <%-- -------- Include menu HTML code -------- --%>
                Lecture Entry
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
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="lecture_insert" name="lecture_action">
                            <th><input value="" name="lecture ID" size="10"></th>
                            <th><input value="" name="lecture TIME"  size="10"></th>
                            <th><input value="" name="lecture DATE"  size="10"></th>
                            <th><input value="" name="lecture LOCATION"  size="20"></th>
                            <th><input value="" name="lecture MANDATORY"  size="20"></th>
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
                        <form action="classes.jsp" method="get">
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
                                    name="lecture LOCATION" size="20">
                            </td>

                            <td>
                                <input value="<%= rs.getString("lecture_info_mandatory") %>" 
                                    name="lecture MANDATORY" size="20">
                            </td>

                            <td>
                                <input value="<%= rs.getInt("classes_id") %>" 
                                    name="CLASS ID" size="10">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="lecture_delete" name="lecture_action">
                            <input type="hidden" 
                                value="<%= rs.getInt("lecture_info_id") %>" name="lecture ID">
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

        <%-- DISCUSSION --%>
        <%-- DISCUSSION --%>
        <%-- DISCUSSION --%>
         <tr>
            <td valign="center">
                <%-- -------- Include menu HTML code -------- --%>
                Discussion Entry
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
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="discussion_insert" name="discussion_action">
                            <th><input value="" name="discussion ID" size="10"></th>
                            <th><input value="" name="discussion TIME"  size="10"></th>
                            <th><input value="" name="discussion DATE"  size="10"></th>
                            <th><input value="" name="discussion LOCATION"  size="20"></th>
                            <th><input value="" name="discussion MANDATORY"  size="20"></th>
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
                        <form action="classes.jsp" method="get">
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
                                    name="discussion LOCATION" size="20">
                            </td>

                            <td>
                                <input value="<%= rs.getString("discussion_info_mandatory") %>" 
                                    name="discussion MANDATORY" size="20">
                            </td>

                            <td>
                                <input value="<%= rs.getInt("classes_id") %>" 
                                    name="CLASS ID" size="10">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="discussion_delete" name="discussion_action">
                            <input type="hidden" 
                                value="<%= rs.getInt("discussion_info_id") %>" name="discussion ID">
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

        <%-- REVIEW --%>
        <%-- REVIEW --%>
        <%-- REVIEW --%>
        <tr>
            <td valign="center">
                <%-- -------- Include menu HTML code -------- --%>
                Review Entry
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
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="review_insert" name="review_action">
                            <th><input value="" name="review ID" size="10"></th>
                            <th><input value="" name="review TIME"  size="10"></th>
                            <th><input value="" name="review DATE"  size="10"></th>
                            <th><input value="" name="review LOCATION"  size="20"></th>
                            <th><input value="" name="review MANDATORY"  size="20"></th>
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
                        <form action="classes.jsp" method="get">
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
                                    name="review LOCATION" size="20">
                            </td>

                            <td>
                                <input value="<%= rs.getString("review_info_mandatory") %>" 
                                    name="review MANDATORY" size="20">
                            </td>

                            <td>
                                <input value="<%= rs.getInt("classes_id") %>" 
                                    name="CLASS ID" size="10">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="review_delete" name="review_action">
                            <input type="hidden" 
                                value="<%= rs.getInt("review_info_id") %>" name="review ID">
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

        <%-- LAB --%>
        <%-- LAB --%>
        <%-- LAB --%>
        
        <tr>
            <td valign="center">
                <%-- -------- Include menu HTML code -------- --%>
                Lab Entry
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
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="lab_insert" name="lab_action">
                            <th><input value="" name="lab ID" size="10"></th>
                            <th><input value="" name="lab TIME"  size="10"></th>
                            <th><input value="" name="lab DATE"  size="10"></th>
                            <th><input value="" name="lab LOCATION"  size="20"></th>
                            <th><input value="" name="lab MANDATORY"  size="20"></th>
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
                        <form action="classes.jsp" method="get">
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
                                    name="lab LOCATION" size="20">
                            </td>

                            <td>
                                <input value="<%= rs.getString("lab_info_mandatory") %>" 
                                    name="lab MANDATORY" size="20">
                            </td>

                            <td>
                                <input value="<%= rs.getInt("classes_id") %>" 
                                    name="CLASS ID" size="10">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="lab_delete" name="lab_action">
                            <input type="hidden" 
                                value="<%= rs.getInt("lab_info_id") %>" name="lab ID">
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

        <%-- enrolled --%>
        <%-- enrolled --%>
        <%-- enrolled --%>
        <tr>
            <td valign="centered">
                <%-- -------- Include menu HTML code -------- --%>
                Enrolled Student 
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
                    if (enrolled_action != null && enrolled_action.equals("enrolled_insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);

                        // Determine if there are variable number of units
                        PreparedStatement check_unit = conn.prepareStatement(
                            "SELECT course_units FROM course WHERE course_id in ( " +
                            "SELECT classes_course_id FROM classes WHERE classes_id = ?)"
                        );
                        
                        // Using class ID, check if the COURSE allows variable
                        // units
                        check_unit.setInt(1, Integer.parseInt(request.getParameter("classes ID")));
                        ResultSet variable_units = check_unit.executeQuery();
                        String delim             = "[,]";
                        variable_units.next();
                        String course_units      = variable_units.getString(1);
                        String [] course_unit    = course_units.split(delim);
                        // If the course allows variable units
                        if (course_unit.length > 1) {

                            String beginning = course_unit[0];
                            String ending    = course_unit[1];
                            
                            int begin = Integer.parseInt(beginning);
                            int end   = Integer.parseInt(ending);
                            int enter = Integer.parseInt(request.getParameter("enrolled units"));
                            // ensure units are within the allowed range
                            if (enter >= begin && enter <= end) {
                            // Create the prepared statement and use it to
                            // INSERT the student attributes INTO the Student table.
                            PreparedStatement pstmt = conn.prepareStatement(
                                "INSERT INTO enrolled_student VALUES (?, ?, ?)");

                            pstmt.setInt(1, Integer.parseInt(request.getParameter("student ID")));
                            pstmt.setInt(2, Integer.parseInt(request.getParameter("classes ID")));
                            pstmt.setString(3, request.getParameter("enrolled units"));
                            int rowCount = pstmt.executeUpdate();

                            // Commit transaction
                            conn.commit();
                            conn.setAutoCommit(true);
                            }

                            else {
                                // Error because unit entered is outside of
                                // range
                                out.println("Entered units is outside of range");
                            }
                        }

                        else {
                            // Make sure the units enter matched the set units
                            // convert for comparison. String comparisons didnt
                            // work here
                            int entered = Integer.parseInt(request.getParameter("enrolled units"));
                            int unit    = Integer.parseInt(course_units);
                            if(entered == unit) {
                            // Create the prepared statement and use it to
                            // INSERT the student attributes INTO the Student table.
                            PreparedStatement pstmt = conn.prepareStatement(
                                "INSERT INTO enrolled_student VALUES (?, ?, ?)");

                            pstmt.setInt(1, Integer.parseInt(request.getParameter("student ID")));
                            pstmt.setInt(2, Integer.parseInt(request.getParameter("classes ID")));
                            pstmt.setString(3, request.getParameter("enrolled units"));
                            int rowCount = pstmt.executeUpdate();

                            // Commit transaction
                            conn.commit();
                            conn.setAutoCommit(true);
                            }

                            else {
                                out.println("This class does not support a range of units");
                            }
                        }
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
                            "UPDATE enrolled_student SET classes_id = ?, units = ?" +
                            "WHERE student_id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("classes ID")));
                        pstmt.setString(2, request.getParameter("enrolled units"));
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
                        <th>Units</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="enrolled_insert" name="enrolled_action">
                            <th><input value="" name="student ID" size="10"></th>
                            <th><input value="" name="classes ID" size="10"></th>
                            <th><input value="" name="enrolled units" size="10"></th>
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
                            <input type="hidden" value="enrolled_update" name="enrolled_action">

                            <td>
                                <input value="<%= rs.getInt("student_id") %>" 
                                    name="student ID" size="10">
                            </td>
    
                            <td>
                                <input value="<%= rs.getInt("classes_id") %>" 
                                    name="classes ID" size="10">
                            </td>

                             <td>
                                <input value="<%= rs.getString("units") %>" 
                                    name="enrolled units" size="10">
                            </td>

    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="classes.jsp" method="get">
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
 
        <%-- waitlisted --%>
        <%-- waitlisted --%>
        <%-- waitlisted --%>
        <tr>
            <td valign="centered">
                <%-- -------- Include menu HTML code -------- --%>
                Waitlist Student 
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
                    String waitlist_action = request.getParameter("waitlist_action");
                    // Check if an insertion is requested
                    if (waitlist_action != null && waitlist_action.equals("waitlist_insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO waitlist_student VALUES (?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("student ID")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("classes ID")));
                        pstmt.setString(3, request.getParameter("wait units"));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (waitlist_action != null && waitlist_action.equals("waitlist_update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE waitlist_student SET classes_id = ?, units = ?" +
                            "WHERE student_id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("classes ID")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("student ID")));
                        pstmt.setString(3, request.getParameter("wait units"));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (waitlist_action != null && waitlist_action.equals("waitlist_delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM waitlist_student WHERE student_id = ?");

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
                    Statement waitlist_statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = waitlist_statement.executeQuery
                        ("SELECT * FROM waitlist_student");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Student ID</th>
                        <th>Classes ID</th>
                        <th>Units</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="waitlist_insert" name="waitlist_action">
                            <th><input value="" name="student ID" size="10"></th>
                            <th><input value="" name="classes ID" size="10"></th>
                            <th><input value="" name="wait quarter" size="10"></th>
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
                            <input type="hidden" value="waitlist_update" name="waitlist_action">

                            <td>
                                <input value="<%= rs.getInt("student_id") %>" 
                                    name="student ID" size="10">
                            </td>
    
                            <td>
                                <input value="<%= rs.getInt("classes_id") %>" 
                                    name="classes ID" size="10">
                            </td>

                             <td>
                                <input value="<%= rs.getString("units") %>" 
                                    name="wait units" size="10">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="waitlist_delete" name="waitlist_action">
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
                    waitlist_statement.close();
    
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
