<%@ page language="java" %>
<%!    
    void InicializarLlaveDesglose(Integer [] iNumConsecutivo) throws Exception
    {
        iNumConsecutivo[0] = 1;
    } // void InicializarLlaveDesglose(Integer [] iNumConsecutivo) throws Exception
    
    String DemeLlaveDesglose(Integer [] iNumConsecutivo) throws Exception
    {
        return iNumConsecutivo[0].toString();
    } // String DemeLlaveDesglose(Integer [] iNumConsecutivo) throws Exception
        
    void AsignarNuevaLlaveDesglose(Integer [] iNumConsecutivo) throws Exception
    {
        iNumConsecutivo[0] += 1;
    } // void AsignarNuevaLlaveDesglose(Integer [] iNumConsecutivo) throws Exception
    
    void AgregarADesglose(HashMap Desglose, Integer [] iNumConsecutivo, String sHileraXAgregar, Boolean bEncuadrarDentroParrafo) throws Exception
    {
        if (bEncuadrarDentroParrafo)
            sHileraXAgregar = "<p>" + sHileraXAgregar + "</p>" + "\n";
            
        Desglose.put(DemeLlaveDesglose(iNumConsecutivo), sHileraXAgregar);
        AsignarNuevaLlaveDesglose(iNumConsecutivo);
    } // void AgregarADesglose(HashMap Desglose, Integer [] iNumConsecutivo, String sHileraXAgregar, Boolean bEncuadrarDentroParrafo) throws Exception
%>
