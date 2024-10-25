import franja.*
import raquetas.*
import juego.*


object pelota {
  const numeros = [1, -1]
  var direccionX = -1
  var direccionY = -1
  var property pelotaVelocidad = 100
  const image = "pelota.png"
  var property position = game.at(10, 12)
  method numeros() = numeros
  
  method image() = image
  
  method pelotaVelocidad() = pelotaVelocidad
  
  method movimientoInicio() {
    position = game.at(10, 12)
    direccionX = numeros.anyOne()
    direccionY = numeros.anyOne()
  }
  
  method movement() {
    self.position(position.up(direccionY).right(direccionX))
    self.movementY()
    self.movementX()
  }
  
  method movementY() {
    if ([0, 24].contains(position.y())) {
      direccionY *= -1
    }
  }
  
  method movementX() {
    if ((position.x() == 1) && raquetaJugador.areaColision().contains(position.y())) {
      direccionX = 1
    }
    if ((position.x() == 23) && raquetaBot.areaColision().contains(position.y())) {
      direccionX = -1
    }
  }
  
  method gameOver() {
    if ([-1, 25].contains(position.x())){
      
      pong.mostrarMenu()
      game.removeVisual(self)
      game.removeVisual(raquetaJugador)
      game.removeVisual(raquetaBot)
      game.removeVisual(franja)
	    menu.iniciar()
    }
  }
}