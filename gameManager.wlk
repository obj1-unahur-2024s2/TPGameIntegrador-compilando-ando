import mensajes.*
import juego.*
object gameManager {
  const property width_game= 45
const property  height_game = 20
  method inicializar() {
    game.cellSize(30)
    game.height(height_game)
    game.width(width_game)
    game.boardGround("cancha.jpg")
    game.title("Tenis")
    game.addVisual(menu)
    menu.iniciar()
    //menu.iniciar()
  	const musicBackgound = game.sound("menu.wav")
  	musicBackgound.shouldLoop(true)
  	game.schedule(100, { musicBackgound.play()} )
  	keyboard.space().onPressDo({ game.stop() })
	  game.start()
  }

  method reiniciar(){
    game.allVisuals().forEach({ c => game.removeVisual(c) })
    menu.clean()
    puntajeJugador.clean()
    puntajeRival.clean()
    game.addVisual(menu)

  }
}