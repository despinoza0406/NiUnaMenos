
class Agresion {
	var lugar
	var agresor
	var palabrasUtilizadas = []
	
	constructor(l,a,pu){
		lugar = l
		agresor = a
		palabrasUtilizadas = pu 
	}
	
	method esGrave(){
		return palabrasUtilizadas.any({palabra=>palabrasInaceptables.esInaceptable(palabra)})
	}
	method esIgnea(){
		return palabrasUtilizadas.contains("Fuego")
	}
	method agresor(){
		return agresor
	}
	
	
}

class AgresionFisica inherits Agresion{
	var elemento
	
	constructor(l,a,pu,el) = super(l,a,pu){
		elemento = el
	}
	override method esGrave(){
		return true
	}
	override method esIgnea(){
		return elemento == "Combustible" || super()
	}
}

object palabrasInaceptables{
	var palabrasInaceptables = ["Feminista","Feminazi","Perra","Fea","Linda","Hola"]
	method esInaceptable(palabra){
	return palabrasInaceptables.contains(palabra)
	}	
}


class Persona {
	var composicionFamiliar = []
	var actitud 
	var agresiones = []
	constructor (act){
		actitud = act
	}
	method recibirAgresion(agresion){
		agresiones.add(agresion) 
		self.considerarDenuncia(agresion)
	}
	method considerarDenuncia(agresion){
		if(agresion.esGrave() && self.agresionFamiliar(agresion) && actitud.hacerDenuncia(agresion,self)){
			self.hacerDenuncia(agresion)
		}
	}
	method hacerDenuncia(agresion){
		policia.recibirDenuncia(agresion,self)
	}
	method cantAgresiones(){
		return agresiones.size()
	}
	method agresionesFamiliaresGraves(){
		return agresiones.any({agresion => agresion.esGrave() && self.agresionFamiliar(agresion)})
	}
	method agresionFamiliar(agresion){
		return composicionFamiliar.contains(agresion.agresor())
	}
	method participarOrgSocial(){
		actitud = new Militante()
	}
	method acompaniamientoCercano(persona){
		actitud = persona.actitudPersonal()
	}
	method actitudPersonal(){
		return actitud
	}
	method amenazaDeMuerte(){
		actitud.amenazaDeMuerte(self)
	}
	method cambiarActitud(att){
		actitud = att
	}
}

class Miedosa {
	method hacerDenuncia(_){
		return false
	}
	method amenazaDeMuerte(_){
	}
}

class Paciente {
	var tolerancia
	constructor (t) {
		tolerancia = t
	}
	method hacerDenuncia(agresion,persona){
		return persona.cantAgresiones() > tolerancia
	}
	method amenazaDeMuerte(_){
		tolerancia *= 2
	}
	
}

class Aguerrida {
	method hacerDenuncia(agresion,persona){
		return persona.agresionesFamiliaresGraves()
	}
	method amenazaDeMuerte(persona){
		 persona.cambiarActitud(new Paciente(5))
	}
}

class Militante {
	method hacerDenuncia(a,p){
		return true
	}
	method amenazaDeMuerte(persona){
		 persona.cambiarActitud(new Aguerrida())
	}
}

object policia{
	var numeroDenuncia = 0
	var denuncias =[]
	method recibirDenuncia(agresion,persona){
		denuncias.add(new Denuncia(agresion,persona,numeroDenuncia))
		numeroDenuncia += 1
	}
}

class Denuncia {
	var agresion
	var victima
	var numeroDenuncia
	constructor (a,v,nD){
		agresion = a
		victima = v
		numeroDenuncia = nD
	}
}