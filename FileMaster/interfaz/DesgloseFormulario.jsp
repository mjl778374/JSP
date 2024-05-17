<%@ page language="java" %>
<%  
    out.println("<html>");
    out.println("<head>");
    out.println("<title>" + DemeNombreApp() + "</title>");
    out.println("<style>");
    %>
    <%@ include file="HojaEstilos.css" %>
    <%

    out.println("</style>");

    out.println("<script>");
    %>
    <%@ include file="Funciones.js" %>
    <%

    out.println("</script>");

    out.println("</head>");
    out.println("<body>");

    InicializarLlaveDesglose(pw_iNumSiguienteDesgloseFormulario);
        
    while (pw_DesgloseFormulario.get(DemeLlaveDesglose(pw_iNumSiguienteDesgloseFormulario)) != null)
    {
        out.print(pw_DesgloseFormulario.get(DemeLlaveDesglose(pw_iNumSiguienteDesgloseFormulario)));
        AsignarNuevaLlaveDesglose(pw_iNumSiguienteDesgloseFormulario);
    } // while (pw_DesgloseFormulario.get(DemeLlaveDesglose(pw_iNumSiguienteDesgloseFormulario)) != null)

    out.println("</body>");
    out.println("<script>");

    InicializarLlaveDesglose(pw_iNumSiguienteDesgloseScriptsOnLoad);
        
    while (pw_DesgloseScriptsOnLoad.get(DemeLlaveDesglose(pw_iNumSiguienteDesgloseScriptsOnLoad)) != null)
    {
        out.print(pw_DesgloseScriptsOnLoad.get(DemeLlaveDesglose(pw_iNumSiguienteDesgloseScriptsOnLoad)));
        AsignarNuevaLlaveDesglose(pw_iNumSiguienteDesgloseScriptsOnLoad);
    } // while (pw_DesgloseScriptsOnLoad.get(DemeLlaveDesglose(pw_iNumSiguienteDesgloseScriptsOnLoad)) != null)

    out.println("</script>");
    out.println("</html>");
%>
