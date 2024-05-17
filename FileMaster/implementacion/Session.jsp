<%@ page language = "java" %>
<%!
    void IngresarASesion(Integer iIdUsuario, HttpSession Session)
    {
        Session.setAttribute("IdUsuarioSesion", iIdUsuario);
    } // void IngresarASesion(Integer iIdUsuario, HttpSession Session)

    void AbandonarSesion(HttpSession Session)
    {
        Session.setAttribute("IdUsuarioSesion", "");
    } // void AbandonarSesion(HttpSession Session)

    Boolean ValidarIngresoSesion(HttpSession Session) {
        Boolean m_bResultado = false;
        try {
            String m_sIdUsuario = Session.getAttribute("IdUsuarioSesion").toString();

            if (m_sIdUsuario != null && EsNumeroEntero(m_sIdUsuario))
                m_bResultado = true;
            else 
                m_bResultado = false;
        } // try {
        catch(Exception e) {}
        finally {}

        return m_bResultado;
    } // Boolean ValidarIngresoSesion(HttpSession Session) {

    String DemeIdUsuarioSesion(HttpSession Session)
    {
        return Session.getAttribute("IdUsuarioSesion").toString();
    } // String DemeIdUsuarioSesion(HttpSession Session)

    String DemeNombreUsuarioSesion(HttpSession Session,  int [] piNumError)
    {
        String m_sNombre = "";

        Integer [] m_iNumSiguienteDesgloseFormulario = {0};
        HashMap<String, String> m_DesgloseFormulario = new HashMap<String, String>();

        try {

            String m_sIdUsuario = Session.getAttribute("IdUsuarioSesion").toString();

            Object [] m_pDesgloseFormulario = {m_DesgloseFormulario};
            Object [] m_piNumSiguienteDesgloseFormulario = {m_iNumSiguienteDesgloseFormulario};

            JsonObject m_Resultado = null;
            int m_iNumError = 0;
;
            if (m_sIdUsuario != null && EsNumeroEntero(m_sIdUsuario))
            {
                int m_iIdUsuario = (Integer) Integer.parseInt(m_sIdUsuario, 10);
                m_Resultado = ConsultarXUsuario(m_iIdUsuario, m_pDesgloseFormulario, m_piNumSiguienteDesgloseFormulario, piNumError);
            } // if (m_sIdUsuario != null && EsNumeroEntero(m_sIdUsuario))

            if (m_Resultado != null)
                m_sNombre = FormatJsonStringValue(m_Resultado.get("Nombre").toString(), true);
        } // try {
        catch(Exception e) {}
        finally {}

        return m_sNombre;
    } // String DemeNombreUsuarioSesion(HttpSession Session)
%>