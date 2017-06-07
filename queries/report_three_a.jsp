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
            <TABLE BORDER="1">
                <TR>
                    <TH>Course Id</TH>
                    <TH>Professor Name</TH>
                    <TH>Quarter</TH>
                    <TH>Insert</TH>
                </TR>
                <form action="report_three_a.jsp">
                    <input type="hidden" name="choose_student">
                    <TH><input value="" name="COURSEID"  size="10"></TH>
                    <TH><input value="" name="PROFESSOR" size="10"></TH>
                    <TH><input value="" name="QUARTER"   size="10"></TH>
                    <TH><input type="submit" value="Submit"></TH>
                </form>
            </TABLE>

            <p></p>

            <%
                // java block for using the view
                PreparedStatement faculty_course = conn.prepareStatement(
                    "SELECT * " +
                    "FROM cpgq " + 
                    "WHERE course_id = ? AND faculty_name = ? AND quarter = ? "
                );

                faculty_course.setInt(1, Integer.parseInt(request.getParameter("COURSEID")));
                faculty_course.setString(2, request.getParameter("PROFESSOR"));
                faculty_course.setString(3, request.getParameter("QUARTER"));

                ResultSet faculty_course_rs = faculty_course.executeQuery();
            %>
            
            <% while(faculty_course_rs.next()) { %>
                <TABLE BORDER="1">
                    <TR>
                        <TH>Professor</TH>
                        <TH>Course Id</TH>
                        <TH>Quarter</TH>
                        <TH>Count</TH>
                        <TH>Grade</TH>
                    </TR>

                    <TR>
                        <TD> <%= faculty_course_rs.getString(1) %></%D>
                        <TD> <%= faculty_course_rs.getInt(2)    %></%D>
                        <TD> <%= faculty_course_rs.getString(3) %></%D>
                        <TD> <%= faculty_course_rs.getInt(4)    %></%D>
                        <TD> <%= faculty_course_rs.getString(5) %></%D>
                    <TR>
                </TABLE>
            <% } %>
            
            <p></p>

            <%
                // used for 3.a.iii
                PreparedStatement faculty_history = conn.prepareStatement(
                    "SELECT * " + 
                    "FROM cpg " + 
                    "WHERE course_id = ? AND faculty_name = ? "
                );

                faculty_history.setInt(1, Integer.parseInt(request.getParameter("COURSEID")));
                faculty_history.setString(2, request.getParameter("PROFESSOR"));

                ResultSet faculty_history_rs = faculty_history.executeQuery();
            %>
            
            <% while(faculty_history_rs.next()) { %>
                <TABLE BORDER="1">
                    <TR>
                        <TH>Professor</TH>
                        <TH>Course Id</TH>
                        <TH>Count</TH>
                        <TH>Grade</TH>
                    </TR>

                    <TR>
                        <TD> <%= faculty_history_rs.getString(1) %></%D>
                        <TD> <%= faculty_history_rs.getInt(2)    %></%D>
                        <TD> <%= faculty_history_rs.getInt(3)    %></%D>
                        <TD> <%= faculty_history_rs.getString(4) %></%D>
                    <TR>
                </TABLE>
            <% } %>

            <p>SPLIT: VIEW ABOVE. REGULAR TABLE BELOW</p>

            <%
                //split the substring of the quarter to work with the faculty
                //teaching table
                String quarter = request.getParameter("QUARTER").substring(0,2); //FA
                String year    = request.getParameter("QUARTER").substring(2,6); //2014
                String quarter_year = quarter + year;

                // produce count of grades given by professor y at quarter z to
                // students taking course X
                PreparedStatement pstmt1 = conn.prepareStatement(
                    // get a grades
                    "SELECT COUNT(grade) " +
                    "FROM previous_class " +
                    "WHERE quarter = ? " +
                    "AND (grade = 'A' OR grade = 'A+' OR grade ='A-') " +
                    "AND course_id IN ( " +
                        // get the course ID from faculty teaching given current
                        // quarter and facutly member
                        "SELECT course_id " +
                        "FROM faculty_teaching " +
                        "WHERE quarter = ? AND year = ? AND faculty_name = ?) " +
                        "AND course_id = ? "
                );

                PreparedStatement pstmt2 = conn.prepareStatement(
                    // get b grades
                    "SELECT COUNT(grade) " +
                    "FROM previous_class " +
                    "WHERE quarter = ? " +
                    "AND (grade = 'B' OR grade = 'B+' OR grade ='B-') " +
                    "AND course_id IN ( " +
                        // get the course ID from faculty teaching given current
                        // quarter and facutly member
                        "SELECT course_id " +
                        "FROM faculty_teaching " +
                        "WHERE quarter = ? AND year = ? AND faculty_name = ?) "  +
                        "AND course_id = ? "
                );

                PreparedStatement pstmt3 = conn.prepareStatement(
                    // get c grades
                    "SELECT COUNT(grade) " +
                    "FROM previous_class " +
                    "WHERE quarter = ? " +
                    "AND (grade = 'C' OR grade = 'C+' OR grade ='C-') " +
                    "AND course_id IN ( " +
                        // get the course ID from faculty teaching given current
                        // quarter and facutly member
                        "SELECT course_id " +
                        "FROM faculty_teaching " +
                        "WHERE quarter = ? AND year = ? AND faculty_name = ?) " +
                        "AND course_id = ? "
                );

                PreparedStatement pstmt4 = conn.prepareStatement(
                    // get d grades
                    "SELECT COUNT(grade) " +
                    "FROM previous_class " +
                    "WHERE quarter = ? AND grade = 'D' AND course_id IN ( " +
                        // get the course ID from faculty teaching given current
                        // quarter and facutly member
                        "SELECT course_id " +
                        "FROM faculty_teaching " +
                        "WHERE quarter = ? AND year = ? AND faculty_name = ?) " +
                        "AND course_id = ? "
                );

                PreparedStatement pstmt5 = conn.prepareStatement(
                    // get other grades
                    "SELECT COUNT(grade) " +
                    "FROM previous_class " +
                    "WHERE quarter = ? AND " +
                    " (grade != 'A' AND grade != 'A+' AND grade != 'A-' " +
                    "  AND grade != 'B' AND grade != 'B+' AND grade != 'B-' " +
                    "  AND grade != 'C' AND grade != 'C+' AND grade != 'C-' " +
                    "  AND grade != 'D' AND grade != 'D+' AND grade != 'D-') " +
                    "AND course_id IN ( " +
                        // get the course ID from faculty teaching given current
                        // quarter and facutly member
                        "SELECT course_id " +
                        "FROM faculty_teaching " +
                        "WHERE quarter = ? AND year = ? AND faculty_name = ?) " +
                        "AND course_id = ? "
                );


                // for a grade query
                pstmt1.setString(1, quarter_year);
                pstmt1.setString(2, quarter);
                pstmt1.setString(3, year);
                pstmt1.setString(4, request.getParameter("PROFESSOR"));
                pstmt1.setInt(5, Integer.parseInt(request.getParameter("COURSEID")));

                // for b grade query
                pstmt2.setString(1, quarter_year);
                pstmt2.setString(2, quarter);
                pstmt2.setString(3, year);
                pstmt2.setString(4, request.getParameter("PROFESSOR"));
                pstmt2.setInt(5, Integer.parseInt(request.getParameter("COURSEID")));

                // for c grade query
                pstmt3.setString(1, quarter_year);
                pstmt3.setString(2, quarter);
                pstmt3.setString(3, year);
                pstmt3.setString(4, request.getParameter("PROFESSOR"));
                pstmt3.setInt(5, Integer.parseInt(request.getParameter("COURSEID")));

                // for d grade query
                pstmt4.setString(1, quarter_year);
                pstmt4.setString(2, quarter);
                pstmt4.setString(3, year);
                pstmt4.setString(4, request.getParameter("PROFESSOR"));
                pstmt4.setInt(5, Integer.parseInt(request.getParameter("COURSEID")));

                // for "other" grade query
                pstmt5.setString(1, quarter_year);
                pstmt5.setString(2, quarter);
                pstmt5.setString(3, year);
                pstmt5.setString(4, request.getParameter("PROFESSOR"));
                pstmt5.setInt(5, Integer.parseInt(request.getParameter("COURSEID")));

                ResultSet rs1 = pstmt1.executeQuery();
                ResultSet rs2 = pstmt2.executeQuery();
                ResultSet rs3 = pstmt3.executeQuery();
                ResultSet rs4 = pstmt4.executeQuery();
                ResultSet rs5 = pstmt5.executeQuery();

                while(rs1.next()) { %>
                    <TABLE BORDER="1">
                        <TR>
                            <TH>Course Id</TH>
                            <TH>Professor</TH>
                            <TH>Quarter</TH>
                            <TH>Number of A Grades</TH>
                        </TR>

                        <TR>
                            <TD> <%= request.getParameter("COURSEID")  %></%D>
                            <TD> <%= request.getParameter("PROFESSOR") %></%D>
                            <TD> <%= quarter_year %></%D>
                            <TD> <%= rs1.getInt(1) %></%D>
                        <TR>
                    </TABLE>
                <% }

                while(rs2.next()) { %>
                    <TABLE BORDER="1">
                        <TR>
                            <TH>Course Id</TH>
                            <TH>Professor</TH>
                            <TH>Quarter</TH>
                            <TH>Number of B Grades</TH>
                        </TR>

                        <TR>
                            <TD> <%= request.getParameter("COURSEID")  %></%D>
                            <TD> <%= request.getParameter("PROFESSOR") %></%D>
                            <TD> <%= quarter_year %></%D>
                            <TD> <%= rs2.getInt(1) %></%D>
                        <TR>
                    </TABLE>
                <% }

                while(rs3.next()) { %>
                    <TABLE BORDER="1">
                        <TR>
                            <TH>Course Id</TH>
                            <TH>Professor</TH>
                            <TH>Quarter</TH>
                            <TH>Number of C Grades</TH>
                        </TR>

                        <TR>
                            <TD> <%= request.getParameter("COURSEID")  %></%D>
                            <TD> <%= request.getParameter("PROFESSOR") %></%D>
                            <TD> <%= quarter_year %></%D>
                            <TD> <%= rs3.getInt(1) %></%D>
                        <TR>
                    </TABLE>
                <% }

                while(rs4.next()) { %>
                    <TABLE BORDER="1">
                        <TR>
                            <TH>Course Id</TH>
                            <TH>Professor</TH>
                            <TH>Quarter</TH>
                            <TH>Number of D Grades</TH>
                        </TR>

                        <TR>
                            <TD> <%= request.getParameter("COURSEID")  %></%D>
                            <TD> <%= request.getParameter("PROFESSOR") %></%D>
                            <TD> <%= quarter_year %></%D>
                            <TD> <%= rs4.getInt(1) %></%D>
                        <TR>
                    </TABLE>
                <% }

                while(rs5.next()) { %>
                    <TABLE BORDER="1">
                        <TR>
                            <TH>Course Id</TH>
                            <TH>Professor</TH>
                            <TH>Quarter</TH>
                            <TH>Number of Other Grades</TH>
                        </TR>

                        <TR>
                            <TD> <%= request.getParameter("COURSEID")  %></%D>
                            <TD> <%= request.getParameter("PROFESSOR") %></%D>
                            <TD> <%= quarter_year %></%D>
                            <TD> <%= rs5.getInt(1) %></%D>
                        <TR>
                    </TABLE>
                <% }

            %>
            
            <%
                // find the grade distribution for professor Y over the 
                // years
                PreparedStatement pstmt6 = conn.prepareStatement(

                    // given course ID, find when the professor taught it
                    "SELECT COUNT(grade) " + 
                    "FROM previous_class " + 
                    "WHERE (grade = ? OR grade = ? OR grade = ?) " +
                    "AND course_id = ? " + 
                    "AND quarter IN " + 
                        "(SELECT quarter || year " + 
                        "FROM faculty_teaching " + 
                        "WHERE faculty_name = ? " + 
                        "AND course_id = ?) " 
                );

                // get A grades
                pstmt6.setString(1, "A");
                pstmt6.setString(2, "A+");
                pstmt6.setString(3, "A-");
                pstmt6.setInt(4, Integer.parseInt(request.getParameter("COURSEID")));
                pstmt6.setString(5, request.getParameter("PROFESSOR"));
                pstmt6.setInt(6, Integer.parseInt(request.getParameter("COURSEID")));
                ResultSet rsA = pstmt6.executeQuery();

                while(rsA.next()) { %>
                <p></p>
                <b>Historical Grade Distribution for Class and Professor</b>

                    <TABLE BORDER="1">
                        <TR>
                            <TH>Professor</TH>
                            <TH>Number of A Grades</TH>
                        </TR>

                        <TR>
                            <TD> <%= request.getParameter("PROFESSOR") %></%D>
                            <TD> <%= rsA.getInt(1) %></%D>
                        <TR>
                    </TABLE>
                <% } 


                // get B grades
                pstmt6.setString(1, "B");
                pstmt6.setString(2, "B+");
                pstmt6.setString(3, "B-");
                pstmt6.setInt(4, Integer.parseInt(request.getParameter("COURSEID")));
                pstmt6.setString(5, request.getParameter("PROFESSOR"));
                pstmt6.setInt(6, Integer.parseInt(request.getParameter("COURSEID")));
                ResultSet rsB = pstmt6.executeQuery();

                while(rsB.next()) { %>

                    <TABLE BORDER="1">
                        <TR>
                            <TH>Professor</TH>
                            <TH>Number of B Grades</TH>
                        </TR>

                        <TR>
                            <TD> <%= request.getParameter("PROFESSOR") %></%D>
                            <TD> <%= rsB.getInt(1) %></%D>
                        <TR>
                    </TABLE>
                <% } 


                // get C grades
                pstmt6.setString(1, "C");
                pstmt6.setString(2, "C+");
                pstmt6.setString(3, "C-");
                pstmt6.setInt(4, Integer.parseInt(request.getParameter("COURSEID")));
                pstmt6.setString(5, request.getParameter("PROFESSOR"));
                pstmt6.setInt(6, Integer.parseInt(request.getParameter("COURSEID")));
                ResultSet rsC = pstmt6.executeQuery();

                while(rsC.next()) { %>

                    <TABLE BORDER="1">
                        <TR>
                            <TH>Professor</TH>
                            <TH>Number of C Grades</TH>
                        </TR>

                        <TR>
                            <TD> <%= request.getParameter("PROFESSOR") %></%D>
                            <TD> <%= rsC.getInt(1) %></%D>
                        <TR>
                    </TABLE>
                <% } 


                // get D grades
                pstmt6.setString(1, "D");
                pstmt6.setString(2, "D+");
                pstmt6.setString(3, "D-");
                pstmt6.setInt(4, Integer.parseInt(request.getParameter("COURSEID")));
                pstmt6.setString(5, request.getParameter("PROFESSOR"));
                pstmt6.setInt(6, Integer.parseInt(request.getParameter("COURSEID")));
                ResultSet rsD = pstmt6.executeQuery();


                while(rsD.next()) { %>

                    <TABLE BORDER="1">
                        <TR>
                            <TH>Professor</TH>
                            <TH>Number of D Grades</TH>
                        </TR>

                        <TR>
                            <TD> <%= request.getParameter("PROFESSOR") %></%D>
                            <TD> <%= rsD.getInt(1) %></%D>
                        <TR>
                    </TABLE>
                <% } 

                // get OTHER grades
                pstmt6.setString(1, "F");
                pstmt6.setString(2, "F+");
                pstmt6.setString(3, "F-");
                pstmt6.setInt(4, Integer.parseInt(request.getParameter("COURSEID")));
                pstmt6.setString(5, request.getParameter("PROFESSOR"));
                pstmt6.setInt(6, Integer.parseInt(request.getParameter("COURSEID")));
                ResultSet rsF = pstmt6.executeQuery();


                while(rsF.next()) { %>

                    <TABLE BORDER="1">
                        <TR>
                            <TH>Professor</TH>
                            <TH>Number of Other Grades</TH>
                        </TR>

                        <TR>
                            <TD> <%= request.getParameter("PROFESSOR") %></%D>
                            <TD> <%= rsF.getInt(1) %></%D>
                        <TR>
                    </TABLE>
                <% } 

    
            %>
            
            <%
                // given course ID X, produce count of grades given to students 
                PreparedStatement pstmt7 = conn.prepareStatement( 
                    "SELECT COUNT(grade) " + 
                    "FROM previous_class " + 
                    "WHERE (grade = ? OR grade = ? OR grade = ?) " +
                    "AND course_id = ? "
                );

                // get A grades
                pstmt7.setString(1, "A");
                pstmt7.setString(2, "A+");
                pstmt7.setString(3, "A-");
                pstmt7.setInt(4, Integer.parseInt(request.getParameter("COURSEID")));
                ResultSet A = pstmt7.executeQuery();

                while(A.next()) { %>
                <p></p>
                <b>Course Grade Distribution</b>

                    <TABLE BORDER="1">
                        <TR>
                            <TH>Course ID</TH>
                            <TH>Number of A Grades</TH>
                        </TR>

                        <TR>
                            <TD> <%= request.getParameter("COURSEID") %></%D>
                            <TD> <%= A.getInt(1) %></%D>
                        <TR>
                    </TABLE>
                <% } 

                // get B grades
                pstmt7.setString(1, "B");
                pstmt7.setString(2, "B+");
                pstmt7.setString(3, "B-");
                pstmt7.setInt(4, Integer.parseInt(request.getParameter("COURSEID")));
                ResultSet B = pstmt7.executeQuery();
                
                while(B.next()) { %>

                    <TABLE BORDER="1">
                        <TR>
                            <TH>Course ID</TH>
                            <TH>Number of B Grades</TH>
                        </TR>

                        <TR>
                            <TD> <%= request.getParameter("COURSEID") %></%D>
                            <TD> <%= B.getInt(1) %></%D>
                        <TR>
                    </TABLE>
                <% } 

                // get C grades
                pstmt7.setString(1, "C");
                pstmt7.setString(2, "C+");
                pstmt7.setString(3, "C-");
                pstmt7.setInt(4, Integer.parseInt(request.getParameter("COURSEID")));
                ResultSet C = pstmt7.executeQuery();

                while(C.next()) { %>

                    <TABLE BORDER="1">
                        <TR>
                            <TH>Course ID</TH>
                            <TH>Number of C Grades</TH>
                        </TR>

                        <TR>
                            <TD> <%= request.getParameter("COURSEID") %></%D>
                            <TD> <%= C.getInt(1) %></%D>
                        <TR>
                    </TABLE>
                <% } 

                // get D grades
                pstmt7.setString(1, "D");
                pstmt7.setString(2, "D+");
                pstmt7.setString(3, "D-");
                pstmt7.setInt(4, Integer.parseInt(request.getParameter("COURSEID")));
                ResultSet D = pstmt7.executeQuery();

                while(D.next()) { %>

                    <TABLE BORDER="1">
                        <TR>
                            <TH>Course ID</TH>
                            <TH>Number of D Grades</TH>
                        </TR>

                        <TR>
                            <TD> <%= request.getParameter("COURSEID") %></%D>
                            <TD> <%= D.getInt(1) %></%D>
                        <TR>
                    </TABLE>
                <% } 

                // get F grades
                pstmt7.setString(1, "F");
                pstmt7.setString(2, "F+");
                pstmt7.setString(3, "F-");
                pstmt7.setInt(4, Integer.parseInt(request.getParameter("COURSEID")));
                ResultSet F = pstmt7.executeQuery();

                while(F.next()) { %>

                    <TABLE BORDER="1">
                        <TR>
                            <TH>Course ID</TH>
                            <TH>Number of Other Grades</TH>
                        </TR>

                        <TR>
                            <TD> <%= request.getParameter("COURSEID") %></%D>
                            <TD> <%= F.getInt(1) %></%D>
                        <TR>
                    </TABLE>
                <% } 
            %>
            
            <%
                // calculate GPA for professor Y of course X
                
                // select the courses that professor Y taught
                PreparedStatement pstmt8 = conn.prepareStatement(
                "SELECT grade, units " + 
                "FROM previous_class " + 
                "WHERE course_id = ? " + 
                "AND quarter IN " + 
                    "(SELECT quarter || year " + 
                    " FROM faculty_teaching " + 
                    " WHERE faculty_name = ? " + 
                    " AND course_id = ?) " 
                );

                // query to get the grade weight
                PreparedStatement pstmt9 = conn.prepareStatement(
                    "SELECT number_grade " + 
                    "FROM grade_conversion " + 
                    "WHERE letter_grade = ? " 
                );

                pstmt8.setInt(1, Integer.parseInt(request.getParameter("COURSEID")));
                pstmt8.setString(2, request.getParameter("PROFESSOR"));
                pstmt8.setInt(3, Integer.parseInt(request.getParameter("COURSEID")));
                ResultSet prof_gpa = pstmt8.executeQuery();

                float gpa = 0;
                int unit  = 0;

                while(prof_gpa.next()) {
                    // grab the weight
                    pstmt9.setString(1, prof_gpa.getString(1));
                    ResultSet gpa_weight = pstmt9.executeQuery();

                    while(gpa_weight.next()) {
                        gpa += gpa_weight.getFloat(1) * prof_gpa.getInt(2);
                    }

                    unit += prof_gpa.getInt(2);
                }

                %>
                <p></p>
                <b>Course GPA by Professor</b>
                
                <TABLE BORDER="1">
                    <TR>
                        <TH>Professor</TH>
                        <TH>Course</TH>
                        <TH>GPA</TH>
                    </TR>

                    <TR>
                        <TD><%= request.getParameter("PROFESSOR") %></TD>
                        <TD><%= request.getParameter("COURSEID")  %></TD>
                        <TD><%= gpa / unit %></TD>
                <%

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
