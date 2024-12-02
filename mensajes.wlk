import wollok.game.*
import gameManager.*
import juego.*
//MENSAJE "PERDISTE"
object perdiste {
  method image() = "nadal-loose.jpg"
	method position() = game.at(0, 0)
}

object instrucciones {
  method image() = "instrucciones.jpg"
	method position() = game.at(0, 0)
}
//MENSAJE "GANASTE"
object ganar {
  method image() = "nadal-win.jpg"
	method position() = game.at(0, 0)
  
}
//msj GANADOR J1
object ganarJugador1 {
  method image() = "jugador-1-win.jpg"
method position() = game.at(0, 0)

}
//msj GANADOR J2
object ganarJugador2 {
  method image() = "jugador-2-win.jpg"
  
	method position() = game.at(0, 0)
}
//PUNTAJE IZQUIERDO
object puntajeJugador {
  var puntos = 0
  method puntos() = puntos
  method sumarPunto() {
    puntos = puntos + 1
  }
  method image() = puntos.toString()+".png"
  method position() = game.at(2,gameManager.height_game()-10)
  method clean() {
    puntos = 0
  }
}
//PUNTAJE DERECHO
object puntajeRival {
  var puntos = 0
  method puntos() = puntos
  method sumarPunto() {
    puntos = puntos + 1
  }
  method image() = puntos.toString()+".png"
  method position() = game.at(gameManager.width_game() -10,gameManager.height_game()-10)
    method clean() {
    puntos = 0
  }
}
