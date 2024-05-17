<%@ page language="java" %>
<%@ page import = "java.util.*"%>
<%@ include file="../implementacion/ConstantesApp.jsp" %>
<%@ include file="../implementacion/Desglose.jsp" %>
<%@ include file="../implementacion/SQL.jsp" %>
<%@ include file="../implementacion/Palabras.jsp" %>
<%@ include file="../implementacion/Request.jsp" %>
<%@ include file="../implementacion/Utiles.jsp" %>
<%@ include file="../implementacion/CUsuarios.jsp" %>
<%@ include file="../implementacion/Session.jsp" %>
<%@ include file="../interfaz/Utiles.jsp" %>
<%@ include file="../interfaz/FormatearMensajes.jsp" %>
<%@ include file="../interfaz/UtilesApp.jsp" %>
<%@ include file="../interfaz/usuario.jsp" %>
<%
    if (!ValidarIngresoSesion(request.getSession()))
        response.sendRedirect(DemeURLIngreso());

    Integer [] pw_iNumSiguienteDesgloseReporte = {0};
    HashMap<String, String> pw_DesgloseReporte = new HashMap<String, String>();

    try {
        InicializarLlaveDesglose(pw_iNumSiguienteDesgloseReporte);

        Object [] pw_pDesgloseReporte = {pw_DesgloseReporte};
        Object [] pw_piNumSiguienteDesgloseReporte = {pw_iNumSiguienteDesgloseReporte};

        HashMap<String, Object[]> pw_Resultados = ConsultarXTodosUsuarios2(pw_pDesgloseReporte , pw_piNumSiguienteDesgloseReporte);

        if (pw_Resultados != null)
        {
            String pw_sDesglose = LlenarDesgloseReporte(pw_Resultados);
            AgregarADesglose(pw_DesgloseReporte, pw_iNumSiguienteDesgloseReporte, pw_sDesglose, false);
        } // if (pw_Resultados != null)
    } // try {
    catch(Exception e)
    {
        AgregarADesglose(pw_DesgloseReporte, pw_iNumSiguienteDesgloseReporte, FormatearMensajeError(e.getMessage()), false);
    } // catch(Exception e)
    finally {
        %>
        <%@ include file="../interfaz/DesgloseReporte.jsp" %>
        <%
    } // finally {
%>
