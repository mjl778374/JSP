<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<%@ page import = "com.google.gson.*"%>
<%!
    HashMap ConsultarXTodosUsuarios(String sTextoXBuscar, Object [] pDesglose, Object [] piNumSiguienteDesglose, Object [] pMetaDatos) throws Exception
    {
        HashMap<String, Object[]> m_Resultados = null;

        Connection m_Conexion = null;
        HashMap<String, String> m_Desglose = (HashMap<String, String>) pDesglose[0];
        Integer [] m_iNumSiguienteDesglose = (Integer[]) piNumSiguienteDesglose[0];

        try {
            m_Conexion = Conectarse();

            String m_sConsulta = "select count(1) as NumAciertos, a.IdUsuario, a.Usuario, a.Cedula, concat("+  scm("\\\"\"\"\\\"") + ", a.Nombre, " +  scm("\\\\''''") + ")";
            m_sConsulta += " from Usuarios a, PalabrasXUsuario b, Palabras c, PalabrasSemejantes d";
            m_sConsulta += " where a.IdUsuario = b.IdUsuario";
            m_sConsulta += " and b.IdPalabra = c.IdPalabra";
            m_sConsulta += " and c.IdPalabraSemejante = d.IdPalabraSemejante";
            m_sConsulta += " and (1 = 0";
            // m_sConsulta += " from Usuarios a";

            if (sTextoXBuscar != null)
            {
                Integer m_iIndiceInicial = 1;
                Integer [] m_piNuevoIndice =  {m_iIndiceInicial};

                String m_sSiguientePalabra = DemeSiguientePalabra(m_Conexion, sTextoXBuscar, m_iIndiceInicial, m_piNuevoIndice);

                while (m_sSiguientePalabra.length() > 0)
                {
                    String m_sPalabraSemejante = DemePalabraSemejante(m_Conexion, m_sSiguientePalabra);

                    m_sConsulta += " or d.PalabraSemejante like " + scm(m_sPalabraSemejante + "%");

                    if (MostrarDatosDepuracion())
                        AgregarADesglose(m_Desglose, m_iNumSiguienteDesglose, m_sSiguientePalabra + ", " + m_piNuevoIndice[0] + ", " + m_sPalabraSemejante, true);

                    m_iIndiceInicial = m_piNuevoIndice[0];
                    m_sSiguientePalabra = DemeSiguientePalabra(m_Conexion, sTextoXBuscar, m_iIndiceInicial, m_piNuevoIndice);
                } // while (m_sSiguientePalabra.length() > 0)
            } // if (sTextoXBuscar != null)

            m_sConsulta += ")";
            m_sConsulta += " group by a.IdUsuario, a.Usuario, a.Cedula, a.Nombre";
            m_sConsulta += " order by NumAciertos desc, a.Nombre asc";

            if (MostrarDatosDepuracion())
                AgregarADesglose(m_Desglose, m_iNumSiguienteDesglose, m_sConsulta, true);

            ResultSet m_ResultSet = ConsultarSQL(m_Conexion, m_sConsulta);

            m_Resultados = new HashMap<String, Object[]>();
            Integer [] m_iNumResultados = {0};
            InicializarNumResultados(m_iNumResultados);

            while(m_ResultSet.next())
            {
                int pw_iIdUsuario = m_ResultSet.getInt(2);
                String pw_sUsuario = m_ResultSet.getString(3);
                Object [] m_FilaDatos = {DemeLinkUsuario(pw_iIdUsuario, pw_sUsuario + "><"), m_ResultSet.getString(4), m_ResultSet.getString(5), "</td>><"};
                m_Resultados.put(DemeLlaveNumResultados(m_iNumResultados), m_FilaDatos);
                IncrementarNumResultados(m_iNumResultados);
            } // while(m_ResultSet.next())

            String [] m_Encabezados = {"Usuario", "Cédula", "Nombre", "<td><<>>"};
            int [] m_AlineamientoDatos = {IdOfTextAlignRight(), IdOfTextAlignLeft(), IdOfTextAlignJustify(), IdOfTextAlignCenter()};
            Boolean [] m_EncodeHTML = {false, true, true, true};

            pMetaDatos[0] = m_Encabezados;
            pMetaDatos[1] = m_AlineamientoDatos;
            pMetaDatos[2] = m_EncodeHTML;
        } // try {
        catch(Exception e)
        {
            throw new Exception(e.getMessage());
        } // catch(Exception e)
        finally {
            if (m_Conexion != null)
                m_Conexion.close();
        } // finally {

        return m_Resultados;
    } // HashMap ConsultarXTodosUsuarios(String sTextoXBuscar, Object [] pDesglose, Object [] piNumSiguienteDesglose, Object [] pEncabezados) throws Exception

    HashMap ConsultarXTodosUsuarios2(Object [] pDesglose, Object [] piNumSiguienteDesglose) throws Exception
    {
        HashMap<String, Object[]> m_Resultados = null;

        Connection m_Conexion = null;
        HashMap<String, String> m_Desglose = (HashMap<String, String>) pDesglose[0];
        Integer [] m_iNumSiguienteDesglose = (Integer[]) piNumSiguienteDesglose[0];

        try {
            m_Conexion = Conectarse();

            String m_sConsulta = "select Usuario, Cedula, Nombre";
            m_sConsulta += " from Usuarios";
            m_sConsulta += " order by Usuario asc";

            if (MostrarDatosDepuracion())
                AgregarADesglose(m_Desglose, m_iNumSiguienteDesglose, m_sConsulta, true);

            ResultSet m_ResultSet = ConsultarSQL(m_Conexion, m_sConsulta);

            Integer [] m_iNumResultados = {0};
            InicializarNumResultados(m_iNumResultados);

            m_Resultados = new HashMap<String, Object[]>();
            Object [] m_Encabezados = {"Usuario", "Cédula", "Nombre"};
            m_Resultados.put(DemeLlaveNumResultados(m_iNumResultados), m_Encabezados);
            IncrementarNumResultados(m_iNumResultados);

            while(m_ResultSet.next())
            {
                String pw_sUsuario = m_ResultSet.getString(1);
                String pw_sCedula = m_ResultSet.getString(2);
                String pw_sNombre = m_ResultSet.getString(3);
                Object [] m_FilaDatos = {pw_sUsuario, pw_sCedula, pw_sNombre};
                m_Resultados.put(DemeLlaveNumResultados(m_iNumResultados), m_FilaDatos);
                IncrementarNumResultados(m_iNumResultados);
            } // while(m_ResultSet.next())
        } // try {
        catch(Exception e)
        {
            throw new Exception(e.getMessage());
        } // catch(Exception e)
        finally {
            if (m_Conexion != null)
                m_Conexion.close();
        } // finally {

        return m_Resultados;
    } // HashMap ConsultarXTodosUsuarios2(Object [] pDesglose, Object [] piNumSiguienteDesglose) throws Exception

    JsonObject CrearObjetoJsonUsuario(String sIdUsuario, String sCedula, String sNombre)
    {
        JsonObject m_NuevoObjeto = new JsonObject();
        m_NuevoObjeto.addProperty("IdUsuario", sIdUsuario);
        m_NuevoObjeto.addProperty("Cedula", sCedula);
        m_NuevoObjeto.addProperty("Nombre", sNombre);
        return m_NuevoObjeto;
    } // JsonObject CrearObjetoJsonUsuario(String sIdUsuario, String sCedula, String sNombre)

    void LanzarErrorUsuario(int iNumError, String sDato1) throws Exception
    {
        String m_sDescError = "";

        if (iNumError == 1001)
            m_sDescError = "El parámetro IdUsuario debe ser un número entero";

        else if (iNumError == 1002)
            m_sDescError = "No existe el usuario con el id " + sDato1;

        throw new Exception(m_sDescError);
    } // void LanzarErrorUsuario(int iNumError, String sDato1) throws Exception

    JsonObject ConsultarXUsuario(Integer iIdUsuario, Object [] pDesglose, Object [] piNumSiguienteDesglose, int [] piNumError) throws Exception
    {
        JsonObject m_Resultado = null;

        Connection m_Conexion = null;
        HashMap<String, String> m_Desglose = (HashMap<String, String>) pDesglose[0];
        Integer [] m_iNumSiguienteDesglose = (Integer[]) piNumSiguienteDesglose[0];

        try {
            m_Conexion = Conectarse();

            String m_sConsulta = "select IdUsuario, Cedula, concat("+  scm("\\\"\"\"\\\"") + ", Nombre, " +  scm("\\\\\\\\''''<prueba>") + ")";
            m_sConsulta += " from Usuarios";
            m_sConsulta += " where IdUsuario = " + iIdUsuario.toString();

            if (MostrarDatosDepuracion())
                AgregarADesglose(m_Desglose, m_iNumSiguienteDesglose, m_sConsulta, true);

            ResultSet m_ResultSet = ConsultarSQL(m_Conexion, m_sConsulta);

            if(m_ResultSet.next())
                m_Resultado = CrearObjetoJsonUsuario(m_ResultSet.getString(1), m_ResultSet.getString(2), m_ResultSet.getString(3));
            else
                piNumError[0] = 1002;
        } // try {
        catch(Exception e)
        {
            throw new Exception(e.getMessage());
        } // catch(Exception e)
        finally {
            if (m_Conexion != null)
                m_Conexion.close();
        } // finally {

        return m_Resultado;
    } // JsonObject ConsultarXUsuario(Integer iIdUsuario, Object [] pDesglose, Object [] piNumSiguienteDesglose, int [] piNumError) throws Exception
%>