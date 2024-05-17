<%@ page language="java" %>
<%!
    String FormatearMensajeError(String sHileraXFormatear) throws Exception
    {
        String m_sDesglose = 
            InsertarLinea("<div class=\"FormatoMensaje FormatoMensajeError\">"
            + HTMLEncode(sHileraXFormatear)
            + "</div>");

        return m_sDesglose;
    } // String FormatearMensajeError(String sHileraXFormatear) throws Exception
%>
