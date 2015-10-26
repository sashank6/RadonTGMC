<%@page import="sashank.Sashank"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ page import="java.sql.*" %>
    <%
    HttpSession ses=request.getSession();
    long user=-1;
    try
    {
    user=Long.parseLong((String)ses.getAttribute("userid"));
    }
    catch(Exception e)
    {
    response.sendRedirect("home.jsp");
    } 
    
     %>

<%
    String vendor=request.getParameter("vendorid");
    
%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style.css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript">
            function fun()
            {
                
                var cname=document.getElementById("c1").value;
                var ctno=document.getElementById("c2").value;
                var city=document.getElementById("c3").value;
                var staddr=document.getElementById("c4").value;
                var tin=document.getElementById("c5").value;
                
                var useridd="<%=vendor%>";
                
                var c1=/^[A-Za-z0-9\s]{3,}$/;
                var c2=/^[0-9]{8}$/;
                var c3=/^[A-Za-z]{3,}$/;
                var c4=/^[0-9]{1,}$/;
                
                
                if(c1.test(cname)&&c2.test(ctno)&&c3.test(city)&&c1.test(staddr)&&c4.test(tin))
                    {
                        alert("Hello");
                        var p=$.ajax({
                        type:"POST",
                        url:"update_vendor_details",
                        async:false,
                        data:{cname1:cname,staddr1:staddr,city1:city,ctno1:ctno,pan_tin1:tin,userid:useridd},
                        dataType:"html"
                    }).responseText;
                    alert("Hello1");
                    alert(p);
                    if(p==1)
                        document.getElementById("p").innerHTML="Update Successful";
                    else
                        document.getElementById("p").innerHTML="Update failed. Please contact your IT department.";
                    }
                    else
                        alert("Invalid Details");
            }
            
        </script>
    </head>
    
    <body>
        <h1>
        <a href="admin_home.jsp" style="color:white">Project Radon</a>
        <a href="logout.jsp" style="float:right; color:white; font-size:16px; ">Log out</a>
    </h1>
    



<ul>
    <li><a>Retailers</a>
        <ul>
            <li><a href="admin_view_retailer_list.jsp">View Retailers</a></li>
            <li><a href="admin_view_retailer_pending.jsp">Pending Orders</a></li>
            <li><a href="retailer_order_status.jsp">Order Status</a></li>
                
        </ul>
    
    </li>
    <li><a>Vendors</a>
    <ul>
        <li><a href="admin_view_vendor_list.jsp">View Vendors</a></li>
        <li><a href="admin_raise_po.jsp">Raise Purchase Order</a></li>
        <li><a href="admin_view_po.jsp">View Purchase Orders</a></li>
        <li><a href="admin_approve_pay.jsp">Approve Payments</a></li>
    </ul>
        </li>
    <li><a>Transactions</a>
    <ul>
        <li><a href="admin_view_cash_position.jsp">View Cash Position</a></li>
        <li><a href="admin_view_account_statement.jsp">View Account Statement</a></li>
        <li><a href="add_cash_transaction.jsp">Add Cash Transaction</a></li>
    </ul>
        </li>
    <li><a>Inventory</a>
    <ul>
        <li><a href="admin_view_res_inv.jsp">View reserve Inventory</a></li>
        <li><a href="admin_view_act_inv.jsp">View Active Inventory</a></li>
        <li><a href="admin_add_quantity.jsp">Add Quantity</a></li>
    </ul></li>
    <li><a>Products</a>
    <ul>
        <li><a href="admin_view_cat.jsp">View Category</a></li>
        <li><a href="admin_add_category.jsp">Add Category</a></li>
        <li><a href="admin_add_product_sale.jsp">Add New Product</a></li>
    </ul>
        </li>
        <li><a>Messages</a>
            <ul>
                <li><a href="admin_view_message.jsp">View Messages</a></li>
                <li><a href="admin_send_message.jsp">Send Message</a></li>
            </ul></li>
</ul>
        <% 
            Sashank obj=new Sashank();
            Connection con=obj.getCon();
            PreparedStatement pstmt=con.prepareStatement("select cname,ctno,city,staddr,tinno from rad_vendor where userid=?");
            pstmt.setLong(1, Long.parseLong(vendor));
            ResultSet rs=pstmt.executeQuery();
            String cname="",city="",staddr="";
            long ctno=0,pan_tin=0;
            while(rs.next())
            {
                cname=rs.getString(1);
                ctno=rs.getLong(2);
                city=rs.getString(3);
                staddr=rs.getString(4);
                pan_tin=rs.getLong(5);
            }
            
            
            
        %>
        <table border="1">
            <tr>
                <td>
                    User ID
                </td>
                <td>
                    <%=vendor%>
                </td>
            </tr>
            <tr>
                <td>
                    Company Name
                </td>
                <td>
                    <input type="text" value="<%=cname%>" id="c1"/>
                </td>
            </tr>
            <tr>
                <td>
                    Contact No
                </td>
                <td>
                    <input type="text" value="<%=ctno%>" id="c2"/>
                </td>
            </tr>
            <tr>
                <td> City</td>
                <td>
                    <input type="text" value="<%=city%>" id="c3"/>
                </td>
                        
            </tr>
            <tr>
                <td>
                    Street Address
                </td>
                <td>
                    <input type="text" value="<%=staddr%>" id="c4"/>
                </td>
            </tr>
            <tr>
                <td>
                    TIN/TAN
                </td>
                <td>
                    <input type="text" value="<%=pan_tin%>" id="c5"/>
                </td>
            </tr>
            
        </table>
                <br/>
                <input type="button" value="Save" onclick="fun()"/>
                <p id="p"></p>
    </body>
</html>
