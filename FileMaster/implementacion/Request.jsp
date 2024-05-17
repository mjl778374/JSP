<%@ page language="java" %>
<%@ page import = "java.net.http.*"%>
<%!
    String DecodeQueryString(String sQueryString)
    {
        final String CARACTER_ESPECIAL = "%";
        
        if (sQueryString != null)
        {
            int m_iPosicionInicio = sQueryString.indexOf(CARACTER_ESPECIAL);
        
            while (m_iPosicionInicio >= 0)
            {
                int m_iPosicionFin = m_iPosicionInicio + 2;
                m_iPosicionInicio += 1;
            
                if (m_iPosicionFin < sQueryString.length())
                {
                    try {
                        String m_sHex = sQueryString.substring(m_iPosicionInicio, m_iPosicionFin+1);
                        int m_iDecimal = Integer.parseInt(m_sHex, 16);
                        String m_sCaracterDecodificado = Character.toString(m_iDecimal);
                        sQueryString = sQueryString.replace(CARACTER_ESPECIAL.concat(m_sHex), m_sCaracterDecodificado);
                    }
                    catch(Exception e) {
                    }
                } // if (m_iPosicionFin < sQueryString.length())
                
                m_iPosicionInicio = sQueryString.indexOf(CARACTER_ESPECIAL, m_iPosicionInicio);
            } // while (m_iPosicionInicio >= 0)
        } // if (sQueryString != null)
        
        return sQueryString;
    } // String String DecodeQueryString(String sQueryString)
    
    HashMap<String, String> GetParamsInQueryString(HttpServletRequest Request) throws Exception
    {
        HashMap<String, String> m_ParamsInQueryString = new HashMap<String, String>();    
        String m_sQueryString = Request.getQueryString();

        if (m_sQueryString != null)
        {
            m_sQueryString = DecodeQueryString(m_sQueryString);
            String[] m_Tuplas = m_sQueryString.split("&");
    
            for (int i = 0; i < m_Tuplas.length; i++) {
                String[] m_Tupla = m_Tuplas[i].split("=", 2);
                String m_sLlave = m_Tupla[0];
                String m_sValor = (m_Tupla.length > 1) ? m_Tupla[1] : "";

                if (m_ParamsInQueryString.get(m_sLlave) != null)
                    m_ParamsInQueryString.remove(m_sLlave);
                
                m_ParamsInQueryString.put(m_sLlave, m_sValor);
            } // for (int i = 0; i < m_Tuplas.length; i++) {
        } // if (m_sQueryString != null)
        
        return m_ParamsInQueryString;
    } // HashMap<String, String> GetParamsInQueryString(HttpServletRequest Request) throws Exception
%>
