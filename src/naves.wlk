class NaveEspacial {
	var velocidad = 0
	var direccion = 0	
	var property nasta =0
	method velocidad(cuanto) { velocidad = cuanto }
	method acelerar(cuanto) { velocidad = (velocidad + cuanto).min(100000)}
	method desacelerar(cuanto) { velocidad = (velocidad-cuanto).max(0)}
	method cargarCombustible(litros){nasta+=litros}
	method descargarCombustible(litros){nasta-=litros}
	
	method irHaciaElSol() { direccion = 10 }
	method escaparDelSol() { direccion = -10 }
	method ponerseParaleloAlSol() { direccion = 0 }
	
	method acercarseUnPocoAlSol() { direccion += 1 }
	method alejarseUnPocoDelSol() { direccion -= 1 }
	method prepararViaje(){
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}
	method escapar()
	method avisar()
	
	method recibirAmenaza(){
		self.escapar()
		self.avisar()
	}
	method estaTranquila(){return nasta>=4000&&velocidad<=12000}
}

class Baliza inherits NaveEspacial{
	var property colorBaliza=""
	method cambiarColorDeBaliza(colorNuevo){
		colorBaliza=colorNuevo
	}
	override method prepararViaje(){
		super()
		self.cambiarColorDeBaliza("verde")
		self.ponerseParaleloAlSol()
	}
	override method escapar(){ self.irHaciaElSol()}
	override method avisar(){ self.cambiarColorDeBaliza("rojo")}
	override method estaTranquila(){return super()&& colorBaliza!="rojo"}
}

class NavePasajeros inherits NaveEspacial{
	var property pasajeros
	var property racionesComida
	var property racionesBebida
	method cargarComida(cuanto){racionesComida+=cuanto}
	method descargarComida(cuanto){racionesComida=(racionesComida-cuanto).max(0)}
	method cargarBebida(cuanto){racionesBebida+=cuanto}
	method descargarBebida(cuanto){racionesBebida=(racionesBebida-cuanto).max(0)}
	override method prepararViaje(){ 
		super()
		self.cargarComida(4*pasajeros)
		self.cargarBebida(6*pasajeros)
		self.irHaciaElSol()
	} 
	override method escapar(){self.acelerar(velocidad)}
	override method avisar(){
		self.descargarComida(pasajeros)
		self.descargarBebida(2*pasajeros)
	}
	
}

class NaveCombate inherits NaveEspacial{
	var visibilidad=false
	var estaArmado=false
	var mensajes =[]
	//method cambiarVisibilidad(){visibilidad = not visibilidad}
	method ponerseVisible(){visibilidad=true}
	method ponerseInvisible(){visibilidad=false}
	method estaInvisible(){return visibilidad}
	method desplegarMisiles(){estaArmado=true}
	method replegarMisiles(){estaArmado=false}
	method misilesDesplegados(){return estaArmado}
	method emitirMensaje(mensaje){mensajes.add(mensaje)}
	method mensajesEmitidos(){return mensajes.map()}
	method primerMensajeEmitido(){return mensajes.first()}
	method ultimoMensajeEmitido(){return mensajes.last()}
	method esEscueta(){return not mensajes.any{mensaje=> mensaje.length()>=30}}
	method emitioMensaje(mensaje){mensajes.contains(mensaje)}
	override method prepararViaje(){
		super()
		self.acelerar(15000)
		self.ponerseVisible()
		self.desplegarMisiles()
		self.emitirMensaje("Saliendo en mision")
	}	
	override method escapar(){
		self.irHaciaElSol()
		self.irHaciaElSol()
	}
	override method avisar(){self.emitirMensaje("Amenaza recibida")}
	override method estaTranquila(){return not estaArmado}
}

class NaveHospital inherits NavePasajeros{
	var quirofanosPreparados=false
	override method recibirAmenaza(){
		super()
		quirofanosPreparados=true
	}	
	override method estaTranquila(){return not quirofanosPreparados}
}

class NaveCombateSiligosa inherits NaveCombate{
	override method escapar(){
		super()
		self.desplegarMisiles()
		self.ponerseInvisible()
	}
	override method estaTranquila(){return super()&& visibilidad }
}