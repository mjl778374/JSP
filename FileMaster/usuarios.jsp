<%@ page language="java" %>
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
<%@ include file="interfaz/usuarios.jsp" %>
<%
    if (!ValidarIngresoSesion(request.getSession()))
        response.sendRedirect(DemeURLIngreso());

    Integer [] pw_iNumSiguienteDesgloseFormulario = {0};
    HashMap<String, String> pw_DesgloseFormulario = new HashMap<String, String>();

    Integer [] pw_iNumSiguienteDesgloseScriptsOnLoad = {0};
    HashMap<String, String> pw_DesgloseScriptsOnLoad = new HashMap<String, String>();

    try {
        InicializarLlaveDesglose(pw_iNumSiguienteDesgloseFormulario);

        String pw_sDesglose = DemeEncabezadoArchivos("Usuarios", true, "usuarios.jsp");
        AgregarADesglose(pw_DesgloseFormulario, pw_iNumSiguienteDesgloseFormulario, pw_sDesglose, false);

        if (MostrarDatosDepuracion())
            AgregarADesglose(pw_DesgloseFormulario, pw_iNumSiguienteDesgloseFormulario, HTMLEncode(request.getQueryString()), true);

        HashMap<String, String> pw_ParamsInQueryString = GetParamsInQueryString(request);

        //if (pw_ParamsInQueryString.get("redirect") != null && pw_ParamsInQueryString.get("redirect").equals("1"))
        //    response.sendRedirect("./?def=mn&abc=3");

        String pw_sTextoXBuscar = pw_ParamsInQueryString.get("TextoXBuscar");

        if (MostrarDatosDepuracion())
            AgregarADesglose(pw_DesgloseFormulario, pw_iNumSiguienteDesgloseFormulario, HTMLEncode(pw_sTextoXBuscar), true);

        Object [] pw_pDesgloseFormulario = {pw_DesgloseFormulario};
        Object [] pw_piNumSiguienteDesgloseFormulario = {pw_iNumSiguienteDesgloseFormulario};
        Object [] pw_pMetaDatos = {"","",""};

        HashMap<String, Object[]> pw_Resultados = ConsultarXTodosUsuarios(pw_sTextoXBuscar, pw_pDesgloseFormulario, pw_piNumSiguienteDesgloseFormulario, pw_pMetaDatos);

        if (pw_Resultados != null)
        {
            pw_sDesglose = LlenarDesgloseUsuarios(pw_pMetaDatos, pw_Resultados);
            AgregarADesglose(pw_DesgloseFormulario, pw_iNumSiguienteDesgloseFormulario, pw_sDesglose, false);
        } // if (pw_Resultados != null)
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
