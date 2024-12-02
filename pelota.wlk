
import raquetas.*
import juego.*
import main.hitBall
import gameManager.gameManager
object pelota {
  const numeros = [1, -1]
  var direccionX = -1
  var direccionY = -1
  var property pelotaVelocidad = 150 //eSTABA EN 150
  const image = "pelota1.png"
  var property position = game.at(gameManager.width_game()/2, gameManager.height_game()/2)
  method numeros() = numeros
  
  method image() = image


  method movimientoInicio() {
    position = game.at(22, 10)
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
    if ([0, gameManager.height_game()].contains(position.y())) {
      direccionY *= -1
    }
  }
  
  method movementX() {
    if ((position.x() == 2) && menu.singlePlayer().jugador1().areaColision().contains(position.y())) {
      hitBall.play()
      direccionX = 1
    }
    if ((position.x() == gameManager.width_game() -2) && menu.singlePlayer().bot().areaColision().contains(position.y())) {
      hitBall.play()
      direccionX = -1
      
    }
  }
  method movementXMultiplayer() {
    if ((position.x() == 2) && menu.multiPlayer().jugador1().areaColision().contains(position.y())) {
      direccionX = 1
      hitBall.play()
    }
    if ((position.x() == gameManager.width_game() -2) && menu.multiPlayer().jugador2().areaColision().contains(position.y())) {
      direccionX = -1
      hitBall.play()
    }
  }
}