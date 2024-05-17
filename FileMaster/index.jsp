<%@ page session = "true" %>
<%@ page language = "java" %>
<%@ page import = "java.util.*"%>
<%@ page import = "java.net.http.*"%>
<%@ include file="implementacion/ConstantesApp.jsp" %>
<%@ include file="implementacion/Desglose.jsp" %>
<%@ include file="implementacion/SQL.jsp" %>
<%@ include file="implementacion/Palabras.jsp" %>
<%@ include file="implementacion/Request.jsp" %>
<%@ include file="implementacion/Utiles.jsp" %>
<%@ include file="implementacion/CUsuarios.jsp" %>
<%@ include file="implementacion/Login.jsp" %>
<%@ include file="implementacion/Session.jsp" %>
<%@ include file="interfaz/Utiles.jsp" %>
<%@ include file="interfaz/FormatearMensajes.jsp" %>
<%@ include file="interfaz/UtilesApp.jsp" %>
<%@ include file="interfaz/usuario.jsp" %>
<%@ include file="interfaz/index.jsp" %>
<%
    Integer [] pw_iNumSiguienteDesgloseFormulario = {0};
    HashMap<String, String> pw_DesgloseFormulario = new HashMap<String, String>();

    Integer [] pw_iNumSiguienteDesgloseScriptsOnLoad = {0};
    HashMap<String, String> pw_DesgloseScriptsOnLoad = new HashMap<String, String>();

    try {
        AbandonarSesion(request.getSession());
        InicializarLlaveDesglose(pw_iNumSiguienteDesgloseFormulario);

        Object [] pw_pDesgloseFormulario = {pw_DesgloseFormulario};
        Object [] pw_piNumSiguienteDesgloseFormulario = {pw_iNumSiguienteDesgloseFormulario};

        int pw_iNumError = 0;

        if (request.getMethod().equals("POST"))
        {
            String pw_sUsuario = request.getParameter("Usuario");
            String pw_sContrasena = request.getParameter("Contrasena");
            Boolean [] pw_pbUsuarioContrasenaExiste = {false};
            Integer pw_iIdUsuario = ValidarLogin(pw_sUsuario, pw_sContrasena, pw_pDesgloseFormulario, pw_piNumSiguienteDesgloseFormulario, pw_pbUsuarioContrasenaExiste);

            if (!pw_pbUsuarioContrasenaExiste[0])
                pw_iNumError = 1001;
            else {
                IngresarASesion(pw_iIdUsuario, request.getSession());
                response.sendRedirect("main.jsp");
            } // else {
        } // if (request.getMethod().equals("POST"))

        String pw_sDesglose = LlenarDesgloseLogin();
        AgregarADesglose(pw_DesgloseFormulario, pw_iNumSiguienteDesgloseFormulario, pw_sDesglose, false);

        if (pw_iNumError != 0)
            LanzarErrorLogin(pw_iNumError);
    } // try {
    catch(Exception e)
    {
        AgregarADesglose(pw_DesgloseFormulario, pw_iNumSiguienteDesgloseFormulario, FormatearMensajeError(e.getMessage()), false);
    } // catch(Exception e)
    finally {
        %>
        <%@ include file="interfaz/DesgloseFormulario.jsp" %>
        <%
    } // finally {
%>
