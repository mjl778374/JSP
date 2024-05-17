<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

function ReemplazarTodo(sUnaHilera, sCaracteresXReemplazar, sCaracteresReemplazo)
{
    while (sUnaHilera.indexOf(sCaracteresXReemplazar) >= 0)
        sUnaHilera = sUnaHilera.replace(sCaracteresXReemplazar, sCaracteresReemplazo);

    return sUnaHilera;
} // function ReemplazarTodo(sUnaHilera, sCaracteresXReemplazar, sCaracteresReemplazo)

function FormatearParametroGet(sParametroXFormatear)
{
    sParametroXFormatear = sParametroXFormatear.toLowerCase();
    sParametroXFormatear = ReemplazarTodo(sParametroXFormatear, "%", "+");
    sParametroXFormatear = ReemplazarTodo(sParametroXFormatear, "á", "%E1");
    sParametroXFormatear = ReemplazarTodo(sParametroXFormatear, "é", "%E9");
    sParametroXFormatear = ReemplazarTodo(sParametroXFormatear, "í", "%ED");
    sParametroXFormatear = ReemplazarTodo(sParametroXFormatear, "ó", "%F3");
    sParametroXFormatear = ReemplazarTodo(sParametroXFormatear, "ú", "%FA");
    sParametroXFormatear = ReemplazarTodo(sParametroXFormatear, "ñ", "%F1");
    sParametroXFormatear = ReemplazarTodo(sParametroXFormatear, "ü", "%FC");
    sParametroXFormatear = ReemplazarTodo(sParametroXFormatear, "+", " ");
    sParametroXFormatear = ReemplazarTodo(sParametroXFormatear, "?", " ");
    sParametroXFormatear = ReemplazarTodo(sParametroXFormatear, "&", " ");
    sParametroXFormatear = ReemplazarTodo(sParametroXFormatear, "  ", " ");
    sParametroXFormatear = sParametroXFormatear.trim();
    sParametroXFormatear = ReemplazarTodo(sParametroXFormatear, " ", "+");
    return sParametroXFormatear;
} // function FormatearParametroGet(sParametroXFormatear)

function Buscar(sTextoXBuscar, sURLListado)
{
    window.location.href = sURLListado + "?TextoXBuscar=" + FormatearParametroGet(sTextoXBuscar);
} // function Buscar(sTextoXBuscar, sURLListado)

function AbrirURLEnNuevaVentana(sURL)
{
    window.open(sURL, '_blank');
} // function AbrirURLEnNuevaVentana(sURL)

function VaciarListaSeleccion(Ventana, sIdLista)
{
    var m_Lista = Ventana.document.getElementById(sIdLista);
    
    while(m_Lista.options.length > 1)
        m_Lista.remove(1);
} // function VaciarListaSeleccion(Ventana, sIdLista)

function AgregarAListaSeleccion(Ventana, sIdLista, sValor, sTexto)
{
    var m_Lista = Ventana.document.getElementById(sIdLista);
    var m_Opcion = Ventana.document.createElement("option");
    m_Opcion.text = sTexto;
    m_Opcion.value = sValor;
    m_Lista.add(m_Opcion);
} // function AgregarAListaSeleccion(Ventana, sIdLista, sValor, sTexto)
