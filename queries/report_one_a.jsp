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
            
            <% 
                Statement curr_student = conn.createStatement();
                
                // Grab all students of the current quarter
                ResultSet rs = curr_student.executeQuery
                    ("SELECT student_ssn FROM student WHERE student_id IN " +
                     "(SELECT student_id FROM enrolled_student)");
            %>
            
            <%-- HTML select code --%>
            <form action="report_one_a.jsp">
                <select name="choose_student">
                    <% while(rs.next()) { %>
                        <option><%= rs.getInt(1)%></option>
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

            
            <%-- Get all current classes by student --%>
            <%
                PreparedStatement pstmt2 = conn.prepareStatement(
                    "SELECT * FROM classes WHERE classes_id IN (SELECT classes_id " +
                    "FROM enrolled_student WHERE student_id IN (SELECT student_id " +
                    "FROM student WHERE student_ssn = ?))"
                );
                pstmt2.setInt(1, chosen_student);
                //ResultSet display_class = pstmt2.executeQuery();
                
                PreparedStatement pstmt3 = conn.prepareStatement(
                    "SELECT x.*, y.units, y.grade_type " +
                    "FROM classes x, " +
                        "(SELECT classes_id, units, grade_type " + 
                        "FROM   enrolled_student " + 
                        "WHERE  student_id IN " +
                            "(SELECT student_id " +
                            " FROM student " +
                            " WHERE student_ssn = ?)) AS y " + 
                    "WHERE x.classes_id = y.classes_id"
                );
                pstmt3.setInt(1, chosen_student);
                ResultSet display_class = pstmt3.executeQuery();
            %>
            
            <%-- format the results --%>
            <TABLE BORDER="1">
                <TR>
                    <TH>Class ID</TH>
                    <TH>Class Title</TH>
                    <TH>Enrollment Limit</TH>
                    <TH>Quarter</TH>
                    <TH>Year</TH>
                    <TH>Instructor</TH>
                    <TH>Course ID</TH>
                    <TH>Units</TH>
                    <TH>Grade Type</TH>
                </TR>

                <%-- display class only has information for the first 7 columns --%>
                <%-- As seen above, I still have 2 more columns: units and grade type --%>
                <% while(display_class.next()) { %>
                <TR>
                    <TD> <%= display_class.getInt(1) %></TD>
                    <TD> <%= display_class.getString(2) %></TD>
                    <TD> <%= display_class.getInt(3) %></TD>
                    <TD> <%= display_class.getString(4) %></TD>
                    <TD> <%= display_class.getString(5) %></TD>
                    <TD> <%= display_class.getString(6) %></TD>
                    <TD> <%= display_class.getInt(7) %></TD>
                    <TD> <%= display_class.getString(8) %></TD>
                    <TD> <%= display_class.getString(9) %></TD>
                </TR>
                <% } %>
            </TABLE>


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
