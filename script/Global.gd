extends Node



var idioma_actual: String = "es" 
var traducciones = {}

func _ready():
	var file = FileAccess.open("res://traducciones.json", FileAccess.READ)
	if file:
		var text = file.get_as_text()
		traducciones = JSON.parse_string(text)
		print("Traducciones cargadas: ", traducciones)
		
		
func traducir(clave: String) -> String:
	if clave in traducciones:
		return traducciones[clave].get(idioma_actual, clave)
	else:
		return clave 
