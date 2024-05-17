<%@ page language="java" %>
<%!    
    Boolean EsNumeroEntero(String sDato) throws Exception
    {
        try {
            int m_iDecimal = Integer.parseInt(sDato);
            return true;
        }
        catch(Exception e) {
            return false;
        }
    } // Boolean EsNumeroEntero(String sDato) throws Exception
%>
