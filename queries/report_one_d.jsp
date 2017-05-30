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
            
            <b>Remaining Degree Unit Requirements</b>

            <% 
                Statement curr_student = conn.createStatement();
                
                // Grab all undergrad students of the current quarter
                ResultSet rs = curr_student.executeQuery(
                    "SELECT student_ssn " +
                    "FROM student " + 
                    "WHERE student_id IN " +
                        "(SELECT student_id " +
                        " FROM enrolled_student " + 
                        " WHERE student_id IN " +
                            " (SELECT undergrad_student_id " +
                            "  FROM undergrad_student)) "
                );
            %>
            
            <% 
                Statement curr_degree = conn.createStatement();
                
                // Grab all undergrad students of the current quarter
                ResultSet rs2 = curr_degree.executeQuery(
                    "SELECT degree_name " +
                    "FROM degree " +
                    "WHERE degree_type = 'BS'"
                );
            %>

            <%-- Get all info about current undergrad student --%>
            <%-- HTML select code --%>
            <form action="report_one_d.jsp">
                <select name="choose_student">
                    <% while(rs.next()) { %>
                        <option><%= rs.getInt(1)%></option>
                    <% } %>
                </select>

                <select name="choose_degree"> 
'                   <% while(rs2.next()) { %>
                        <option><%= rs2.getString(1)%></option>
                    <% } %>

                </select>
                <input type="submit" value="Submit">
            </form>

            <%  
                // get all undergrad student information
                int chosen_student = Integer.parseInt(request.getParameter("choose_student")); 
                PreparedStatement pstmt = conn.prepareStatement(
                    "SELECT student_ssn, student_first_name, student_middle_name, " +
                    "student_last_name FROM student WHERE student_ssn = ?"
                );
                pstmt.setInt(1, chosen_student);
                ResultSet display_student = pstmt.executeQuery();

                // get all degree information
                String chosen_degree = request.getParameter("choose_degree"); 
                PreparedStatement pstmt2 = conn.prepareStatement(
                    "SELECT degree_name, degree_type " +
                    "FROM degree " +
                    "WHERE degree_name = ? AND degree_type = 'BS'"
                );
                pstmt2.setString(1, chosen_degree);
                ResultSet display_degree = pstmt2.executeQuery();

                // get number of units needed to graduate
                // calculate the total number of units needed to graduate with degree
                PreparedStatement pstmt3 = conn.prepareStatement(
                    "SELECT degree_lower_div_req, degree_upper_div_req ,degree_tech_req, degree_department_id " +
                    "FROM degree " +
                    "WHERE degree_name = ? AND degree_type = 'BS'"
                );
                pstmt3.setString(1, chosen_degree);
                ResultSet units_left = pstmt3.executeQuery();
               
                int total_units = 0;
                int lower_req = 0, upper_req = 0, tech_req = 0;
                int department_id = 0;

                while(units_left.next()) {
                    lower_req = units_left.getInt(1);
                    upper_req = units_left.getInt(2);
                    tech_req  = units_left.getInt(3);
                    department_id = units_left.getInt(4);
                }
                    
                total_units = lower_req + upper_req + tech_req;

                // get the number of units the chosen student has taken 
                PreparedStatement pstmt4 = conn.prepareStatement(
                    "SELECT SUM(units::integer) " + 
                    "FROM previous_class " +
                    "WHERE student_id IN " +
                        "(SELECT student_id " + 
                        " FROM student " +
                        " WHERE student_ssn = ?) "
                );
                pstmt4.setInt(1, chosen_student);
                ResultSet student_units = pstmt4.executeQuery();
                student_units.next();
                int student_unit = student_units.getInt(1);

                // get the number of units the chosen students needs in each
                // category
                
                // Calculate lower division first IN MAJOR
                PreparedStatement pstmt5 = conn.prepareStatement(
                    "SELECT SUM(units::integer) " + 
                    "FROM previous_class " + 
                    "WHERE student_id IN " +
                        "(SELECT student_id " +
                        " FROM student " + 
                        " WHERE student_ssn = ?) " +
                    "AND course_id IN " + 
                        "(SELECT course_id " + 
                        " FROM lower_division) " +
                    "AND course_id IN " + 
                        "(SELECT course_id " + 
                        " FROM course " + 
                        " WHERE course_department_id = ?) "
                );
                pstmt5.setInt(1, chosen_student);
                pstmt5.setInt(2, department_id);
                ResultSet student_lower = pstmt5.executeQuery();
                student_lower.next();
                int student_low = student_lower.getInt(1);

                // calculate upper division IN MAJOR
                PreparedStatement pstmt6 = conn.prepareStatement(
                    "SELECT SUM(units::integer) " + 
                    "FROM previous_class " + 
                    "WHERE student_id IN " +
                        "(SELECT student_id " +
                        " FROM student " + 
                        " WHERE student_ssn = ?) " +
                    "AND course_id NOT IN " + 
                        "(SELECT course_id " + 
                        " FROM lower_division) " +
                    "AND course_id IN " +
                        "(SELECT course_id " +
                        " FROM course " + 
                        " WHERE course_department_id = ?) "
                );
                pstmt6.setInt(1, chosen_student);
                pstmt6.setInt(2, department_id);
                ResultSet student_upper = pstmt6.executeQuery();
                student_upper.next();
                int student_up = student_upper.getInt(1);

                // calculate tech elective units
                PreparedStatement pstmt7 = conn.prepareStatement(
                    "SELECT SUM(units::integer) " + 
                    "FROM previous_class " + 
                    "WHERE student_id IN " +
                        "(SELECT student_id " +
                        " FROM student " + 
                        " WHERE student_ssn = ?) " +
                    "AND course_id IN " + 
                        "(SELECT course_id " + 
                        " FROM tech_elective) " 
                );
                pstmt7.setInt(1, chosen_student);
                ResultSet student_tech = pstmt7.executeQuery();
                student_tech.next();
                int student_tec = student_tech.getInt(1);
            %>
            
            <TABLE BORDER="1">
                <%-- format the undergrad results --%>
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
    
                <%-- format the degree information results --%>
                <TR>
                    <TH>Degree Name</TH>
                    <TH>Degree Type</TH>
                    <TH>Units Total</TH>
                    <TH>Units Taken</TH>
                    <TH>Units Needed</TH>
                    <TH>Lower Div Needed</TH>
                    <TH>Upper Div Needed</TH>
                    <TH>Tech Needed</TH>
                </TR>

                <% while(display_degree.next()) { %>
                <TR>
                    <TD> <%= display_degree.getString(1) %></TD>
                    <TD> <%= display_degree.getString(2) %></TD>
                    <TD> <%= total_units %></TD>
                    <TD> <%= student_unit %></TD>
                    <TD> <%= total_units - student_unit %></TD>
                    <TD> <%= lower_req - student_low%></TD>
                    <TD> <%= upper_req - student_up%></TD>
                    <TD> <%= tech_req -  student_tec%></TD>
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


           
