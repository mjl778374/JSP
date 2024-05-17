<%@ page language="java" %>
<%!
    String GetTextAlign(int iIdOfAlign) throws Exception
    {
        String m_sTextAlign = "text-align:";

        if (iIdOfAlign == IdOfTextAlignLeft())
            m_sTextAlign = m_sTextAlign + "left";

        else if (iIdOfAlign == IdOfTextAlignRight())
            m_sTextAlign = m_sTextAlign + "right";

        else if (iIdOfAlign == IdOfTextAlignJustify())
            m_sTextAlign = m_sTextAlign + "justify";

        else if (iIdOfAlign == IdOfTextAlignCenter())
            m_sTextAlign = m_sTextAlign + "center";

        m_sTextAlign = m_sTextAlign + ";";
        return m_sTextAlign;
    } // String GetTextAlign(int iIdOfAlign) throws Exception

    String HTMLEncode(String sHileraXCodificar) throws Exception
    {
        String m_sHileraCodificada = sHileraXCodificar;

        if (m_sHileraCodificada != null)
        {
            m_sHileraCodificada = m_sHileraCodificada.replace("<", "&lt");
            m_sHileraCodificada = m_sHileraCodificada.replace(">", "&gt");
            m_sHileraCodificada = m_sHileraCodificada.replace("\"", "&quot;");
        } // if (m_sHileraCodificada != null)

        return m_sHileraCodificada;
    } // String HTMLEncode(String sHileraXCodificar) throws Exception

    String ConvertToStringValue(Object Value)
    {
        if (Value == null)
            Value = "";

        return Value.toString();
    } // String ConvertToStringValue(Object Value)

    String FormatJsonStringValue(String sStringValue, Boolean bFormatearParaSalidaHTML)
    {
        sStringValue = sStringValue.substring(1, sStringValue.length() - 1);

        if (bFormatearParaSalidaHTML)
            sStringValue = sStringValue.replace("\\\"", "&quot;");
        else
            sStringValue = sStringValue.replace("\\\"", "\"");
        
        sStringValue = sStringValue.replace("\\\\", "\\");
        return sStringValue;
    } // String FormatJsonStringValue(String sStringValue, Boolean bFormatearParaSalidaHTML)

    String InsertarLinea(String sLinea) throws Exception
    {
        return sLinea + "\n";
    } // String InsertarLinea(String sLinea) throws Exception
%>
