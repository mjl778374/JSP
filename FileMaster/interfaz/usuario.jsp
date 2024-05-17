<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<%!
    String DemeLinkUsuario(int iIdUsuario, String sUsuario) throws Exception
    {
        return "<a href='usuario.jsp?IdUsuario=" + iIdUsuario + "'>" + HTMLEncode(sUsuario) + "</a>";
    } // String DemeLinkUsuario(int iIdUsuario, String sUsuario) throws Exception

    String LlenarDesgloseUsuario(JsonObject Resultado) throws Exception
    {
        String m_sIdUsuario = FormatJsonStringValue(Resultado.get("IdUsuario").toString(), true);
        String m_sCedula = FormatJsonStringValue(Resultado.get("Cedula").toString(), true);
        String m_sNombre = FormatJsonStringValue(Resultado.get("Nombre").toString(), true);

        String m_sDesglose = "";
        String m_sContenidoFormulario = "";
        String m_sNombreFormulario = "FormularioUsuario";

        m_sContenidoFormulario += AgregarControlTexto("Id del Usuario", "IdUsuario", m_sIdUsuario, IdOfTextAlignRight(), "CampoTextoDesglose");
        m_sContenidoFormulario += AgregarControlTexto("Cédula", "Cedula", m_sCedula, IdOfTextAlignLeft(), "CampoTextoDesglose");
        m_sContenidoFormulario += AgregarControlTexto("Nombre", "Nombre", m_sNombre, IdOfTextAlignLeft(), "CampoTextoDesglose");
        m_sContenidoFormulario += AgregarBotonera("usuarios.jsp");

        m_sDesglose += AgregarFormularioDesglose(m_sContenidoFormulario, m_sNombreFormulario);

        //m_sDesglose += InsertarLinea("</body>");

        return m_sDesglose;
    } // String LlenarDesgloseUsuario(JsonObject Resultado) throws Exception
%>