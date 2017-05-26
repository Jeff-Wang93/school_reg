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
                Statement classes = conn.createStatement();
                
                // Grab all the classes
                ResultSet rs = classes.executeQuery(
                    "SELECT classes_title FROM classes"
                );
            %>
            
            <%-- HTML select code --%>
            <form action="report_one_b.jsp">
                <select name="choose_class">
                    <% while(rs.next()) { %>
                        <option><%= rs.getString(1)%></option>
                    <% } %>
                </select>
                <input type="submit" value="Submit">
            </form>

            <%-- Get all info about chosen class--%>
            <%  
                String chosen_class = request.getParameter("choose_class");
                PreparedStatement pstmt = conn.prepareStatement(
                    "SELECT classes_course_id, classes_quarter, classes_year " +
                    "FROM classes WHERE classes_title = ?"
                );
                pstmt.setString(1, chosen_class);
                ResultSet display_class = pstmt.executeQuery();
            %>
            
            <%-- format the results --%>
            <TABLE BORDER="1">
                <TR>
                    <TH>Course ID</TH>
                    <TH>Quarter</TH>
                    <TH>Year</TH>
                </TR>

                <% while(display_class.next()) { %>
                <TR>
                    <TD> <%= display_class.getInt(1) %></TD>
                    <TD> <%= display_class.getString(2) %></TD>
                    <TD> <%= display_class.getString(3) %></TD>
                </TR>
                <% } %>
            </TABLE>

            <%-- Get info about students taking chosen classes, all their info, 
                 units and grade options --%>
            <%
                PreparedStatement pstmt3 = conn.prepareStatement(
                    "SELECT s.*, y.units, y.grade_type " + 
                    "FROM student s, " + 
                        "(SELECT student_id, units, grade_type " +
                        "FROM   enrolled_student " + 
                        "WHERE  classes_id IN ( " + 
                            "SELECT classes_id " +
                            "FROM   classes " + 
                            "WHERE  classes_title = ?)) AS y " + 
                    "WHERE s.student_id = y.student_id"
                );
                pstmt3.setString(1, chosen_class);
                ResultSet display_student = pstmt3.executeQuery();
            %>
            
            <TABLE BORDER="1">
                <TR>
                    <TH>Student SSN</TH>
                    <TH>Student ID</TH>
                    <TH>Student First Name</TH>
                    <TH>Student Middle Name</TH>
                    <TH>Student Last Name</TH>
                    <TH>Student Residency</TH>
                    <TH>Student GPA</TH>
                    <TH>Units</TH>
                    <TH>Grade Type</TH>
                </TR>

                <% while(display_student.next()) { %>
                <TR>
                    <TD> <%= display_student.getInt(1) %></TD>
                    <TD> <%= display_student.getInt(2) %></TD>
                    <TD> <%= display_student.getString(3) %></TD>
                    <TD> <%= display_student.getString(4) %></TD>
                    <TD> <%= display_student.getString(5) %></TD>
                    <TD> <%= display_student.getString(6) %></TD>
                    <TD> <%= display_student.getFloat(7) %></TD>
                    <TD> <%= display_student.getString(8) %></TD>
                    <TD> <%= display_student.getString(9) %></TD>
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
