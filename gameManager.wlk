import juego.*
import mensajes.*
import pelota.*


object gameManager {
   var isPlay = false
  method inicializar() {
    game.cellSize(30)
    game.height(30)
    game.width(25)
    game.boardGround("pasto.png")
    game.title("Tenis")
    const rain = game.sound("assets_menu.wav")
    rain.shouldLoop(true)

    game.schedule(7000, {rain.play()})
    game.start()
    rain.volume(0.2)
    self.playMenu()
   
  }
  method playMenu(){
    game.addVisual(instrucciones)
    keyboard.i().onPressDo( 
      { if(!isPlay){
      game.removeVisual(instrucciones)
      game.addVisual(menu) 
      isPlay=true
      menu.iniciar()
    }
   })
  }
  
  method cleanGame(){
  game.allVisuals().forEach({ c => game.removeVisual(c) })

      menu.clean()
      game.clear()
      puntajeJugador.clean()
      puntajeRival.clean()
      isPlay=false
  }
  method reiniciar(visial) {
    self.cleanGame()

  game.addVisual(visial)
  
    keyboard.enter().onPressDo({  game.removeVisual(visial)
    self.playMenu()
    })
 
  }
}