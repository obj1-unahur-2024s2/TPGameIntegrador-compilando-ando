import juego.*
//MENSAJE "PERDISTE"
object perdiste {
  method image() = "perder.png"
  method position() = game.at(6, 13)
}
//MENSAJE "GANASTE"
object ganar {
  method image() = "ganaste1.png"
  method position() = game.at(6, 13)
}

object puntajeJugador {
  var puntos = 0
  method puntos() = puntos
  method sumarPunto() {
    puntos = puntos + 1
  }
  method image() = puntos.toString()+".png"
  method position() = game.at(2,26)
}
object puntajeRival {
  var puntos = 0
  method puntos() = puntos
  method sumarPunto() {
    puntos = puntos + 1
  }
  method image() = puntos.toString()+".png"
  method position() = game.at(19,26)
}
