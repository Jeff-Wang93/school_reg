<html>

<body>
    <table border="1">
        <tr>
            <td valign="center">
                <%-- -------- Include menu HTML code -------- --%>
                Current Student Query
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

                        PreparedStatement pstmt = conn.prepareStatement(
                            "SELECT student_first_name, student_middle_name, " +
                            "student_last_name FROM students WHERE student_ssn = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("student SSN")));
                        
                        ResultSet rs = pstmt.executeQuery();
                    }
            %>

            <!-- Add an HTML table header row to format the results -->
            <table border="1">
                <tr>
                    <th>Student SSN</th>
                    <th>Student First Name</th>
                    <th>Student Middle Name</th>
                    <th>Student Last Name</th>
                    <th>Action</th>
                </tr>
                <tr>
                    <form action="prereq.jsp" method="get">
                        <input type="hidden" value="pro_insert" name="pro_action">
                        <th><input value="" name="student SSN" size="10"></th>
                        <th><input type="submit" value="Insert"></th>
                    </form>
                </tr>

                <%-- Iteration Code --%>
                <%
                    while( rs.next() ) {
                %>
                
                <tr>
                    <form action="prereq.jsp" method="get">
                        <input type="hidden" value="req_update" name = "req_action">

                        <td> 
                            <input value="<%= rs.getString("student_ssn") %>"
                                   size="10">
                        </td>
                </tr>

                <%
                    }
                %>

            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    //rs.close();
    
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
