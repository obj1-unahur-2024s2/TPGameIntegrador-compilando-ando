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
//msj GANADOR J1
object ganarJugador1 {
  method image() = "ganaste3.png"
  method position() = game.at(0, 13)  
}
//msj GANADOR J2
object ganarJugador2 {
  method image() = "ganaste2.png"
  method position() = game.at(5, 13) 
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
  method image() = puntos.toString()+".png"
  method position() = game.at(19,26)
}