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
            <%@ page language="java" import="java.sql.*" import="java.util.*"%>
    
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
            
            <b>Current undergrad student</b>

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
                            " (SELECT master_student_id " +
                            "  FROM master_student)) "
                );
            %>
            
            <% 
                Statement curr_degree = conn.createStatement();
                
                // Grab all MS degrees 
                ResultSet rs2 = curr_degree.executeQuery(
                    "SELECT degree_name " +
                    "FROM degree " +
                    "WHERE degree_type = 'MS'"
                );
            %>

            <%-- Get all info about current undergrad student --%>
            <%-- HTML select code --%>
            <form action="report_one_e.jsp">
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
                    "SELECT degree_name, degree_type, degree_id " +
                    "FROM degree " +
                    "WHERE degree_name = ? AND degree_type = 'BS'"
                );
                pstmt2.setString(1, chosen_degree);
                ResultSet display_degree = pstmt2.executeQuery();

                // list NAME of completed concentrations
                PreparedStatement pstmt3 = conn.prepareStatement(
                    "SELECT * " +
                    "FROM ms_concentration " 
                );
                ResultSet ms_concentration = pstmt3.executeQuery();
                
                // grab all useful information from ms_concentration table
                List<Integer> con_id    = new ArrayList();
                List<Integer> units_req = new ArrayList();
                List<Float> gpa_req     = new ArrayList();
                List<String> con_name   = new ArrayList();

                while(ms_concentration.next()) {
                    con_id.add(ms_concentration.getInt(1));
                    units_req.add(ms_concentration.getInt(3));
                    gpa_req.add(ms_concentration.getFloat(4));
                    con_name.add(ms_concentration.getString(5));
                }
                
                // get the units for courses taken that count towards
                // concentrations
                PreparedStatement pstmt4 = conn.prepareStatement(
                    // get chosen student's previous courses info
                    // if they're in a certain concentration
                    "SELECT units " + 
                    "FROM previous_class " + 
                    "WHERE student_id IN " + 
                        "(SELECT student_id " + 
                        " FROM student " + 
                        " WHERE student_ssn = ?) " +
                    "AND course_id IN " + 
                        "(SELECT course_id " + 
                        " FROM degree_course " + 
                        " WHERE concentration_id = ?) "
                );

                // get grade for classes that count towrads concentration
                PreparedStatement pstmt5 = conn.prepareStatement(
                   "SELECT grade " + 
                    "FROM previous_class " + 
                    "WHERE student_id IN " + 
                        "(SELECT student_id " + 
                        " FROM student " + 
                        " WHERE student_ssn = ?) " +
                    "AND course_id IN " + 
                        "(SELECT course_id " + 
                        " FROM degree_course " + 
                        " WHERE concentration_id = ?) "
                );

                // create a preparedStatement for grade weights
                PreparedStatement pstmt6 = conn.prepareStatement(
                    "SELECT number_grade " + 
                    "FROM grade_conversion " + 
                    "WHERE letter_grade = ? " 
                );

                List<Integer> unit = new ArrayList();
                List<Float> gpa_w  = new ArrayList();

                int   total_unit = 0;
                float gpa        = 0;

                boolean at_least_one = false;

                // iterate through all concentration names and do work
                for(int i = 0; i < con_name.size(); i++) {
                    // grab all the units
                    pstmt4.setInt(1, chosen_student);
                    pstmt4.setInt(2, con_id.get(i));
                    ResultSet con_comp = pstmt4.executeQuery();

                    while(con_comp.next()) {
                        unit.add(con_comp.getInt(1));
                    }

                    //out.println(unit);
                    // calculate the GPA 
                    pstmt5.setInt(1, chosen_student);
                    pstmt5.setInt(2, con_id.get(i));
                    ResultSet gpa_comp = pstmt5.executeQuery();

                    while(gpa_comp.next()) {
                        // input the grade and grab the weight
                        pstmt6.setString(1, gpa_comp.getString(1) );
                        ResultSet gpa_weight = pstmt6.executeQuery();

                        while(gpa_weight.next()) {
                            gpa_w.add(gpa_weight.getFloat(1));
                        }
                    }

                    // units and the weights arraylists should be the same size
                    // total GPA weights
                    for(int j = 0; j < gpa_w.size(); j++) {
                        total_unit += unit.get(j);
                        gpa += unit.get(j) * gpa_w.get(j); 
                    }

                    // calculate cumulative GPA
                    gpa = gpa / total_unit;

                    // if unit == 0, then GPA = NaN
                    if(total_unit == 0) {
                        // do nothing. we know for sure the conditions arent
                        // met
                    }

                    else {
                        // does the calculated GPA meet the requirement?
                        boolean good_gpa = false;
                        if(gpa >= gpa_req.get(i))
                            good_gpa = true;

                        // does the calculated UNIT meet the requirement
                        boolean good_unit = false;
                        if(total_unit >= units_req.get(i))
                            good_unit = true;

                        // if both requirements are met, output
                        if(good_gpa && good_unit) {
                            out.println(con_name.get(i));
                            at_least_one = true;
                        }
                    }

                    // dont forget to clear the variables and arraylists
                    unit.clear();
                    gpa_w.clear();
                    total_unit = 0;
                    gpa = 0;
                }

                if(!at_least_one) 
                    out.println("No concentrations done");
            %>
            
            <%-- List courses not yet taken in each concentration and next time it is given --%>
            <%
                // get all courses not yet taken
                PreparedStatement pstmt7 = conn.prepareStatement(
                    // not in previous but in concentration
                    "SELECT c.course_title, p.classes_next " +
                    "FROM course c, classes p " + 
                    "WHERE c.course_id IN " +
                        "(SELECT DISTINCT course_id " + 
                        "FROM previous_class " + 
                        "WHERE course_id NOT IN " +
                            "(SELECT course_id " + 
                            "FROM previous_class " + 
                            "WHERE student_id IN " + 
                                "(SELECT student_id " +
                                "FROM student " + 
                                "WHERE student_ssn = ?)) " +
                        "AND c.course_id IN " +
                            "(SELECT course_id " +
                            "FROM degree_course " + 
                            "WHERE concentration_id = ?)) " +
                        "AND c.course_id = p.classes_course_id "

                );
            %>
            
            <p></p>

            <TABLE BORDER="1">
                <TR>
                    <TH>Concentration Name</TH>
                    <TH>Missing Class</TH>
                    <TH>Next Offering</TH>
                </TR>
                <% for(int l = 0; l < con_name.size(); l++) { 
                    pstmt7.setInt(1, chosen_student);
                    pstmt7.setInt(2, con_id.get(l));
                    ResultSet rs3 = pstmt7.executeQuery();

                    while(rs3.next()) {
                %>
                <TR>
                    <TD><%=con_name.get(l)%></TD>
                    <TD><%=rs3.getString(1) %></TD>
                    <TD><%=rs3.getString(2) %></TD>
                </TR>
                    <% } %>
                <% } %>

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


           
