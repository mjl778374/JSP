<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<%!
    String LlenarDesgloseLogin() throws Exception
    {
        String m_sDesglose = "";
        String m_sContenidoFormulario = "";
        String m_sNombreFormulario = "FormularioLogin";

        m_sContenidoFormulario += AgregarControlTexto("Usuario", "Usuario", "", IdOfTextAlignLeft(), "CampoTextoDesglose");
        m_sContenidoFormulario += AgregarControlTextoContrasena("Contraseña", "Contrasena", IdOfTextAlignLeft(), "CampoTextoDesglose");
        m_sContenidoFormulario += AgregarBotoneraLogin();

        m_sDesglose += AgregarFormularioDesglose(m_sContenidoFormulario, m_sNombreFormulario);

        return m_sDesglose;
    } // String LlenarDesgloseLogin() throws Exception
%>