import franja.*
import raquetas.*
import juego.*

object pelota {
  const numeros = [1, -1]
  var direccionX = -1
  var direccionY = -1
  var property pelotaVelocidad = 110
  const image = "pelota1.png"
  var property position = game.at(10, 12)
  method numeros() = numeros
  
  method image() = image


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
  //REBOTE PAREDES
  method movementY() {
    if ([0, 24].contains(position.y())) {
      direccionY *= -1
    }
  }
  
  method movementX() {
    //REBOTE RAQUETAS
    if ((position.x() == 1) && menu.singlePlayer().jugador1().areaColision().contains(position.y())) {
      direccionX = 1
    }
    if ((position.x() == 23) && menu.singlePlayer().bot().areaColision().contains(position.y())) {
      direccionX = -1
    }
    //REBOTE OBSTACULO
    if (not menu.singlePlayer().obstaculos().isEmpty() and (position.x() == 10) && menu.singlePlayer().obstaculos().first().areaColision().contains(position.y())){
      direccionX = -1
    }
    
    if (not menu.singlePlayer().obstaculos().isEmpty() and (position.x() == 12) && menu.singlePlayer().obstaculos().first().areaColision().contains(position.y())){
      direccionX = 1
    }
    
  }
  method movementXMultiplayer() {
    //REBOTE RAQUETAS
    if ((position.x() == 1) && menu.multiPlayer().jugador1().areaColision().contains(position.y())) {
      direccionX = 1
    }
    if ((position.x() == 23) && menu.multiPlayer().jugador2().areaColision().contains(position.y())) {
      direccionX = -1
    }
    //REBOTE OBSTACULO
    if (not menu.multiPlayer().obstaculos().isEmpty() and (position.x() == 10) && menu.multiPlayer().obstaculos().first().areaColision().contains(position.y())){
      direccionX = -1
    }
    if (not menu.multiPlayer().obstaculos().isEmpty() and (position.x() == 12) && menu.multiPlayer().obstaculos().first().areaColision().contains(position.y())){
      direccionX = 1
    }
  }
}