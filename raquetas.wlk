import pelota.*
class Raqueta {
  const property image
  var property position
  var areaColision
  method configurarMovimiento()
  method area() {
    areaColision = (position.y()-1) .. (position.y() + 4)
  }
  method areaColision() = areaColision
}
class Jugador inherits Raqueta {
  override method configurarMovimiento() {
    keyboard.down().onPressDo({ 
			if(0 < self.position().y()){
				self.position(self.position().down(2))
      }
      self.area()
    })  
		keyboard.up().onPressDo({ 
			if(game.height()-4 > self.position().y()){
				self.position(self.position().up(2))
      }
      self.area()
    })
  }
}
class Jugador2 inherits Raqueta{
  override method configurarMovimiento() {
    keyboard.s().onPressDo({ 
			if(0 < self.position().y()){
				self.position(self.position().down(2))
      }
      self.area()
    })  
		keyboard.w().onPressDo({ 
			if(game.height() - 4> self.position().y()){
				self.position(self.position().up(2))
      }
      self.area()
    })
  }
}
class Bot inherits Raqueta {
  var property velocidad = 550
  override method configurarMovimiento() {
    position = (game.at(position.x(), pelota.position().y()))
  }
}

class Obstaculo inherits Raqueta {
  var orientacion = up
  override method configurarMovimiento() {
    game.onTick(350, 'movimientoObstaculo', {self.desplazarse()})
  }
  method desplazarse() {
    self.avanzar()
    if(self.llego())
       self.girar()
  }
  method avanzar() {
    position = orientacion.adelante(position)
    self.area()
  }
  method llego() =
      orientacion.enElBorde(position)
  method girar() {
    orientacion = orientacion.opuesto()
  }
}
object up{
  method opuesto() = down
  method adelante(position) = position.up(2)
  method enElBorde(position) = !(20 > position.y())
}
object down{
  method opuesto() = up
  method adelante(position) = position.down(2)
  method enElBorde(position) = position.y() <= 0
}