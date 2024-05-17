<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<script>
	function myFunction(Ventana, sIdCombo, sValor, sTexto)
	{
  		var combo = Ventana.document.getElementById(sIdCombo);
  		var option = Ventana.document.createElement("option");
  		option.text = sTexto;
  		option.value = sValor;
  		combo.add(option);
	} // function myFunction(Ventana, sIdCombo, sValor, sTexto)

	function myFunction2(Ventana, sIdCombo)
	{
		var combo = Ventana.document.getElementById(sIdCombo);
		
		alert("número de elementos en el combo antes de remover: " + combo.options.length);

		while(combo.options.length > 1)
			combo.remove(1);

		alert("número de elementos en el combo después de remover: " + combo.options.length);
	} // function myFunction2(Ventana, sIdCombo)

	<%
		out.println("alert('parámetro prueba: " + request.getParameter("prueba") + "');");
		String valor = "1_2_\"_4";
		String[] data = valor.split("_");
		for(int i = 0; i < data.length; i++)
			out.println	("alert(' Elemento en la posición " + i + " del arreglo: " + data[i] + "');");

	%>

	var combo = window.parent.document.getElementById("combo");
	var valor = combo.value;
	alert("valor seleccionado en el combo: " + valor);
	var data = valor.split("_");

	alert("Número de elementos en el arreglo: " + data.length);

	for (var i = 0; i < data.length; i++)
		alert("Elemento en el puesto " + i + " del arreglo: " + data[i]);

	window.parent.VaciarListaSeleccion(window.parent, "combo");
	window.parent.AgregarAListaSeleccion(window.parent, "combo", 5, "Pescado");
	window.parent.AgregarAListaSeleccion(window.parent, "combo", 4, "Tomate");	
	window.parent.AgregarAListaSeleccion(window.parent, "combo", 6, "Sardina");	
	var combo = window.parent.document.getElementById("combo");			
	alert("número de elementos en el combo: " + combo.options.length);
</script>								