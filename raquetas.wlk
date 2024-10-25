import pelota.*

class Raqueta {
  /*const property image
  var property position
  //var areaColision
  
  method movimiento() {
    keyboard.down().onPressDo({ 
			if(0 < self.position().y())
				self.position(self.position().down(1))})
		keyboard.up().onPressDo({ 
			if(game.height()-1 > self.position().y())
				self.position(self.position().up(1))})
  }*/
  
  /*method area() {
    areaColision = (position.y() - 1) .. (position.y() + 4)
  }*/
  
  //method areaColision() = areaColision
}

object raquetaBot {
  var property velocidad = 450
  var property position = game.at(24, 14)
  var areaColision = (0..0)
  method image() = "bot.png"
  method movimiento() {
    position = (game.at(position.x(), pelota.position().y()))
  }
  method area() { areaColision = (position.y() - 1 .. position.y() + 4) }
  method areaColision() = areaColision
}
object raquetaJugador {
  var property position = game.at(0, 14)
  var areaColision = (0..0)
  method image() = "raqueta.png"
  method movimiento(dir) {
    if (! ((position.y()==0 && dir<0) || (position.y()==22 && dir>0)) )
			self.position(position.up( dir ))
  }
  method area() { areaColision = (position.y() - 1 .. position.y() + 4) }
  method areaColision() = areaColision
}