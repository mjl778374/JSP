<%@ page language="java" %>
<%  
    InicializarLlaveDesglose(pw_iNumSiguienteDesgloseReporte);

    while (pw_DesgloseReporte.get(DemeLlaveDesglose(pw_iNumSiguienteDesgloseReporte)) != null)
    {
        out.print(pw_DesgloseReporte.get(DemeLlaveDesglose(pw_iNumSiguienteDesgloseReporte)));
        AsignarNuevaLlaveDesglose(pw_iNumSiguienteDesgloseReporte);
    } // while (pw_DesgloseReporte.get(DemeLlaveDesglose(pw_iNumSiguienteDesgloseReporte)) != null)
%>
