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
                            "INSERT INTO Student VALUES (?, ?, ?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SSN")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("ID")));
                        pstmt.setString(3, request.getParameter("FIRSTNAME"));
                        pstmt.setString(4, request.getParameter("MIDDLENAME"));
                        pstmt.setString(5, request.getParameter("LASTNAME"));
                        pstmt.setString(6, request.getParameter("RESIDENCY"));
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
                            "UPDATE Student SET STUDENT_ID = ?, STUDENT_FIRST_NAME = ?, " +
                            "STUDENT_MIDDLE_NAME = ?, STUDENT_LAST_NAME = ?," +  
                            "STUDENT_RESIDENCY = ? WHERE STUDENT_SSN = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("ID")));
                        pstmt.setString(2, request.getParameter("FIRSTNAME"));
                        pstmt.setString(3, request.getParameter("MIDDLENAME"));
                        pstmt.setString(4, request.getParameter("LASTNAME"));
                        pstmt.setString(5, request.getParameter("RESIDENCY"));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("SSN")));
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
                            "DELETE FROM Student WHERE STUDENT_SSN = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("SSN")));
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
                        ("SELECT * FROM student");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>SSN</th>
                        <th>ID</th>
                        <th>First</th>
			            <th>Middle</th>
                        <th>Last</th>
                        <th>Residency</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="students.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="SSN" size="10"></th>
                            <th><input value="" name="ID" size="10"></th>
                            <th><input value="" name="FIRSTNAME" size="15"></th>
			                <th><input value="" name="MIDDLENAME" size="15"></th>
                            <th><input value="" name="LASTNAME" size="15"></th>
                            <th><input value="" name="RESIDENCY" size="15"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="students.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("STUDENT_SSN") %>" 
                                    name="SSN" size="10">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getInt("STUDENT_ID") %>" 
                                    name="ID" size="10">
                            </td>
    
                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("STUDENT_FIRST_NAME") %>"
                                    name="FIRSTNAME" size="15">
                            </td>
    
                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("STUDENT_MIDDLE_NAME") %>" 
                                    name="MIDDLENAME" size="15">
                            </td>
    
			    <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("STUDENT_LAST_NAME") %>" 
                                    name="LASTNAME" size="15">
                            </td>

                            <%-- Get the COLLEGE --%>
                            <td>
                                <input value="<%= rs.getString("STUDENT_RESIDENCY") %>" 
                                    name="RESIDENCY" size="15">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="students.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("STUDENT_SSN") %>" name="SSN">
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


        <%-- UNDERGRAD --%>
        <%-- UNDERGRAD --%>
        <%-- UNDERGRAD --%>
        <tr>
        <td valign="center">
                <%-- -------- Include menu HTML code -------- --%>
                Undergrad Entry
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
                    String under_action = request.getParameter("under_action");
                    // Check if an insertion is requested
                    if (under_action != null && under_action.equals("under_insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO undergrad_student VALUES (?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("UNDER_ID")));
                        pstmt.setString(2, request.getParameter("COLLEGE"));
                        pstmt.setString(3, request.getParameter("MINOR"));
                        pstmt.setString(4, request.getParameter("MAJOR"));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (under_action != null && under_action.equals("under_update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE undergrad_student SET undergrad_student_college = ?," +
                            "undergrad_student_minor = ?," +
                            "undergrad_student_major = ?  WHERE undergrad_student_id = ?");

                        pstmt.setString(1, request.getParameter("COLLEGE"));
                        pstmt.setString(2, request.getParameter("MINOR"));
                        pstmt.setString(3, request.getParameter("MAJOR"));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("UNDER_ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (under_action != null && under_action.equals("under_delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM undergrad_student WHERE undergrad_student_id = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("UNDER_ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement under_statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = under_statement.executeQuery
                        ("SELECT * FROM undergrad_student");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Student ID</th>
                        <th>College</th>
                        <th>Minor</th>
			            <th>Major</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="students.jsp" method="get">
                            <input type="hidden" value="under_insert" name="under_action">
                            <th><input value="" name="UNDER_ID" size="10"></th>
                            <th><input value="" name="COLLEGE" size="10"></th>
                            <th><input value="" name="MINOR" size="15"></th>
                            <th><input value="" name="MAJOR" size="15"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="students.jsp" method="get">
                            <input type="hidden" value="under_update" name="under_action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("undergrad_student_id") %>" 
                                    name="UNDER_ID" size="10">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("undergrad_student_college") %>" 
                                    name="COLLEGE" size="10">
                            </td>
    
                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("undergrad_student_minor") %>"
                                    name="MINOR" size="15">
                            </td>
    
                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("undergrad_student_major") %>" 
                                    name="MAJOR" size="15">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="students.jsp" method="get">
                            <input type="hidden" value="under_delete" name="under_action">
                            <input type="hidden" 
                                value="<%= rs.getInt("undergrad_student_id") %>" name="UNDER_ID">
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
                    under_statement.close();

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

        <%-- MASTER --%>
        <%-- MASTER --%>
        <%-- MASTER --%>
        <tr>
            <td valign="center">
                <%-- -------- Include menu HTML code -------- --%>
                Master Entry
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
                    String master_action = request.getParameter("master_action");
                    // Check if an insertion is requested
                    if (master_action != null && master_action.equals("master_insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO master_student VALUES (?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("MASTER_ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (master_action != null && master_action.equals("master_update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE master_student SET master_student_id = ?," +
                            "WHERE master_student_id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("MASTER_ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (master_action != null && master_action.equals("master_delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM master_student WHERE master_student_id = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("MASTER_ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement master_statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = master_statement.executeQuery
                        ("SELECT * FROM master_student");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Student ID</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="students.jsp" method="get">
                            <input type="hidden" value="master_insert" name="master_action">
                            <th><input value="" name="MASTER_ID" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="students.jsp" method="get">
                            <input type="hidden" value="master_update" name="master_action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("master_student_id") %>" 
                                    name="MASTER_ID" size="10">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="students.jsp" method="get">
                            <input type="hidden" value="master_delete" name="master_action">
                            <input type="hidden" 
                                value="<%= rs.getInt("master_student_id") %>" name="MASTER_ID">
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
                    master_statement.close();

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
        
        <%-- PHD --%>
        <%-- PHD --%>
        <%-- PHD --%>
        <tr>
            <td valign="center">
                <%-- -------- Include menu HTML code -------- --%>
                PhD Entry
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
                        String phd_action = request.getParameter("phd_action");
                        // Check if an insertion is requested
                        if (phd_action != null && phd_action.equals("phd_insert")) {

                            // Begin transaction
                            conn.setAutoCommit(false);
                            
                            // Create the prepared statement and use it to
                            // INSERT the student attributes INTO the Student table.
                            PreparedStatement pstmt = conn.prepareStatement(
                                "INSERT INTO phd_student VALUES (?, ?)");

                            pstmt.setInt(1, Integer.parseInt(request.getParameter("PHD ID")));
                            pstmt.setString(2, request.getParameter("PHD TYPE"));
                            int rowCount = pstmt.executeUpdate();

                            // Commit transaction
                            conn.commit();
                            conn.setAutoCommit(true);
                        }
                %>

                <%-- -------- UPDATE Code -------- --%>
                <%
                        // Check if an update is requested
                        if (phd_action != null && phd_action.equals("phd_update")) {

                            // Begin transaction
                            conn.setAutoCommit(false);
                            
                            // Create the prepared statement and use it to
                            // UPDATE the student attributes in the Student table.
                            PreparedStatement pstmt = conn.prepareStatement(
                                "UPDATE phd_student SET phd_student_type = ?" +
                                "WHERE phd_student_id= ?");

                            pstmt.setString(1, request.getParameter("PHD TYPE"));
                            pstmt.setInt(2, Integer.parseInt(request.getParameter("PHD ID")));
                            int rowCount = pstmt.executeUpdate();

                            // Commit transaction
                            conn.commit();
                            conn.setAutoCommit(true);
                        }
                %>

                <%-- -------- DELETE Code -------- --%>
                <%
                        // Check if a delete is requested
                        if (phd_action != null && phd_action.equals("phd_delete")) {

                            // Begin transaction
                            conn.setAutoCommit(false);
                            
                            // Create the prepared statement and use it to
                            // DELETE the student FROM the Student table.
                            PreparedStatement pstmt = conn.prepareStatement(
                                "DELETE FROM phd_student WHERE phd_student_id = ?");

                            pstmt.setInt(
                                1, Integer.parseInt(request.getParameter("PHD ID")));
                            int rowCount = pstmt.executeUpdate();

                            // Commit transaction
                             conn.commit();
                            conn.setAutoCommit(true);
                        }
                %>

                <%-- -------- SELECT Statement Code -------- --%>
                <%
                        // Create the statement
                        Statement phd_statement = conn.createStatement();

                        // Use the created statement to SELECT
                        // the student attributes FROM the Student table.
                        ResultSet rs = phd_statement.executeQuery
                            ("SELECT * FROM phd_student");
                %>

                <!-- Add an HTML table header row to format the results -->
                    <table border="1">
                        <tr>
                            <th>Student ID</th>
                            <th>Type</th>
                        </tr>
                        <tr>
                            <form action="students.jsp" method="get">
                                <input type="hidden" value="phd_insert" name="phd_action">
                                <th><input value="" name="PHD ID" size="10"></th>
                                <th><input value="" name="PHD TYPE" size="10"></th>
                                <th><input type="submit" value="Insert"></th>
                            </form>
                        </tr>

                <%-- -------- Iteration Code -------- --%>
                <%
                        // Iterate over the ResultSet
            
                        while ( rs.next() ) {
            
                %>

                        <tr>
                            <form action="students.jsp" method="get">
                                <input type="hidden" value="phd_update" name="phd_action">

                                <%-- Get the SSN, which is a number --%>
                                <td>
                                    <input value="<%= rs.getInt("phd_student_id") %>" 
                                        name="PHD ID" size="10">
                                </td>
        
                                <%-- Get the ID --%>
                                <td>
                                    <input value="<%= rs.getString("phd_student_type") %>" 
                                        name="PHD TYPE" size="10">
                                </td>
        
                                <%-- Button --%>
                                <td>
                                    <input type="submit" value="Update">
                                </td>
                            </form>
                            <form action="students.jsp" method="get">
                                <input type="hidden" value="phd_delete" name="phd_action">
                                <input type="hidden" 
                                    value="<%= rs.getInt("phd_student_id") %>" name="PHD ID">
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
                        phd_statement.close();

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

        <%-- thesis --%>
        <%-- thesis --%>
        <%-- thesis --%>
        <tr>
            <td valign="center">
                Thesis Entry
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
                        String thesis_action = request.getParameter("thesis_action");
                        // Check if an insertion is requested
                        if (thesis_action != null && thesis_action.equals("thesis_insert")) {

                            // Begin transaction
                            conn.setAutoCommit(false);

                            // parse the string with all faculty names
                            String faculty_names = request.getParameter("THESIS FACULTY NAME");
                            String delim = "[,]";
                            String [] committee = faculty_names.split(delim);
                            
                            // ensure at least 3 professors are added
                            if (committee.length >= 3) {
                                // Create the prepared statement and use it to
                                // INSERT the student attributes INTO the Student table.
                                for(int i = 0; i < committee.length; i++) {
                                    PreparedStatement pstmt = conn.prepareStatement(
                                        "INSERT INTO thesis VALUES (?,?)");

                                    pstmt.setInt(1, Integer.parseInt(request.getParameter("THESIS STUDENT ID")));
                                    pstmt.setString(2, committee[i]);
                                    int rowCount = pstmt.executeUpdate();

                                    // Commit transaction
                                    conn.commit();
                                    conn.setAutoCommit(false);
                                }
                            }
                        }
                %>

                <%-- -------- UPDATE Code -------- --%>
                <%
                        // Check if an update is requested
                        if (thesis_action != null && thesis_action.equals("thesis_update")) {

                            // Begin transaction
                            conn.setAutoCommit(false);
                            
                            // Create the prepared statement and use it to
                            // UPDATE the student attributes in the Student table.
                            PreparedStatement pstmt = conn.prepareStatement(
                                "UPDATE thesis SET thesis_faculty_name = ? WHERE " +       
                                "thesis_student_id = ? AND thesis_faculty_name = ?");

                            pstmt.setString(1, request.getParameter("UPDATE FACULTY NAME"));
                            pstmt.setInt(2, Integer.parseInt(
                                request.getParameter("THESIS STUDENT ID")));
                            pstmt.setString(3, request.getParameter("THESIS FACULTY NAME"));
                            int rowCount = pstmt.executeUpdate();

                            // Commit transaction
                             conn.commit();
                            conn.setAutoCommit(true);
                        }
                %>

                <%-- -------- DELETE Code -------- --%>
                <%
                        // Check if a delete is requested
                        if (thesis_action != null && thesis_action.equals("thesis_delete")) {

                            // Begin transaction
                            conn.setAutoCommit(false);

                            // Create the prepared statement and use it to
                            // DELETE the student FROM the Student table.
                            
                            PreparedStatement pstmt = conn.prepareStatement(
                                "DELETE FROM thesis WHERE thesis_faculty_name = ? AND " +
                                " thesis_student_id = ?");

                            pstmt.setString(1, request.getParameter("THESIS FACULTY NAME"));
                            pstmt.setInt(
                                2, Integer.parseInt(request.getParameter("THESIS STUDENT ID")));
                            int rowCount = pstmt.executeUpdate();

                            // Commit transaction
                            conn.commit();
                            conn.setAutoCommit(true);
                        }
                %>

                <%-- -------- SELECT Statement Code -------- --%>
                <%
                        // Create the statement
                        Statement thesis_statement = conn.createStatement();

                        // Use the created statement to SELECT
                        // the student attributes FROM the Student table.
                        ResultSet rs = thesis_statement.executeQuery
                            ("SELECT * FROM thesis");
                %>

                <!-- Add an HTML table header row to format the results -->
                    <table border="1">
                        <tr>
                            <th>Student ID</th>
                            <th>Faculty Names</th>
                            <th></th>
                            <th>Update Faculty Names</th>
                        </tr>
                        <tr>
                            <form action="students.jsp" method="get">
                                <input type="hidden" value="thesis_insert" name="thesis_action">
                                <th><input value="" name="THESIS STUDENT ID" size="10"></th>
                                <th><input value="" name="THESIS FACULTY NAME" size="10"></th>
                                <th><input type="submit" value="Insert"></th>
                            </form>
                        </tr>

                <%-- -------- Iteration Code -------- --%>
                <%
                        // Iterate over the ResultSet
            
                        while ( rs.next() ) {
            
                %>

                        <tr>
                            <form action="students.jsp" method="get">
                                <input type="hidden" value="thesis_update" name="thesis_action">

                                <%-- Get the SSN, which is a number --%>
                                <td>
                                    <input value="<%= rs.getInt("thesis_student_id") %>" 
                                        name="THESIS STUDENT ID" size="10">
                                </td>
        
                                <%-- Get the ID --%>
                                <td>
                                    <input value="<%= rs.getString("thesis_faculty_name") %>" 
                                        name="THESIS FACULTY NAME" size="10">
                                </td>

                                <td>
                                    <th><input value="" name="UPDATE FACULTY NAME" size="10"></th>
                                </td>
        
                                <%-- Button --%>
                                <td>
                                    <input type="submit" value="Update">
                                </td>
                            </form>
                            <form action="students.jsp" method="get">
                                <input type="hidden" value="thesis_delete" name="thesis_action">
                                <input type="hidden" 
                                    value="<%= rs.getInt("thesis_student_id") %>" 
                                    name="THESIS STUDENT ID">
                                <input type="hidden" 
                                    value="<%= rs.getString("thesis_faculty_name") %>" 
                                    name="THESIS FACULTY NAME">

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
                        thesis_statement.close();

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


        <%-- PREVIOUS CLASS --%>
        <%-- PREVIOUS CLASS --%>
        <%-- PREVIOUS CLASS --%>
        <tr>
            <td valign="center">
                <%-- -------- Include menu HTML code -------- --%>
                Previous Classes
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
                    String previous_action = request.getParameter("previous_action");
                    // Check if an insertion is requested
                    if (previous_action != null && previous_action.equals("previous_insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO previous_class VALUES (?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("student ID")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("classes ID")));
                        pstmt.setString(3, request.getParameter("grade"));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (previous_action != null && previous_action.equals("previous_update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE previous_class SET grade = ? where student_id = ? AND classes_id = ?"); 
                        pstmt.setString(1, request.getParameter("grade"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("student ID")));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("classes ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (previous_action != null && previous_action.equals("previous_delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM previous_class WHERE student_id = ? and classes_id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("student ID")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("classes ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement previous_statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = previous_statement.executeQuery
                        ("SELECT * FROM previous_class");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Student ID</th>
                        <th>Classes ID</th>
                        <th>Grade</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="students.jsp" method="get">
                            <input type="hidden" value="previous_insert" name="previous_action">
                            <th><input value="" name="student ID"  size="10"></th>
                            <th><input value="" name="classes ID" size="10"></th>
                            <th><input value="" name="grade" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="students.jsp" method="get">
                            <input type="hidden" value="previous_update" name="previous_action">

                            <%-- Get the DEPARTMENT ID, which is a INTEGER --%>
                            <td>
                                <input value="<%= rs.getInt("student_id") %>" 
                                    name="student ID" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getInt("classes_id") %>" 
                                    name="classes ID" size="10">
                            </td>
    
                            <%-- Get the DEPARTMENT TITLE --%>
                            <td>
                                <input value="<%= rs.getString("grade") %>" 
                                    name="grade" size="10">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="students.jsp" method="get">
                            <input type="hidden" value="previous_delete" name="previous_action">
                            <input type="hidden" 
                                value="<%= rs.getInt("student_id") %>" name="student ID">
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
                    previous_statement.close();
    
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

        <%-- PROBATION --%>
        <%-- PROBATION --%>
        <%-- PROBATION --%>
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
                        <form action="students.jsp" method="get">
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
                        <form action="students.jsp" method="get">
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
                        <form action="students.jsp" method="get">
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


        <%-- END --%>
        <%-- END --%>
        <%-- END --%>
    </table>
</body>

</html>
