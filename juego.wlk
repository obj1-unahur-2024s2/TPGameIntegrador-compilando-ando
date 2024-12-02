import gameManager.*
import main.*
import pelota.*
import raquetas.*
import mensajes.*

object menu {
	//INSTANCIO LOS MODOS DE JUEGO
	var property singlePlayer = new JugarContraElBot()
	var property multiPlayer = new JugadorContraJugador()
	
	method image() = "menu2.jpg"
	
	method position() = game.at(0, 0)
	
	method iniciar() {
		keyboard.c().onPressDo(
			{ if ((not singlePlayer.estaActivo()) and (not multiPlayer.estaActivo())) {
					singlePlayer.activar()
					singlePlayer.play()
				} }
		)
		keyboard.x().onPressDo(
			{ if ((not multiPlayer.estaActivo()) and (not singlePlayer.estaActivo())) {
					multiPlayer.activar()
					multiPlayer.play()
				} }
		)
				keyboard.i().onPressDo(
			{ 
				game.addVisual(instrucciones)
			 }
			 
		)
						keyboard.left().onPressDo(
			{ 
				if(game.hasVisual(instrucciones))
				{
					game.removeVisual(instrucciones)
				}
			 }
						)
	}
	method clean()
	{
		singlePlayer= new JugarContraElBot()
		multiPlayer = new JugadorContraJugador()
	}
}

class ModoDeJuego {
	//JUGADOR PRINCIPAL
	const property jugador1 = new Jugador(
		position = game.at(0, gameManager.height_game() / 2),
		image = "rroja.png",
		areaColision = 0 .. 0
	)
	
	//const franjaSuperior = new Franja(position = game.at(0,gameManager.height_game()),image = "franja2.png")
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
	method init() {
		pelota.movimientoInicio()
		jugador1.configurarMovimiento()
	}
	
	//AGREGA LAS VISUALES GENERALES DEL JUEGO
	method ponerVisuales() {
		
		game.addVisual(pelota)
		game.addVisual(jugador1)
		game.addVisual(puntajeJugador)
	}
	
	//BORRA LAS VISUALES GENERALES DEL JUEGO
	method borrarVisuales() {
		game.allVisuals().forEach({ c => game.removeVisual(c) })
	}
	
	//ACTIVA EL MOVIMIENTO DE LA PELOTA Y PREGUNTA SI HAY PUNTO Y SI GANÓ O PERDIÓ
	method activarMovimientoContinuoPelota() {
		console.println(
			pelota.pelotaVelocidad().toString() + "velocidad de la pelota"
		)
		console.println(puntajeJugador.puntos().toString() + "puntaje jugador 1")
		self.configurarVelocidadDePelota(pelota.pelotaVelocidad(), "movimientopelota")
		// if(puntajeJugador.puntos() + puntajeRival.puntos() <= 4){
		// 	self.configurarVelocidadDePelota(pelota.pelotaVelocidad(),'movimientoPelota')
		// }
		// else if((puntajeJugador.puntos() + puntajeRival.puntos()).between(5, 8)){
		// 	//game.removeTickEvent('movimientoPelota')
		// 	//pelota.pelotaVelocidad(80)
		// 	//self.configurarVelocidadDePelota(pelota.pelotaVelocidad(),'movimientoPelota1')
		// }
		// else{
		// 	//game.removeTickEvent('movimientoPelota1')
		// 	//pelota.pelotaVelocidad(55)
		// 	//self.configurarVelocidadDePelota(pelota.pelotaVelocidad(),'movimientoPelota2')
		// }
	}
	
	method configurarVelocidadDePelota(velocidad, nombreOntick) {
		game.onTick(
			velocidad,
			nombreOntick,
			{ 
				pelota.movement()
				self.punto()
				self.gameOver()
			}
		)
	}
	
	//SUMA LOS PUNTOS PARA EL JUGADOR
	method punto()
	
	method play()
	
	method gameOver()
}

class JugarContraElBot inherits ModoDeJuego {
	const property bot = new Bot(
		position = game.at(gameManager.width_game() - 2, gameManager.height_game()),
		image = "razul.png",
		areaColision = 0 .. 0
	)
	
	method activarMovimientoContinuoBot() {
		game.onTick(
			bot.velocidad(),
			"movimientoBot",
			{ 
				bot.configurarMovimiento()
				return bot.area()
			}
		)
	}
	
	override method ponerVisuales() {
		super()
		game.addVisual(bot)
		game.addVisual(puntajeRival)
	}
	
	override method punto() {
		if ((gameManager.width_game() + 1) == pelota.position().x()) {
			puntajeJugador.sumarPunto()
			game.schedule(200, { pelota.movimientoInicio() })
			//self.activarMovimientoContinuoPelota()
		} else {
			if ((-1) == pelota.position().x()) {
				puntajeRival.sumarPunto()
				game.schedule(200, { pelota.movimientoInicio() })
				//self.activarMovimientoContinuoPelota()
			}
		}
	}
	
	override method play() {
				console.println("Entra al play de jugadores con bot"
		)
		self.init()
		game.removeVisual(menu)
		self.ponerVisuales()
		self.activarMovimientoContinuoPelota()
		self.activarMovimientoContinuoBot()
	}
	
	override method gameOver() {
		if (puntajeJugador.puntos() == 5) {
			self.borrarVisuales()
			game.addVisual(ganar)
			game.sound("win.mp3").play()
			game.removeVisual(ganar)
			game.stop()
			console.println("PASA POR ACA 1")
		} else {
			if (puntajeRival.puntos() == 1) {
				game.removeTickEvent("movimientopelota")
				game.addVisual(perdiste)
				const sonidowin = game.sound("win.mp3")
				sonidowin.play()
				console.println("PASA POR ACA 2")
				keyboard.enter().onPressDo({
				sonidowin.stop()
				gameManager.reiniciar()
		})

						
						}
		}
	}
}

class JugadorContraJugador inherits ModoDeJuego {
	const property jugador2 = new Jugador2(
		position = game.at(
			gameManager.width_game() - 2,
			gameManager.height_game() / 2
		),
		image = "razul.png",
		areaColision = 0 .. 0
	)
	
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
		if ((gameManager.width_game() + 1) == pelota.position().x()) {
			puntajeJugador.sumarPunto()
			game.schedule(400, { pelota.movimientoInicio() })
		} else {
			if ((-1) == pelota.position().x()) {
				puntajeRival.sumarPunto()
				game.schedule(400, { pelota.movimientoInicio() })
			}
		}
	}
	
	override method play() {
		self.init()
		game.removeVisual(menu)
		self.ponerVisuales()
		self.activarMovimientoContinuoPelota()
	}
	
	override method gameOver() {
		if (puntajeJugador.puntos() == 5) {
				game.removeTickEvent("movimientopelota")
				game.addVisual(ganarJugador1)
				const sonidowin = game.sound("win.mp3")
				sonidowin.play()
				keyboard.enter().onPressDo({
				sonidowin.stop()
				gameManager.reiniciar()
		})
		} else {
			if (puntajeRival.puntos() == 5) {
				game.removeTickEvent("movimientopelota")
				game.addVisual(ganarJugador2)
				const sonidowin = game.sound("win.mp3")
				sonidowin.play()
				keyboard.enter().onPressDo({
				sonidowin.stop()
				gameManager.reiniciar()
		})
			}
		}
	}
}