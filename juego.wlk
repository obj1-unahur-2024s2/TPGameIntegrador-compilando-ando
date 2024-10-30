import pelota.*
import raquetas.*
import franja.*

object pong {
  const property jugador1 = new Jugador(position = game.at(0, 14),image = "raqueta.png",areaColision = (0..0))
  const property bot = new Bot(position = game.at(24, 14),image = "bot.png",areaColision = (0..0))
  method mostrarMenu() {
    	game.addVisual(menu)
    }
  method init(){
		pelota.movimientoInicio()
		jugador1.configurarMovimiento()
	}
   
    method play(){
		self.init()
		game.removeVisual(menu)
		game.addVisual(franja)
		game.addVisual(jugador1)
		game.addVisual(bot)
		game.addVisual(pelota)
	
		game.onTick(pelota.pelotaVelocidad(), 'movimientoPelota', {
			pelota.movement()
			self.gameOver()
		})
		
		game.onTick(bot.velocidad(), 'movimientoBot' , {
			bot.configurarMovimiento()  
			bot.area()
		})
	}
	method gameOver() {
		if ([-1, 25].contains(pelota.position().x())){
			game.schedule(2000, {pelota.movimientoInicio()})
		}
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