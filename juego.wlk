import pelota.*
import raquetas.*
import franja.*
import mensajes.*
object menu{
	const property singlePlayer = new JugarContraElBot()
	const property multiPlayer = new JugadorContraJugador()
	method image() = "juego_menu.png"
	method position() = game.at(4,5);
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
object pasto {
  	method image() = "pasto.png"
  	method position() = game.at(2,2)  
}
class ModoDeJuego {
	//JUGADOR PRINCIPAL
	const property jugador1 = new Jugador(position = game.at(0, 14),image = "raqueta.png",areaColision = (0..0))
	//FRANJAS
  	const franjaCentral = new Franja(position = game.at(25.div(2),-5),image = "franja.png")
  	const franjaSuperior = new Franja(position = game.at(0,24.5),image = "franja2.png")
	//PUNTOS
  	var puntoJugador = 0
	//VARIABLE PARA DESACTIVAR LAS TECLAS DEL MENU
	var estaActivo = false
  	method estaActivo() = estaActivo
  	method activar() {
		estaActivo = true
  	}
	//INICICIALIZA EL MOVIMIENTO DE LA PELOTA Y HABILITA LAS TECLAS DE LAS RAQUETAS
	method init(){
		pelota.movimientoInicio()
		jugador1.configurarMovimiento()
	}
	
	method ponerVisuales() {
	  	game.addVisual(franjaCentral)
	  	game.addVisual(franjaSuperior)
	  	game.addVisual(pelota)
	  	game.addVisual(jugador1)
	}
	method borrarVisuales() {
	  	game.removeVisual(franjaCentral)
		game.removeVisual(franjaSuperior)
		game.removeVisual(jugador1)
		game.removeVisual(pelota)
	}

	method activarMovimientoContinuoPelota() {
	  	game.onTick(pelota.pelotaVelocidad(), 'movimientoPelota', {
			pelota.movement()
			self.punto()
			self.gameOver()
		})
	}
	method punto() {
	  	if(25 == pelota.position().x()){
			puntoJugador = puntoJugador + 1
			game.schedule(2000, {pelota.movimientoInicio()})
	  	}
  	}
	method play()

	method gameOver() {
	  	if(puntoJugador == 3){
			game.addVisual(ganar)
			self.borrarVisuales()
				game.schedule(0,{game.stop()})
		}
	}
}
class JugarContraElBot inherits ModoDeJuego{
	const property bot = new Bot(position = game.at(24, 14),image = "bot.png",areaColision = (0..0))
	var puntoBot = 0
	
	method activarMovimientoContinuoBot() {
		game.onTick(bot.velocidad(), 'movimientoBot' , {
			bot.configurarMovimiento()  
			bot.area()
		})
	}
	override method ponerVisuales() {
	  	super()
	  	game.addVisual(bot)
	}
	override method borrarVisuales() {
	  	super()
	  	game.removeVisual(bot)
	}
	override method punto() {
	  	super()
	  	if(-1 == pelota.position().x()){
			puntoBot = puntoBot + 1
			game.schedule(2000, {pelota.movimientoInicio()})
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
	  	super()
	  	if(puntoBot == 3){
	  		game.addVisual(perdiste)
			self.borrarVisuales()
				game.schedule(0,{game.stop()})
		}
	}
}
class JugadorContraJugador inherits ModoDeJuego {
	const property jugador2 = new Jugador2(position = game.at(24, 14),image = "raqueta.png",areaColision = (0..0))
	var puntoJugador2 = 0

	override method init() {
	  	super()
	  	jugador2.configurarMovimiento()
	}
	override method ponerVisuales() {
		super()
		game.addVisual(jugador2)
	}
	override method borrarVisuales() {
	  	super()
	  	game.removeVisual(jugador2)
	}
	override method punto() {
	  	super()
	  	if(-1 == pelota.position().x()){
			puntoJugador2 = puntoJugador2 + 1
			game.schedule(2000, {pelota.movimientoInicio()})
	  	}
		else {}
	}
	override method play() {
		self.init()
		game.removeVisual(menu)
		self.ponerVisuales()
		self.activarMovimientoContinuoPelota()
	}
	override method gameOver() {
	  	super()
	  	if(puntoJugador2 == 3){
	  		game.addVisual(perdiste)
			self.borrarVisuales()
				game.schedule(0,{game.stop()})
		}
	}
}