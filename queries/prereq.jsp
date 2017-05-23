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
            

            <% 
                Statement curr_student = conn.createStatement();

                // Grab all students of the current quarter
                ResultSet rs = curr_student.executeQuery
                    ("SELECT student_ssn, student_first_name, student_middle_name, " +
                     "student_last_name FROM student WHERE student_id IN " +
                     "(SELECT student_id FROM enrolled_student)");
            %>
            
            <%-- format the results --%>
            <TABLE BORDER="1">
                <TR>
                    <TH>SSN</TH>
                    <TH>First Name</TH>
                    <TH>Middle Name</TH>
                    <TH>Last Name</TH>
                </TR>

                <% while(rs.next()) { %>
                <TR>
                    <TD> <%= rs.getInt(1) %></TD>
                    <TD> <%= rs.getString(2) %></TD>
                    <TD> <%= rs.getString(3) %></TD>
                    <TD> <%= rs.getString(4) %></TD>
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
