import pelota.*
import raquetas.*
import franja.*
import mensajes.*
object menu{
	//INSTANCIO LOS MODOS DE JUEGO
	const property singlePlayer = new JugarContraElBot()
	const property multiPlayer = new JugadorContraJugador()
	
	method image() = "juego_menu.png"
	method position() = game.at(4,5);
	//CONFIGURA LAS TECLAS DEL MENÚ
	method iniciar() {	  	
		keyboard.c().onPressDo({
			if(not singlePlayer.estaActivo() and not multiPlayer.estaActivo()){
				singlePlayer.activar()
				singlePlayer.play()
			}
		})
		keyboard.x().onPressDo({
			if(not multiPlayer.estaActivo() and not singlePlayer.estaActivo()){
				multiPlayer.activar()
				multiPlayer.play()
			}
		})
	}
}
class ModoDeJuego {
	//JUGADOR PRINCIPAL
	const property jugador1 = new Jugador(position = game.at(0, 14),image = "rroja.png",areaColision = (0..0))
	//FRANJAS
  	const franjaCentral = new Franja(position = game.at(25.div(2),-5),image = "franja.png")
  	const franjaSuperior = new Franja(position = game.at(0,24.5),image = "franja2.png")
	//VARIABLE PARA ACTIVAR/DESACTIVAR LAS TECLAS DEL MENU
	var estaActivo = false 
  	method estaActivo() = estaActivo
  	method activar() {
		estaActivo = true
  	}
	method desactivar() {
	  estaActivo = false
	}
	//INICICIALIZA EL MOVIMIENTO DE LA PELOTA Y HABILITA LAS TECLAS DE LAS RAQUETAS
	method init(){
		pelota.movimientoInicio()
		jugador1.configurarMovimiento()
	}
	//AGREGA LAS VISUALES GENERALES DEL JUEGO
	method ponerVisuales() {
	  	game.addVisual(franjaCentral)
	  	game.addVisual(franjaSuperior)
	  	game.addVisual(pelota)
	  	game.addVisual(jugador1)
		game.addVisual(puntajeJugador)
	}
	//BORRA LAS VISUALES GENERALES DEL JUEGO
	method borrarVisuales() {
		game.allVisuals().forEach({c => game.removeVisual(c)})
	}
	//ACTIVA EL MOVIMIENTO DE LA PELOTA Y PREGUNTA SI HAY PUNTO Y SI GANÓ O PERDIÓ
	method activarMovimientoContinuoPelota() {
		console.println(pelota.pelotaVelocidad().toString() + "velocidad de la pelota")
		console.println(puntajeJugador.puntos().toString() + "puntaje jugador 1")
		if(puntajeJugador.puntos() + puntajeRival.puntos() <= 4){
			self.configurarVelocidadDePelota(pelota.pelotaVelocidad(),'movimientoPelota')
		}
		else if((puntajeJugador.puntos() + puntajeRival.puntos()).between(5, 8)){
			game.removeTickEvent('movimientoPelota')
			pelota.pelotaVelocidad(80)
			self.configurarVelocidadDePelota(pelota.pelotaVelocidad(),'movimientoPelota1')
		}
		else{
			game.removeTickEvent('movimientoPelota1')
			pelota.pelotaVelocidad(55)
			self.configurarVelocidadDePelota(pelota.pelotaVelocidad(),'movimientoPelota2')
		}
	}
	method configurarVelocidadDePelota(velocidad,nombreOntick) {
		game.onTick(velocidad, nombreOntick, {
		pelota.movement()
		self.punto()
		self.gameOver()})
	}
	//SUMA LOS PUNTOS PARA EL JUGADOR
	method punto()
	
	method play()

	method gameOver()
}
class JugarContraElBot inherits ModoDeJuego{
	const property bot = new Bot(position = game.at(23, 14),image = "razul.png",areaColision = (0..0)) 
	
	method activarMovimientoContinuoBot() {
		game.onTick(bot.velocidad(), 'movimientoBot' , {
			bot.configurarMovimiento()  
			bot.area()
		})
	}
	override method ponerVisuales() {
	  	super()
	  	game.addVisual(bot)
		game.addVisual(puntajeRival)
	}
	override method punto() {
	  	if(25 == pelota.position().x()){
			puntajeJugador.sumarPunto()
			game.schedule(2000, {pelota.movimientoInicio()})
			self.activarMovimientoContinuoPelota()
	  	}
		else if(-1 == pelota.position().x()){
			puntajeRival.sumarPunto()
			game.schedule(2000, {pelota.movimientoInicio()})
			self.activarMovimientoContinuoPelota()
		}
		else {}
	}
	override method play(){
		self.init()
		game.removeVisual(menu)
		self.ponerVisuales()
		self.activarMovimientoContinuoPelota()
		self.activarMovimientoContinuoBot()
	}
	override method gameOver() {
	  	if(puntajeJugador.puntos() == 10){
			self.borrarVisuales()
			game.addVisual(ganar)
			game.schedule(0,{game.stop()})
		}
		else if(puntajeRival.puntos() == 10){
			self.borrarVisuales()
			game.addVisual(perdiste)
			game.schedule(0,{game.stop()})
		}
		else{}
	}
	override method activarMovimientoContinuoPelota(){
		console.println(puntajeJugador.puntos().toString() + "puntaje rival")
		super()
	}
}
class JugadorContraJugador inherits ModoDeJuego {
	const property jugador2 = new Jugador2(position = game.at(23, 14),image = "razul.png",areaColision = (0..0))

	override method init() {
	  	super()
	  	jugador2.configurarMovimiento()
	}
	override method ponerVisuales() {
		super()
		game.addVisual(jugador2)
		game.addVisual(puntajeRival)
	}
	override method punto() {
	  	if(25 == pelota.position().x()){
			puntajeJugador.sumarPunto()
			game.schedule(2000, {pelota.movimientoInicio()})
	  	}
	  	else if(-1 == pelota.position().x()){
			puntajeRival.sumarPunto()
			game.schedule(2000, {pelota.movimientoInicio()})
	  	}
		else{}
	}
	override method play() {
		self.init()
		game.removeVisual(menu)
		self.ponerVisuales()
		self.activarMovimientoContinuoPelota()
	}
	override method gameOver() {
		if(puntajeJugador.puntos() == 5){
			game.addVisual(ganarJugador1)
			self.borrarVisuales()
			game.schedule(0,{game.stop()})
		}
	  	else if(puntajeRival.puntos() == 5){
	  		game.addVisual(ganarJugador2)
			self.borrarVisuales()
			game.schedule(0,{game.stop()})
		}
		else{}
	}
}