<html>

<body>
    <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="qmenu.html"/>
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
                <b>Grade Report</b>
            <% 
                Statement student = conn.createStatement();
                
                // Grab all the classes
                // Holy moly this is gross 
                ResultSet rs = student.executeQuery(
                    "SELECT student_ssn FROM student WHERE student_id IN ( " +
                    "SELECT student_id FROM enrolled_student)" +
                    "UNION " +
                    "SELECT student_ssn FROM student WHERE student_id IN ( " +
                    "SELECT student_id FROM previous_class)"
                );
            %>
            
            <%-- HTML select code --%>
            <form action="report_one_c.jsp">
                <select name="choose_student">
                    <% while(rs.next()) { %>
                        <option><%= rs.getString(1)%></option>
                    <% } %>
                </select>
                <input type="submit" value="Submit">
            </form>

            <%-- Get all info about chosen student --%>
            <%  
                int chosen_student = Integer.parseInt(request.getParameter("choose_student")); 
                PreparedStatement pstmt = conn.prepareStatement(
                    "SELECT student_ssn, student_first_name, student_middle_name, " +
                    "student_last_name FROM student WHERE student_ssn = ?"
                );
                pstmt.setInt(1, chosen_student);
                ResultSet display_student = pstmt.executeQuery();
            %>
            
            <%-- format the results --%>
            <TABLE BORDER="1">
                <TR>
                    <TH>SSN</TH>
                    <TH>First Name</TH>
                    <TH>Middle Name</TH>
                    <TH>Last Name</TH>
                </TR>

                <% while(display_student.next()) { %>
                <TR>
                    <TD> <%= display_student.getInt(1) %></TD>
                    <TD> <%= display_student.getString(2) %></TD>
                    <TD> <%= display_student.getString(3) %></TD>
                    <TD> <%= display_student.getString(4) %></TD>
                </TR>
                <% } %>
            </TABLE>

            <%-- Display all classes taken by chosen student, units, grade --%>
            <%
                // Get student ID number for easier queries
                PreparedStatement ez_id = conn.prepareStatement(
                    "SELECT student_id FROM student WHERE student_ssn = ?"
                );
                ez_id.setInt(1, chosen_student);
                ResultSet ez_id_rs = ez_id.executeQuery();
                ez_id_rs.next();
                int student_id = ez_id_rs.getInt(1);

                PreparedStatement pstmt2 = conn.prepareStatement(
                    "SELECT x.*, y.grade, y.units " +
                    "FROM classes x, previous_class y " +
                    "WHERE x.classes_id = y.classes_id AND y.student_id = ? " +
                    "ORDER BY x.classes_year, x.classes_quarter, x.classes_title"
                );
                pstmt2.setInt(1, student_id);
                ResultSet prev_class = pstmt2.executeQuery();
            %>
            
            <%-- format the results --%>
            <TABLE BORDER="1">
                <TR>
                    <TH>Class ID</TH>
                    <TH>Class Title</TH>
                    <TH>Class Enrollment Limit</TH>
                    <TH>Class Quarter</TH>
                    <TH>Class Year</TH>
                    <TH>Class Instructor</TH>
                    <TH>Course ID</TH>
                    <TH>Grade</TH>
                    <TH>Units</TH>
                </TR>

                <% while(prev_class.next()) { %>
                <TR>
                    <TD> <%= prev_class.getInt(1) %></TD>
                    <TD> <%= prev_class.getString(2) %></TD>
                    <TD> <%= prev_class.getInt(3) %></TD>
                    <TD> <%= prev_class.getString(4) %></TD>
                    <TD> <%= prev_class.getInt(5) %></TD>
                    <TD> <%= prev_class.getString(6) %></TD>
                    <TD> <%= prev_class.getInt(7) %></TD>
                    <TD> <%= prev_class.getString(8) %></TD>
                    <TD> <%= prev_class.getString(9) %></TD>
                </TR>
                <% } %>
            </TABLE>

            <%-- Calculate GPA per quarter here --%>
            
            <%
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
