<%@ page language="java" %>
<%!
    String OnMouseOver(String sIdItemMenu) throws Exception
    {
        return "document.getElementById('" + sIdItemMenu + "').className = 'ItemMenuSeleccionado';";
    } // String OnMouseOver(String sIdItemMenu) throws Exception

    String OnMouseOut(String sIdItemMenu, String sClaseItemMenu) throws Exception
    {
        if (!sClaseItemMenu.equals(""))
            return "";
        else
            return "document.getElementById('" + sIdItemMenu + "').className = '';";
    } // String OnMouseOut(String sIdItemMenu, String sClaseItemMenu) throws Exception

    String DemeMenuApp(String sIdFormulario) throws Exception
    {
        String m_sDesglose = "";
        String m_sClaseIdHome = "ItemMenuHome";
        String m_sClaseIdUsuario = "";
        String m_sClaseIdSalir = "";

        if (sIdFormulario.equals("Usuarios") || sIdFormulario.equals("Usuario"))
            m_sClaseIdUsuario = "ItemMenuSeleccionado";

        if (sIdFormulario.equals("Salir"))
            m_sClaseIdSalir = "ItemMenuSeleccionado";

        m_sDesglose += InsertarLinea("<ul id=\"Menu\">");

        m_sDesglose += InsertarLinea("<li id=\"ItemMenuHome\" class=\"" + m_sClaseIdHome + "\"><a href=\"main.jsp\">Inicio</a></li>");

        m_sDesglose += InsertarLinea("<li id=\"ItemMenuUsuario\" class=\"" + m_sClaseIdUsuario + "\"><a href=\"usuarios.jsp\" onmouseover=\"" + OnMouseOver("ItemMenuUsuario") + "\" onmouseout=\"" + OnMouseOut("ItemMenuUsuario", m_sClaseIdUsuario) + "\">Usuarios</a></li>");

        m_sDesglose += InsertarLinea("<li id=\"ItemMenuSalir\" class=\"" + m_sClaseIdSalir + "\"><a href=\"" + DemeURLIngreso() + "\" onmouseover=\"" + OnMouseOver("ItemMenuSalir") + "\" onmouseout=\"" + OnMouseOut("ItemMenuSalir", m_sClaseIdSalir) + "\">Salir</a></li>");

        m_sDesglose += InsertarLinea("</ul>");
        return m_sDesglose;
    } // String DemeMenuApp(String sIdFormulario) throws Exception

    String DemeEncabezadoArchivos(String sIdFormulario, Boolean bEsListado, String sURLListado) throws Exception
    {
        String m_sDesglose = "";
        
        m_sDesglose += DemeMenuApp(sIdFormulario);

        if (bEsListado)
            m_sDesglose += AgregarFormularioBusqueda("FormularioBusqueda", sURLListado);

        return m_sDesglose;
    } // String DemeEncabezadoArchivos(String sIdFormulario, Boolean bEsListado, String sURLListado) throws Exception

    String LlenarDesgloseTabla(Object [] pMetaDatos, HashMap Resultados) throws Exception
    {
        String m_sDesglose = "";
        String [] m_Encabezados = (String []) pMetaDatos[0];
        int [] m_AlineamientoDatos = (int []) pMetaDatos[1];
        Boolean [] m_EncodeHTML = (Boolean []) pMetaDatos[2];

        m_sDesglose += InsertarLinea("<table>");
        m_sDesglose += InsertarLinea("<tr>");

        for(int i= 0; i < m_Encabezados.length; i++)
            m_sDesglose += InsertarLinea("<th>" + HTMLEncode(m_Encabezados[i]) + "</th>");

        m_sDesglose += InsertarLinea("</tr>");
        Integer [] m_iNumResultados = {0};
        
        InicializarNumResultados(m_iNumResultados);
    
        while(Resultados.get(DemeLlaveNumResultados(m_iNumResultados)) != null) {
            Object [] m_FilaDatos = (Object []) Resultados.get(DemeLlaveNumResultados(m_iNumResultados));
            m_sDesglose += InsertarLinea("<tr>");

            for(int i= 0; i < m_FilaDatos.length; i++)
            {
                String m_sDato = m_FilaDatos[i].toString();

                if (m_EncodeHTML[i])
                    m_sDato = HTMLEncode(m_sDato);

                m_sDesglose += InsertarLinea("<td style=\"" + GetTextAlign(m_AlineamientoDatos[i]) + "\">" + m_sDato + "</td>");
            } // for(int i= 0; i < m_FilaDatos.length; i++)
            
            m_sDesglose += InsertarLinea("</tr>");
            IncrementarNumResultados(m_iNumResultados);
        } // while(Resultados.get(DemeLlaveNumResultados(m_iNumResultados)) != null) {

        m_sDesglose += InsertarLinea("</table>");

        return m_sDesglose;
    } // String LlenarDesgloseTabla(Object [] pMetaDatos, HashMap Resultados) throws Exception

    String LlenarDesgloseReporte(HashMap DatosEnReporte) throws Exception
    {
        String m_sDesglose = "";
        Integer [] m_iNumResultados = {0};
        
        InicializarNumResultados(m_iNumResultados);

        while(DatosEnReporte.get(DemeLlaveNumResultados(m_iNumResultados)) != null) {
            Object [] m_FilaDatos = (Object []) DatosEnReporte.get(DemeLlaveNumResultados(m_iNumResultados));

            for(int i= 0; i < m_FilaDatos.length; i++)
            {
                String m_sDato = m_FilaDatos[i].toString();
                m_sDesglose += m_sDato;

                if (i < m_FilaDatos.length - 1)
                    m_sDesglose += DemeSeparadorColumnasReportes();
            } // for(int i= 0; i < m_FilaDatos.length; i++)
            
            m_sDesglose += DemeSeparadorFilasReportes();
            IncrementarNumResultados(m_iNumResultados);
        } // while(Resultados.get(DemeLlaveNumResultados(m_iNumResultados)) != null) {

        return m_sDesglose;
    } // String LlenarDesgloseReporte(HashMap DatosEnReporte) throws Exception

    String AgregarControlTexto(String sLeyenda, String sNombreControl, String sValor, int iAlineamiento, String sClase) throws Exception
    {
        return InsertarLinea(sLeyenda + "<input type=\"text\" class=\"" + sClase + "\" style=\"" + GetTextAlign(iAlineamiento) + "\" name=\"" + sNombreControl + "\" value=\"" + sValor + "\"/>");
    } // String AgregarControlTexto(String sLeyenda, String sNombreControl, String sValor) throws Exception

    String AgregarControlTextoContrasena(String sLeyenda, String sNombreControl, int iAlineamiento, String sClase) throws Exception
    {
        return InsertarLinea(sLeyenda + "<input type=\"password\" class=\"" + sClase + "\" style=\"" + GetTextAlign(iAlineamiento) + "\" name=\"" + sNombreControl + "\"/>");
    } // String AgregarControlTextoContrasena(String sLeyenda, String sNombreControl, int iAlineamiento, String sClase)

    String AgregarBoton(String sLeyenda, String sAccion) throws Exception
    {
        return InsertarLinea("<input type=\"button\" class=\"Boton\" value=\"" + sLeyenda + "\" onclick=\"" + sAccion + "\"/>");
    } // String AgregarBoton(String sLeyenda, String sAccion) throws Exception

    String AgregarBotonSubmit(String sLeyenda) throws Exception
    {
        return InsertarLinea("<input type=\"submit\" class=\"Boton\" value=\"" + sLeyenda + "\"/>");
    } // String AgregarBotonSubmit(String sLeyenda) throws Exception

    String AgregarBotonera(String sURLRegresar) throws Exception
    {
        String m_sDesglose = "";
        m_sDesglose += InsertarLinea("<div class=\"Botonera\">");
        m_sDesglose += AgregarBoton("Regresar", "window.location.href = '" + sURLRegresar + "';");
        m_sDesglose += InsertarLinea("</div>");
        return m_sDesglose;
    } // String AgregarBotonera(String sURLRegresar) throws Exception

    String AgregarBotoneraLogin() throws Exception
    {
        String m_sDesglose = "";
        m_sDesglose += InsertarLinea("<div class=\"Botonera\">");
        m_sDesglose += AgregarBotonSubmit("Ingresar");
        m_sDesglose += InsertarLinea("</div>");
        return m_sDesglose;
    } // String AgregarBotoneraLogin() throws Exception

    String AgregarFormularioDesglose(String sContenido, String sNombreFormulario) throws Exception
    {
        String m_sDesglose = "";
        m_sDesglose += InsertarLinea("<form name=\"" + sNombreFormulario + "\" class=\"FormularioDesglose\" method=\"post\">");
        m_sDesglose += sContenido;
        m_sDesglose += InsertarLinea("</form>");
        return m_sDesglose;
    } // String AgregarFormularioDesglose(String sContenido, String sNombreFormulario) throws Exception

    String AgregarFormularioBusqueda(String sNombreFormulario, String sURLListado) throws Exception
    {
        String m_sDesglose = "";
        m_sDesglose += InsertarLinea("<form name=\"" + sNombreFormulario + "\" class=\"FormularioBusqueda\">");
        m_sDesglose += AgregarControlTexto("", "TextoXBuscar", "", IdOfTextAlignLeft(), "CampoTextoBusqueda");
        m_sDesglose += AgregarBoton("Buscar", "Buscar(" + sNombreFormulario + ".TextoXBuscar.value, '" + sURLListado + "');");
        m_sDesglose += InsertarLinea("</form>");
        return m_sDesglose;
    } // String AgregarFormularioBusqueda(String sNombreFormulario) throws Exception
%>
