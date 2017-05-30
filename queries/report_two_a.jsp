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
            
            <b>Current classes of student</b>

            <% 
                Statement curr_student = conn.createStatement();
                
                // Grab all students of the current quarter
                ResultSet rs = curr_student.executeQuery
                    ("SELECT student_ssn FROM student WHERE student_id IN " +
                     "(SELECT student_id FROM enrolled_student)");
            %>
            
            <%-- HTML select code --%>
            <form action="report_two_a.jsp">
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
                    "student_last_name, student_id FROM student WHERE student_ssn = ?"
                );
                pstmt.setInt(1, chosen_student);
                ResultSet display_student = pstmt.executeQuery();

                int student_id = 0;
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
                    <% student_id = display_student.getInt(5); %>
                </TR>
                <% } %>
            </TABLE>

            <%-- show overlaps with current enrolled classes and other offered classes --%>
            <%
                // get all information about a student's currently enrolled
                // class
                PreparedStatement pstmt2 = conn.prepareStatement(
                    "SELECT * " +
                    "FROM current_quarter " + 
                    "WHERE section_number IN " +
                        "(SELECT section_id " + 
                        " FROM enrolled_student " + 
                        " WHERE student_id = ?) "
                );
            
                // get all information about classes that student is NOT
                // enrolled in
                PreparedStatement pstmt3 = conn.prepareStatement(
                    "SELECT * " + 
                    "FROM current_quarter " + 
                    "WHERE section_number != ? " 
                );

                // get the course title of classes
                PreparedStatement pstmt4 = conn.prepareStatement(
                    "SELECT course_title " + 
                    "FROM course " + 
                    "WHERE course_id = ? " 
                );

                pstmt2.setInt(1, student_id);
                ResultSet rs2 = pstmt2.executeQuery();

                // look for conflicting times, loop over each currently enrolled
                // class and display all classes that conflict with that class
                while(rs2.next()) {
                    // look at lecture days first. Parse string containing days
                    String days = rs2.getString(5);
                    String delim = "[,]";
                    String [] enroll_days = days.split(delim);

                    // parse the string containing the time
                    String time = rs2.getString(6);
                    String [] enroll_time = time.split(delim);

                    String [] enroll_dis_days;
                    String [] enroll_dis_time; 

                    // parse the string containing dicussion days and times
                    if(rs2.getString(7) != null)
                        enroll_dis_days = rs2.getString(7).split(delim);

                    if(rs2.getString(8) != null)
                        enroll_dis_time = rs2.getString(8).split(delim);

                    // check every class that is not compatible
                    pstmt3.setInt(1, rs2.getInt(1));
                    ResultSet rs3 = pstmt3.executeQuery();


                    while(rs3.next()) {
                        // grab the days of each NON ENROLLED class
                        days = rs3.getString(5);
                        String [] other_days = days.split(delim);

                        // grab the time of each NON ENROLLED class
                        time = rs3.getString(6);
                        String [] other_time = time.split(delim);

                        // grab the day and time of NON ENROLLED discussion
                        String [] other_dis_day;
                        String [] other_dis_time; 

                        if(rs3.getString(7) != null)
                            other_dis_day = rs3.getString(7).split(delim);
                        
                        if(rs3.getString(8) != null)
                            other_dis_time = rs3.getString(8).split(delim);

                        // nested for loop to check every ENROLLED day with
                        // every NON ENROLLED day
                        boolean has_conflict = false;

                        for(int i = 0; i < enroll_days.length; i++) {
                            for (int j = 0; j < other_days.length; j++) {
                                // if the days match
                                if(enroll_days[i].equals(other_days[j])) {
                                    // check the time. If the times, match, we
                                    // know there's a conflict. leave the loop
                                    if(enroll_time[0].equals(other_time[0])) {
                                        if(enroll_time[1].equals(other_time[1])) {
                                            has_conflict = true;
                                        }
                                    }
                                }
                            }

                            if(has_conflict) {
                                // send the course ID to pstmt4 to grab the
                                // course title of the CONFLICTING, NON ENROLLED
                                // course
                                pstmt4.setInt(1, rs3.getInt(2));
                                ResultSet rs4 = pstmt4.executeQuery();
                                rs4.next();
                                String conflict_title = rs4.getString(1);
                                int conflict_sec_id   = rs3.getInt(1);

                                // now grab the title of the ENROLLED course
                                pstmt4.setInt(1, rs2.getInt(2));
                                rs4 = pstmt4.executeQuery();
                                rs4.next();
                                String enrolled_title = rs4.getString(1);
                                int enrolled_sec_id   = rs2.getInt(1);

                                %>
                                
                                <%-- HTML for nice output --%>
                                <TABLE BORDER="1">
                                    <TR>
                                        <TH>Non-Enrolled Conflicting Course Title</TH>
                                        <TH>Non-Enrolled Conflicting Section Number</TH>
                                        <TH>Enrolled Conflicting Course Title</TH>
                                        <TH>Enrolled Conflicting Section Number</TH>
                                    </TR>

                                    <TR>
                                        <TD> <%= conflict_title %></TD>
                                        <TD> <%= conflict_sec_id %></TD>
                                        <TD> <%= enrolled_title %></TD>
                                        <TD> <%= enrolled_sec_id %></TD>
                                    </TR>
                                </TABLE>

                                <%
                                break;
                            }
                        }
                    }// while rs3.next
                }//while rs2.next
            %>

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
