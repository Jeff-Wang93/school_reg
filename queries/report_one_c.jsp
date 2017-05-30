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
            <%@ page language="java" import="java.sql.*" import="java.util.*" %>
    
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
                
                // Grab all students ever
                ResultSet rs = student.executeQuery(
                    "SELECT student_ssn " +
                    "FROM student " + 
                    "WHERE student_id IN " +
                        "(SELECT student_id " + 
                        " FROM enrolled_student)" +
                    "OR student_id IN " + 
                        "(SELECT student_id " + 
                        " FROM previous_class) " 
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
                    "SELECT x.*, y.quarter, y.grade, y.units " +
                    "FROM classes x, previous_class y " +
                    "WHERE x.classes_course_id = y.course_id AND y.student_id = ? " +
                    "ORDER BY y.year, y.quarter "
                );
                pstmt2.setInt(1, student_id);
                ResultSet prev_class = pstmt2.executeQuery();
            %>
            
            <%-- format the results --%>
            <TABLE BORDER="1">
                <TR>
                    <TH>Class ID</TH>
                    <TH>Class Title</TH>
                    <TH>Class Quarter</TH>
                    <TH>Course ID</TH>
                    <TH>Class Currently Offered?</TH>
                    <TH>Class Next Offering</TH>
                    <TH>Quarter</TH>
                    <TH>Grade</TH>
                    <TH>Units</TH>
                </TR>

                <% while(prev_class.next()) { %>
                <TR>
                    <TD> <%= prev_class.getInt(1) %></TD>
                    <TD> <%= prev_class.getString(2) %></TD>
                    <TD> <%= prev_class.getString(3) %></TD>
                    <TD> <%= prev_class.getString(4) %></TD>
                    <TD> <%= prev_class.getString(5) %></TD>
                    <TD> <%= prev_class.getString(6) %></TD>
                    <TD> <%= prev_class.getString(7) %></TD>
                    <TD> <%= prev_class.getString(8) %></TD>
                    <TD> <%= prev_class.getString(9) %></TD>
                </TR>
                <% } %>
            </TABLE>

            <%-- Calculate GPA per quarter here --%>
            <%
                String curr_quarter1 = "";
                String curr_quarter2 = "";
                float  gpa  = 0;
                int    unit = 0;

                float gpa_total  = 0;
                int   total_unit = 0;

                List<Float> gpa_quarter   = new ArrayList();
                List<Float> gpa_arry      = new ArrayList();
                List<String> quarter      = new ArrayList();
                List<String> quarter_arry = new ArrayList();
                List<Integer> unit_total  = new ArrayList();

                // create fresh new result set
                PreparedStatement pstmt3 = conn.prepareStatement(
                    "SELECT x.*, y.quarter, y.grade, y.units " +
                    "FROM classes x, previous_class y " +
                    "WHERE x.classes_course_id = y.course_id AND y.student_id = ? " +
                    "ORDER BY y.year, y.quarter "
                );
                pstmt3.setInt(1, student_id);
                ResultSet prev_class_copy = pstmt3.executeQuery();

                // grab the values out of the resultset and into an arraylist
                while (prev_class_copy.next()) {
                    //gpa_quarter.add(Float.parseFloat(prev_class_copy.getString(8)));
                    quarter.add(prev_class_copy.getString(7));
                    unit_total.add(Integer.parseInt(prev_class_copy.getString(9)));

                    // grab the actual GPA weights
                    PreparedStatement pstmt4 = conn.prepareStatement(
                        "SELECT number_grade " + 
                        "FROM grade_conversion " + 
                        "WHERE letter_grade = ? " 
                    );
                    pstmt4.setString(1, prev_class_copy.getString(8));
                    ResultSet gpa_weight = pstmt4.executeQuery();
                    gpa_weight.next();
                    gpa_quarter.add(gpa_weight.getFloat(1));
                }

                // the two arraylist should always be the same size
                for (int i = 0; i < gpa_quarter.size(); i++) {
                    gpa  += gpa_quarter.get(i) * unit_total.get(i);
                    unit += unit_total.get(i);
                    curr_quarter1 = quarter.get(i);
                
                    // if the quarter changes
                    if (!curr_quarter1.equals(curr_quarter2)) {
                        curr_quarter2 = curr_quarter1;
                        gpa_total += gpa;
                        total_unit += unit;
                        
                        gpa_arry.add(gpa/unit);
                        quarter_arry.add(curr_quarter2);
                        //reset variables
                        gpa = 0;
                        unit = 0;
                    }
                }

                gpa_total = gpa_total/total_unit;
            %>
            
            <p></p>

            <%-- format gpa results --%>
            <TABLE BORDER="1">
                <TR>
                    <TH>Quarter</TH>
                    <TH>GPA</TH>
                </TR>
                
                <% for(int i = 0; i < gpa_arry.size(); i++) { %>
                <TR>
                    <TD> <%=quarter_arry.get(i) %></TD>
                    <TD> <%=gpa_arry.get(i) %></TD>
                </TR>
                <% } %>
            </TABLE>

            <p></p>

            <b>
                Total GPA:
                <%
                    out.println(gpa_total);
                %>
            </b>


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
