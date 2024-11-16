import franja.*
import raquetas.*
import juego.*

object pelota {
  const numeros = [1, -1]
  var direccionX = -1
  var direccionY = -1
  var pelotaVelocidad = 105
  const image = "pelota1.png"
  var property position = game.at(10, 12)
  method numeros() = numeros
  
  method image() = image
  
  method pelotaVelocidad() = pelotaVelocidad
  method aumentarVelocidad() {
    pelotaVelocidad = pelotaVelocidad - 10
  }
  method movimientoInicio() {
    position = game.at(10, 12)
    direccionX = numeros.anyOne()
    direccionY = numeros.anyOne()
  }
  
  method movement() {
    self.position(position.up(direccionY).right(direccionX))
    self.movementY()
    if(menu.singlePlayer().estaActivo()){
      self.movementX()
    }
    else self.movementXMultiplayer()
    
  }
  
  method movementY() {
    if ([0, 24].contains(position.y())) {
      direccionY *= -1
    }
  }
  
  method movementX() {
    if ((position.x() == 1) && menu.singlePlayer().jugador1().areaColision().contains(position.y())) {
      direccionX = 1
    }
    if ((position.x() == 23) && menu.singlePlayer().bot().areaColision().contains(position.y())) {
      direccionX = -1
    }
  }
  method movementXMultiplayer() {
    if ((position.x() == 1) && menu.multiPlayer().jugador1().areaColision().contains(position.y())) {
      direccionX = 1
    }
    if ((position.x() == 23) && menu.multiPlayer().jugador2().areaColision().contains(position.y())) {
      direccionX = -1
    }
  }
}