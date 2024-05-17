<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<%@ page import = "java.sql.*"%>
<%!

    String DemeCaracteresValidos() throws Exception
    {
        return "abcdefghijklmnñopqrstuvwxyzáéíóúü0123456789";
    } // String DemeCaracteresValidos()

    int DemeTamanoMaximoPalabra() throws Exception
    {
        return 100;
    } // int DemeTamanoMaximoPalabra() throws Exception

    String DemeSiguientePalabra(Connection Conexion, String sHileraXAnalizar, Integer iIndiceInicial, Integer [] iNuevoIndice) throws Exception
    {
        String m_sSiguientePalabra = "";

        String m_sConsulta = "CALL DemeSiguientePalabra(" + scm(sHileraXAnalizar) +  ", " + scm(DemeCaracteresValidos()) + ", " + iIndiceInicial.toString() + ", @SiguientePalabra, @NuevoIndice," + DemeTamanoMaximoPalabra() + ", 1);";

        ResultSet m_ResultSet = ConsultarSQL(Conexion, m_sConsulta);

        if (m_ResultSet.next()) {
            m_sSiguientePalabra = m_ResultSet.getString(1);
            iNuevoIndice[0] = m_ResultSet.getInt(2);
        } // if (m_ResultSet.next()) {

        return m_sSiguientePalabra; 
    } // String DemeSiguientePalabra(Connection Conexion, String sHileraXAnalizar, Integer iIndiceInicial, Integer [] iNuevoIndice) throws Exception
    
    String DemeSeparadorTuplas() throws Exception
    {
        return ";";
    } // String DemeSeparadorTuplas() throws Exception

    String DemeSeparadorColumnas() throws Exception
    {
        return ",";
    } // String DemeSeparadorColumnas() throws Exception

    String AgregarTuplaReemplazo(String sTuplas, String sAReemplazar, String sReemplazo) throws Exception
    {
        return sTuplas + sAReemplazar + DemeSeparadorColumnas() + sReemplazo + DemeSeparadorTuplas();
    } // String AgregarTuplaReemplazo(String sTuplas, String sAReemplazar, String sReemplazo) throws Exception

    String DemeTuplasReemplazo() throws Exception
    {
        String m_sTuplas = "";
        m_sTuplas = AgregarTuplaReemplazo(m_sTuplas, "h", "");
        m_sTuplas = AgregarTuplaReemplazo(m_sTuplas, "á", "a");
        m_sTuplas = AgregarTuplaReemplazo(m_sTuplas, "é", "e");
        m_sTuplas = AgregarTuplaReemplazo(m_sTuplas, "í", "i");
        m_sTuplas = AgregarTuplaReemplazo(m_sTuplas, "ó", "o");
        m_sTuplas = AgregarTuplaReemplazo(m_sTuplas, "ú", "u");
        m_sTuplas = AgregarTuplaReemplazo(m_sTuplas, "ü", "u");
        m_sTuplas = AgregarTuplaReemplazo(m_sTuplas, "ñ", "n");
        m_sTuplas = AgregarTuplaReemplazo(m_sTuplas, "w", "v");
        m_sTuplas = AgregarTuplaReemplazo(m_sTuplas, "v", "b");
        m_sTuplas = AgregarTuplaReemplazo(m_sTuplas, "x", "s");
        m_sTuplas = AgregarTuplaReemplazo(m_sTuplas, "z", "s");
        m_sTuplas = AgregarTuplaReemplazo(m_sTuplas, "ge", "je");
        m_sTuplas = AgregarTuplaReemplazo(m_sTuplas, "gi", "ji");
        m_sTuplas = AgregarTuplaReemplazo(m_sTuplas, "ce", "se");
        m_sTuplas = AgregarTuplaReemplazo(m_sTuplas, "ci", "si");
        m_sTuplas = AgregarTuplaReemplazo(m_sTuplas, "qu", "k");
        m_sTuplas = AgregarTuplaReemplazo(m_sTuplas, "q", "k");
        m_sTuplas = AgregarTuplaReemplazo(m_sTuplas, "c", "k");
        m_sTuplas = AgregarTuplaReemplazo(m_sTuplas, "ll", "y");
        m_sTuplas = AgregarTuplaReemplazo(m_sTuplas, "y", "i");
        return m_sTuplas;
    } // String DemeTuplasReemplazo() throws Exception
    
    String DemePalabraSemejante(Connection Conexion, String sPalabra) throws Exception
    {
        String m_sPalabraSemejante = "";
        String m_sConsulta = "CALL DemePalabraSemejante(" + scm(sPalabra) + ", " + scm(DemeTuplasReemplazo()) + ", " + scm(DemeSeparadorTuplas()) + ", " + scm(DemeSeparadorColumnas()) + ", @PalabraSemejante, 1);";

        ResultSet m_ResultSet = ConsultarSQL(Conexion, m_sConsulta);

        if (m_ResultSet.next())
            m_sPalabraSemejante = m_ResultSet.getString(1);

        return m_sPalabraSemejante;
    } // String DemePalabraSemejante(Connection Conexion, String sPalabra) throws Exception
%>
