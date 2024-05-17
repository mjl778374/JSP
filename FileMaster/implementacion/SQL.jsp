<%@ page language="java" %>
<%@ page import = "java.sql.*"%>
<%!
    Connection Conectarse() throws Exception
    {
        final String URL_SERVIDOR_BD = "jdbc:mysql://localhost:3306/SistemaMatriculaColegio";
        final String USUARIO_BD = "root";
        final String PASSWORD_BD = "UnaContrasena100.";

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection m_Conexion = DriverManager.getConnection(URL_SERVIDOR_BD, USUARIO_BD, PASSWORD_BD);
        return m_Conexion;
    } // Connection Conectarse() throws Exception

    String scm(String sDatos) throws Exception
    {
        return "'" + sDatos.replace("'", "\\'") + "'";
    } // String scm(String sDatos) throws Exception
    
    ResultSet ConsultarSQL(Connection Conexion, String sSQL) throws Exception
    {
        Statement m_Statement = Conexion.createStatement();
        ResultSet m_ResultSet = m_Statement.executeQuery(sSQL);
        return m_ResultSet;
    } // ResultSet ConsultarSQL(Connection Conexion, String sSQL) throws Exception

    void InicializarNumResultados(Integer [] iNumResultados) throws Exception
    {
        iNumResultados[0] = 1;
    } // void InicializarNumResultados(Integer [] iNumResultados) throws Exception
    
    void IncrementarNumResultados(Integer [] iNumResultados) throws Exception
    {
        iNumResultados[0] += 1;
    } // void IncrementarNumResultados(Integer [] iNumResultados) throws Exception
    
    String DemeLlaveNumResultados(Integer [] iNumResultados) throws Exception
    {
        return iNumResultados[0].toString();
    } // String DemeLlaveNumResultados(Integer [] iNumResultados) throws Exception
%>
