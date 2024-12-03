import juego.*
//MENSAJE "PERDISTE"
object perdiste {
  method image() = "perder.jpg"
  method position() = game.at(0,0)
}
//MENSAJE "GANASTE"
object ganar {
  method image() = "ganar.jpg"
  method position() = game.at(0,0)
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
    method puntos(punto) {

    puntos = punto}

  method sumarPunto() {
    puntos = puntos + 1
  }
  method clean() {
    puntos = 0
  }
  method image() = puntos.toString()+".png"
  method position() = game.at(2,26)
}
//PUNTAJE DERECHO
object puntajeRival {
  var puntos = 0
  method puntos() = puntos
  method sumarPunto() {
    puntos = puntos + 1
  }
  method clean() {
    puntos = 0
  }
  method image() = puntos.toString()+".png"
  method position() = game.at(19,26)
}
//IMAGEN DE INSTRUCCIONES
object instrucciones {
  method image() = "INTRUCCIONES.png"
    method position() = game.at(0, 0)
}