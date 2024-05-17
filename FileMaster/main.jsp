<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<%@ page import="com.google.gson.*"%>
<%@ page import = "java.util.*"%>
<%@ include file="implementacion/ConstantesApp.jsp" %>
<%@ include file="implementacion/Desglose.jsp" %>
<%@ include file="implementacion/SQL.jsp" %>
<%@ include file="implementacion/Palabras.jsp" %>
<%@ include file="implementacion/Request.jsp" %>
<%@ include file="implementacion/Utiles.jsp" %>
<%@ include file="implementacion/CUsuarios.jsp" %>
<%@ include file="implementacion/Session.jsp" %>
<%@ include file="interfaz/Utiles.jsp" %>
<%@ include file="interfaz/FormatearMensajes.jsp" %>
<%@ include file="interfaz/UtilesApp.jsp" %>
<%@ include file="interfaz/usuario.jsp" %>

<html>
<head>
<%
    out.println("<title>" + DemeNombreApp() + "</title>");
    out.println("<style>");
    %>
    <%@ include file="interfaz/HojaEstilos.css" %>
    <%

    out.println("</style>");
%>
</head>
<body>
<%  
    if (!ValidarIngresoSesion(request.getSession()))
        response.sendRedirect(DemeURLIngreso());

    out.println(DemeMenuApp("Home"));

    try {

        int pw_iNumError = 0;
        int [] pw_piNumError = {0};
        String pw_sNombreUsuarioSesion = DemeNombreUsuarioSesion(request.getSession(), pw_piNumError);
        pw_iNumError = pw_piNumError[0];
        out.println("<h1>Bienvenid@ " + HTMLEncode(pw_sNombreUsuarioSesion) + "</h1>");

        if (pw_iNumError != 0)
            LanzarErrorUsuario(pw_iNumError, DemeIdUsuarioSesion(request.getSession()));
    } // try {
    catch(Exception e)
    {
        out.println(FormatearMensajeError(e.getMessage()));
    } // catch(Exception e)
%>
</body>
</html>