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
<%
    if (!ValidarIngresoSesion(request.getSession()))
        response.sendRedirect(DemeURLIngreso());

    Integer [] pw_iNumSiguienteDesgloseFormulario = {0};
    HashMap<String, String> pw_DesgloseFormulario = new HashMap<String, String>();

    Integer [] pw_iNumSiguienteDesgloseScriptsOnLoad = {0};
    HashMap<String, String> pw_DesgloseScriptsOnLoad = new HashMap<String, String>();

    try {
        InicializarLlaveDesglose(pw_iNumSiguienteDesgloseFormulario);

        String pw_sDesglose = DemeEncabezadoArchivos("Usuario", false, "");
        AgregarADesglose(pw_DesgloseFormulario, pw_iNumSiguienteDesgloseFormulario, pw_sDesglose, false);

        if (MostrarDatosDepuracion())
            AgregarADesglose(pw_DesgloseFormulario, pw_iNumSiguienteDesgloseFormulario, HTMLEncode(request.getQueryString()), true);

        HashMap<String, String> pw_ParamsInQueryString = GetParamsInQueryString(request);

        String pw_sIdUsuario = pw_ParamsInQueryString.get("IdUsuario");

        if (MostrarDatosDepuracion())
            AgregarADesglose(pw_DesgloseFormulario, pw_iNumSiguienteDesgloseFormulario, HTMLEncode(pw_sIdUsuario), true);

        Object [] pw_pDesgloseFormulario = {pw_DesgloseFormulario};
        Object [] pw_piNumSiguienteDesgloseFormulario = {pw_iNumSiguienteDesgloseFormulario};

        JsonObject pw_Resultado = null;
        int pw_iNumError = 0;
;
        if (pw_sIdUsuario != null && EsNumeroEntero(pw_sIdUsuario))
        {
            int pw_iIdUsuario = (Integer) Integer.parseInt(pw_sIdUsuario, 10);
            int [] pw_piNumError = {0};
            pw_Resultado = ConsultarXUsuario(pw_iIdUsuario, pw_pDesgloseFormulario, pw_piNumSiguienteDesgloseFormulario, pw_piNumError);
            pw_iNumError = pw_piNumError[0];
        } // if (pw_sIdUsuario != null && EsNumeroEntero(pw_sIdUsuario))

        else
            pw_iNumError = 1001;

        if (pw_Resultado == null)
            pw_Resultado = CrearObjetoJsonUsuario("", "", "");

        if (pw_Resultado != null)
        {
            pw_sDesglose = LlenarDesgloseUsuario(pw_Resultado);
            AgregarADesglose(pw_DesgloseFormulario, pw_iNumSiguienteDesgloseFormulario, pw_sDesglose, false);
        } // if (pw_Resultado != null)

        if (pw_iNumError != 0)
            LanzarErrorUsuario(pw_iNumError, pw_sIdUsuario);

        pw_sDesglose = InsertarLinea("AbrirURLEnNuevaVentana(\"./reportes/reporteUsuarios.csv.jsp\");");
        InicializarLlaveDesglose(pw_iNumSiguienteDesgloseScriptsOnLoad);
        AgregarADesglose(pw_DesgloseScriptsOnLoad, pw_iNumSiguienteDesgloseScriptsOnLoad, pw_sDesglose, false);
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
