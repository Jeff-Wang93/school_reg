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
            
            <b>Review Sections</b>

            <% 
                Statement curr_student = conn.createStatement();
                
                // Grab all sections of the current quarter
                ResultSet rs = curr_student.executeQuery(
                    "SELECT section_number " + 
                    "FROM current_quarter "
                );
            %>
            
            <%-- HTML select code --%>
            <form action="report_two_b.jsp">
                <select name="choose_section">
                    <% while(rs.next()) { %>
                        <option><%= rs.getInt(1)%></option>
                    <% } %>
                </select>

                <select name="first_day">
                    <option value="M">Monday</option>
                    <option value="T">Tuesday</option>
                    <option value="W">Wednesday</option>
                    <option value="Th">Thursday</option>
                    <option value="F">Friday</option>
                </select>

                <select name="second_day">
                    <option value="M">Monday</option>
                    <option value="T">Tuesday</option>
                    <option value="W">Wednesday</option>
                    <option value="Th">Thursday</option>
                    <option value="F">Friday</option>
                </select>

                <input type="submit" value="Submit">
            </form>

            <% 
                int chosen_section = Integer.parseInt(request.getParameter("choose_section"));

                // create a range of days to work with from inputted forms
                String day_range = "";
                String [] days_of_week = {"M", "T", "W", "Th", "F"};
                boolean start = false;
                for(int i = 0; i < days_of_week.length; i++) {
                    if(start) {
                        if(request.getParameter("second_day").equals(days_of_week[i])) {
                            day_range = day_range + days_of_week[i] + ",";
                            break;
                        }
                        day_range = day_range + days_of_week[i] + ",";
                    }

                    if(request.getParameter("first_day").equals(days_of_week[i])) {
                        day_range = day_range + days_of_week[i] + ",";
                        start = true;

                        // deal with same day range
                        if(request.getParameter("first_day").equals(request.getParameter("second_day"))) {
                            day_range += days_of_week[i];
                            break;
                        }
                    }
                }

                String delim = "[,]";
                String [] day_split = day_range.split(delim);

                PreparedStatement pstmt1 = conn.prepareStatement(
                    // grab the time for all the sections that students of Y are
                    // enrolled in
                    "SELECT lec_days, lec_time, dis_days, dis_time " +
                    "FROM current_quarter " + 
                    "WHERE section_number IN " + 
                        // get all the sections the students below are in
                        "(SELECT section_id " +
                        " FROM enrolled_student " + 
                        " WHERE student_id IN " +
                            // get all enrolled students of class ?
                            "(SELECT student_id " +
                            " FROM enrolled_student " +
                            " WHERE section_id = ?)) "
                );
                
                pstmt1.setInt(1, chosen_section);
                ResultSet rs1 = pstmt1.executeQuery();

                
                // just need to make sure REVIEW start times doesnt conflict with
                // ENROLLED class/discussion start time
                
                // have 4 arrays that correspond to a column in the above query.
                // that way, i can filter based on days
                List<String> lecture_day     = new ArrayList();
                List<String> lecture_time    = new ArrayList();
                List<String> discussion_day  = new ArrayList();
                List<String> discussion_time = new ArrayList();

                while(rs1.next()) {
                    lecture_day.add(rs1.getString(1));
                    lecture_time.add(rs1.getString(2));
                    discussion_day.add(rs1.getString(3));
                    discussion_time.add(rs1.getString(4));
                }

                // for every day within the chosen day range
                for(int i = 0; i < day_split.length; i++) {
                    String [] times = { "8:00,am", "9:00,am", "10:00,am", "11:00,am", 
                                        "12:00,pm", "1:00,pm", "2:00,pm", "3:00,pm", 
                                        "4:00,pm", "5:00,pm", "6:00,pm", "7:00,pm" };

                    String [] end   = { "9:00,am", "10:00,am", "11:00,am", "12:00,pm", 
                                        "1:00,pm", "2:00,pm", "3:00,pm", "4:00,pm", 
                                        "5:00,pm", "6:00,pm", "7:00,pm", "8:00,pm" };

                    int temp = 0;
                    for(int j = 0; j < lecture_day.size(); j++) {
                        // split the string into it's individual components
                        // eg: M,W,F = {M,W,F}
                        String [] lec_day = lecture_day.get(j).split(delim);
                        //iterate through the individual components 
                        for(int k = 0; k < lec_day.length; k++) {
                            // if they match, then we have to check the times 
                            if(day_split[i].equals(lec_day[k])) {
                                // iterate through the times
                                for(int l = 0; l < times.length; l++) {
                                    // if the times equal, that means there's a
                                    // conflict. set it(pos in times) to null
                                    if(times[l].equals(lecture_time.get(temp))) {
                                        out.println("hello" + times[l] + lecture_time.get(temp));
                                        times[l] = null;
                                        end[l]   = null;
                                    }
                                }
                            }
                        }
                        temp += 1;
                    } //end for lecture_day 

                    // now display the times that work
                    for(int m = 0; m < times.length; m++) {
                        if(times[m] != null) {
                        %>
                            <TABLE BORDER="1">
                                <TR>
                                    <TH>Day</TH>
                                    <TH>Begin Time</TH>
                                    <TH>End Time</TH>
                                </TR>

                                <TR>
                                    <TD><%= day_split[i] %></TD>
                                    <TD><%= times[m] %></TD>
                                    <TD><%= end[m] %></TD>
                                </TR>
                            </TABLE>
                        <%
                        }
                    } //end int m
                }
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
