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
                        "WHERE quarter = ? AND year = ? AND faculty_name = ?) " 
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
                        "WHERE quarter = ? AND year = ? AND faculty_name = ?) " 
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
                        "WHERE quarter = ? AND year = ? AND faculty_name = ?) " 
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
                        "WHERE quarter = ? AND year = ? AND faculty_name = ?) "
                );

                PreparedStatement pstmt5 = conn.prepareStatement( 
                    // get d grades
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
                        "WHERE quarter = ? AND year = ? AND faculty_name = ?) "
                );


                // for a grade query
                pstmt1.setString(1, quarter_year);
                pstmt1.setString(2, quarter);
                pstmt1.setString(3, year);
                pstmt1.setString(4, request.getParameter("PROFESSOR"));
                
                // for b grade query
                pstmt2.setString(1, quarter_year);
                pstmt2.setString(2, quarter);
                pstmt2.setString(3, year);
                pstmt2.setString(4, request.getParameter("PROFESSOR"));

                // for c grade query
                pstmt3.setString(1, quarter_year);
                pstmt3.setString(2, quarter);
                pstmt3.setString(3, year);
                pstmt3.setString(4, request.getParameter("PROFESSOR"));

                // for d grade query
                pstmt4.setString(1, quarter_year);
                pstmt4.setString(2, quarter);
                pstmt4.setString(3, year);
                pstmt4.setString(4, request.getParameter("PROFESSOR"));
            
                // for "other" grade query
                pstmt5.setString(1, quarter_year);
                pstmt5.setString(2, quarter);
                pstmt5.setString(3, year);
                pstmt5.setString(4, request.getParameter("PROFESSOR"));

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
                    "SELECT COUNT(grade) " +
                    "FROM previous_class " + 
                    "WHERE (grade = ? OR grade = ? OR grade = ?) " +
                    "AND course_id IN ( "+
                        // get all courses taught by given faculty
                        "SELECT course_id " + 
                        "FROM faculty_teaching " +
                        "WHERE faculty_name = ?) " +
                    "AND quarter IN ( " +
                        // get all quarters taught by given faculty
                        // string concat in PSQL = ||
                        "SELECT quarter || year " + 
                        "FROM faculty_teaching " + 
                        "WHERE faculty_name = ?) " 
                );

                // get A grades
                pstmt6.setString(1, "A");
                pstmt6.setString(2, "A+");
                pstmt6.setString(3, "A-");
                pstmt6.setString(4, request.getParameter("PROFESSOR"));
                pstmt6.setString(5, request.getParameter("PROFESSOR"));
                ResultSet rsA = pstmt6.executeQuery();

                while(rsA.next()) { %>
                <p></p>
                <b>Historical Grade Distribution</b>

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
                pstmt6.setString(4, request.getParameter("PROFESSOR"));
                pstmt6.setString(5, request.getParameter("PROFESSOR"));
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
                pstmt6.setString(4, request.getParameter("PROFESSOR"));
                pstmt6.setString(5, request.getParameter("PROFESSOR"));
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
                pstmt6.setString(4, request.getParameter("PROFESSOR"));
                pstmt6.setString(5, request.getParameter("PROFESSOR"));
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
                pstmt6.setString(2, "F");
                pstmt6.setString(3, "F");
                pstmt6.setString(4, request.getParameter("PROFESSOR"));
                pstmt6.setString(5, request.getParameter("PROFESSOR"));
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
