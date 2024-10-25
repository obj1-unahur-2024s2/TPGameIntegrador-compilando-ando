import pelota.*
import raquetas.*
import franja.*

object pong {
  method mostrarMenu() {
    game.addVisual(menu)
  }
  method init(){
		pelota.movimientoInicio()
				
		keyboard.up().onPressDo({
			raquetaJugador.movimiento(2)
			raquetaJugador.area()
		})
		keyboard.down().onPressDo({
			raquetaJugador.movimiento(-2)
			raquetaJugador.area()
		})
		
	}
   
    method play(){
		self.init()
		game.removeVisual(menu)
		game.addVisual(franja)
		game.addVisual(raquetaJugador)
		game.addVisual(raquetaBot)
		game.addVisual(pelota)
		
	
		game.onTick(pelota.pelotaVelocidad(), 'movimiento', {
			pelota.movement()
			pelota.gameOver()
		})
		
		game.onTick(raquetaBot.velocidad(), 'movimientoIa' , {
			raquetaBot.movimiento()  
			raquetaBot.area()
		})
	}
}
object menu{
	method image() = "pong_menu.png"
	method position() = game.at(2,2);
	method iniciar() {
	  keyboard.c().onPressDo({
		pong.play()
	  })
	}
}