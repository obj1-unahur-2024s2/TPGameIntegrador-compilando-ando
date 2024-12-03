import gameManager.*
import pelota.*
import raquetas.*
import franja.*
import mensajes.*

object  menu {
	var property singlePlayer= new JugarContraElBot()
	var property multiPlayer = new JugadorContraJugador()
	method clearGame() {
		game.allVisuals().forEach({ visual => game.removeVisual(visual) })
	}
	method image() = "juego_menu1.png"
	method position() = game.at(4,5);
	method clean()
    {
        singlePlayer= new JugarContraElBot()
        multiPlayer = new JugadorContraJugador()
    }
		
	method iniciar() {	  
			keyboard.c().onPressDo({
				if(not singlePlayer.estaActivo() and not multiPlayer.estaActivo()){
					singlePlayer.activar()
					singlePlayer.play()
				}
			})
		keyboard.x().onPressDo({if(not singlePlayer.estaActivo() and not multiPlayer.estaActivo()){
				multiPlayer.activar()
				multiPlayer.play()
		}
			
		})
		
	}
}
class ModoDeJuego {
	//JUGADOR PRINCIPAL
	var property jugador1 = new Jugador(position = game.at(0, 14),image = "raqueta1.png",areaColision = (0..0))
	//FRANJAS
  	var franjaCentral = new Franja(position = game.at(25.div(2),-5),image = "franja.png")
  	var franjaSuperior = new Franja(position = game.at(0,24.5),image = "franja2.png")
	//OBSTACULOS
	var property obstaculos = []
	//VARIABLE PARA ACTIVAR/DESACTIVAR LAS TECLAS DEL MENU
	var estaActivo = false 
  	method estaActivo() = estaActivo
  	method activar() {
			estaActivo = !estaActivo
  	}

	//INICICIALIZA EL MOVIMIENTO DE LA PELOTA Y HABILITA LAS TECLAS DE LAS RAQUETAS

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
		game.removeVisual(obstaculos.first())
	}
	//ACTIVA EL MOVIMIENTO DE LA PELOTA Y PREGUNTA SI HAY PUNTO Y SI GANÓ O PERDIÓ
	method activarMovimientoContinuoPelota() {
	
		game.onTick(pelota.pelotaVelocidad(), 'movimientoPelota', {
			pelota.movement()
			self.punto()
				
			self.gameOver()
			self.agregarObstaculo()
		})
	}
	method agregarObstaculo() {
	  if(puntajeJugador.puntos() + puntajeRival.puntos() > 4 and obstaculos.isEmpty()){
		obstaculos.add(new Obstaculo(position = game.at(11, 0),image = "raqueta.png",areaColision = (0..0)))
		game.addVisual(obstaculos.first())
		obstaculos.first().configurarMovimiento()
		/*
	  if(puntajeJugador.puntos() + puntajeRival.puntos() > 4 and obstaculos.isEmpty()){
		obstaculos.addAll([new Obstaculo(position = game.at(10, 0),image = "raqueta.png",areaColision = (0..0)),new Obstaculo(position = game.at(13, 19),image = "raqueta.png",areaColision = (0..0))])
		game.addVisual(obstaculos.first())
		game.addVisual(obstaculos.last())
		obstaculos.forEach({c => c.configurarMovimiento()})
		*/
	  }
	}

	//SUMA LOS PUNTOS PARA EL JUGADOR
	method punto()
	
	method play()

	method gameOver()
}
class JugarContraElBot inherits ModoDeJuego{
	var property bot = new Bot(position = game.at(24, 14),image = "bot1.png",areaColision = (0..0)) 
	
	method activarMovimientoContinuoBot() {
		game.onTick(bot.velocidad(), 'movimientoBot' , {
			bot.configurarMovimiento()  
			bot.area()
		})
	}
	override method ponerVisuales() {
	  	super()
			puntajeJugador.puntos(0)
	  	game.addVisual(bot)
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
	}
	override method play(){
		pelota.movimientoInicio()
		jugador1.configurarMovimiento()
		game.removeVisual(menu)
		self.ponerVisuales()
		self.activarMovimientoContinuoBot()
		self.activarMovimientoContinuoPelota()
			
	}
	
	override method gameOver() {
	  	if(puntajeJugador.puntos() == 8){
				game.removeTickEvent("movimientopelota")
							   
          
			const sonidowin = game.sound("assets_win.mp3")
				sonidowin.play()
				gameManager.reiniciar(ganar)
		}
		else if(puntajeRival.puntos() == 8){
					game.removeTickEvent("movimientopelota")
					const sonidowin = game.sound("sad-trumpet-46384.mp3")
					sonidowin.play()
					gameManager.reiniciar(perdiste)
		}
	}
}
class JugadorContraJugador inherits ModoDeJuego {
    const property jugador2 = new Jugador2(position = game.at(24, 14),image = "bot1.png",areaColision = (0..0))

     method init() {
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
					pelota.movimientoInicio()
		jugador1.configurarMovimiento()
				jugador2.configurarMovimiento()

        game.removeVisual(menu)
        self.ponerVisuales()
		self.activarMovimientoContinuoPelota()
    }
    override method gameOver() {
		if(puntajeJugador.puntos() == 8){
			game.removeTickEvent("movimientopelota")
              
					const sonidowin = game.sound("assets_win.mp3")
				sonidowin.play()
				gameManager.reiniciar(ganarJugador1)
		}
	  	else if(puntajeRival.puntos() == 8){
	  		game.removeTickEvent("movimientopelota")

					const sonidowin = game.sound("assets_win.mp3")
				sonidowin.play()
				gameManager.reiniciar(ganarJugador2)
		
              
		}
		}
}