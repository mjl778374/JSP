<%@ page language="java" %>
<%!
    String LlenarDesgloseUsuarios(Object [] pMetaDatos, HashMap Resultados) throws Exception
    {
        String m_sDesglose = "";

        m_sDesglose += LlenarDesgloseTabla(pMetaDatos, Resultados);
        //m_sDesglose += InsertarLinea("</body>");

        return m_sDesglose;
    } // String LlenarDesgloseUsuarios(Object [] pMetaDatos, HashMap Resultados) throws Exception
%>
