import pelota.*
class Raqueta {
  const property image
  var property position
  var areaColision
  method configurarMovimiento() {
    keyboard.down().onPressDo({ 
			if(0 < self.position().y()){
				self.position(self.position().down(2))
      }
      self.area()
    })  
		keyboard.up().onPressDo({ 
			if(game.height()-1 > self.position().y()){
				self.position(self.position().up(2))
      }
      self.area()
    })
  }
  method area() {
    areaColision = (position.y() - 1) .. (position.y() + 4)
  }
  method areaColision() = areaColision
}
class Jugador inherits Raqueta {}
class Bot inherits Raqueta {
  var property velocidad = 350
  override method configurarMovimiento() {
    position = (game.at(position.x(), pelota.position().y()))
  }
}