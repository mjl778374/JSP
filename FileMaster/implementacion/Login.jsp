<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<%@ page import = "java.sql.*"%>
<%!
    String DemeCodigoEncriptacion()
    {
        return "7Yñ+";
    } // String DemeCodigoEncriptacion()

    Integer ValidarLogin(String sUsuario, String sContrasena, Object [] pDesglose, Object [] piNumSiguienteDesglose, Boolean [] bUsuarioContrasenaExiste) throws Exception
    {
        Integer m_iIdUsuario = 0;

        Connection m_Conexion = null;
        HashMap<String, String> m_Desglose = (HashMap<String, String>) pDesglose[0];
        Integer [] m_iNumSiguienteDesglose = (Integer[]) piNumSiguienteDesglose[0];

        try {
            m_Conexion = Conectarse();

            String m_sConsulta = "CALL ValidarLogin(" + scm(sUsuario) +  ", " + scm(sContrasena) +  ", " + scm(DemeCodigoEncriptacion()) + ", @UsuarioContrasenaExiste, @UnIdUsuario, 1);";

            if (MostrarDatosDepuracion())
                AgregarADesglose(m_Desglose, m_iNumSiguienteDesglose, m_sConsulta, true);

            ResultSet m_ResultSet = ConsultarSQL(m_Conexion, m_sConsulta);

            if (m_ResultSet.next()) {
                bUsuarioContrasenaExiste[0] = m_ResultSet.getBoolean(1);
                m_iIdUsuario = m_ResultSet.getInt(2);
            } // if (m_ResultSet.next()) {
        } // try {
        catch(Exception e)
        {
            throw new Exception(e.getMessage());
        } // catch(Exception e)
        finally {
            if (m_Conexion != null)
                m_Conexion.close();
        } // finally {

        return m_iIdUsuario;
    } // Integer ValidarLogin(String sUsuario, String sContrasena, Object [] pDesglose, Object [] piNumSiguienteDesglose, Boolean [] bUsuarioContrasenaExiste) throws Exception

    void LanzarErrorLogin(int iNumError) throws Exception
    {
        String m_sDescError = "";

        if (iNumError == 1001)
            m_sDescError = "Usuario o Contraseña Incorrecta";

        throw new Exception(m_sDescError);
    } // void LanzarErrorLogin(int iNumError) throws Exception

%>