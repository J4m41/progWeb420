<%-- 
    Document   : pwchange_page
    Created on : 21-ott-2016, 13.01.40
    Author     : gianma
--%>

<%@page import="java.security.NoSuchAlgorithmException"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.io.UnsupportedEncodingException"%>
<%@page import="com.nimbusds.jose.JOSEException"%>
<%@page import="com.nimbusds.jose.crypto.MACVerifier"%>
<%@page import="java.util.logging.Level"%>
<%@page import="com.nimbusds.jose.JWSVerifier"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="com.nimbusds.jwt.SignedJWT"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>    
    <head>
        <%@page import="db_classes.User" %>
        <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="media/css/styles.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="media/js/autoCompelte.js"></script>
        
    </head>
    <%!String token;%>
    <% token = request.getParameter("token"); %>
    <%!
    public String parseJWT(String jwt) throws NoSuchAlgorithmException, ParseException, JOSEException, UnsupportedEncodingException{
        String username = null;
        
        SignedJWT sJWT = null;
        
        sJWT = SignedJWT.parse(jwt);
            
        JWSVerifier hmacVerifier = null;
        
        byte [] bytes = new byte[32];
        bytes = MessageDigest.getInstance("SHA-256").digest("secret".getBytes("UTF-8"));
        hmacVerifier = new MACVerifier(bytes);
        
        if (sJWT.verify(hmacVerifier)){
            System.out.println("PORCODIO è valido");
            username = sJWT.getJWTClaimsSet().getSubject();
        }else{
            System.out.println("DIOPORCO non è valido");
        }
                
        return username;
    } 
    %>
    
    <body>
        <script src="media/js/jquery-3.1.1.min.js"></script>
        <script src="media/js/scripts.js"></script>
        <nav id="nav-lato">
            <c:if test="${sessionScope.user == null}">
                <ul class="menu">
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="login_page.jsp">Sign in</a></li>
                    <li><a href="signup_page.jsp">Sign up</a></li>
                    <li><a href="#">Services</a></li>
                    <li><a href="#">About</a></li>
                    <li><a href="#">Contact</a></li>
                </ul>
            </c:if>
            <c:if test="${sessionScope.user != null}">
                <ul class="menu">
                    <li>Welcome back <c:out value="${sessionScope.user.firstname}"></c:out></li>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="#">My profile</a></li>
                    <li><a href="#">My notifications</a></li>
                    <li><a href="#">My restaurants</a></li>
                    <li><a href="#">Services</a></li>
                    <li><a href="#">About</a></li>
                    <li><a href="#">Contact</a></li>
                    <li><a href="<%=request.getContextPath()%>/LogoutServlet">Logout</a></li>
                </ul>
            </c:if>
        </nav>

        
        <nav class="navbar navbar-custom navbar-fixed-top">
            
            <div class="col-md-2">
                <div id="mobile-nav"></div>
            </div>
            <div class="col-md-8">
                <form action="ShowResults" type="post">
                    <div class="input-group" id="barra-ricerca">
                        <input type="text" id="search_bar" name="search_bar" class="form-control" placeholder="Search">

                        <div class="input-group-btn">
                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown"
                                    aria-haspopup="true" aria-expanded="false">Advanced <span class="caret"></span></button>
                            <ul class="dropdown-menu dropdown-menu-right">
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="#">Separated link</a></li>
                            </ul>
                        </div>

                        <span class="input-group-btn">
                            <button class="btn btn-default" type="submit" formmethod="post">Search!</button>
                        </span>
                    </div>
                </form>
            </div>
            <div class="col-md-2"></div>
            
        </nav>
        
        
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <div class="container-fluid">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-heading">Password Reset</h3>
                        </div>
                        <div class="panel-body">
                            <form action="PwChangeServlet" method="POST">
                                <div class="container-fluid">
                                    <div class="form-group">
                                        <div class="row">
                                            <label for="username">Username:</label>
                                            <input type="text" id="username" name="username" class="form-control" disabled="true" value="<%=parseJWT(token)%>">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <label for="password1">Nuova password:</label>
                                            <input type="password" id="password1" name="password1" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <label for="password2">Conferma password:</label>
                                            <input type="password" id="password2" name="password2" class="form-control">
                                        </div>
                                    </div>
                                    <br>
                                    <div class="form-group">
                                        <div class="row">
                                            <button class="btn btn-primary" type="submit">Submit</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4"></div>
        </div>
        
        
        
        <script src="media/js/jquery-3.1.1.min.js"></script>
        <script src="media/js/scripts.js"></script>

    </body>
</html>