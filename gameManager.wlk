import juego.*
object gameManager {
  method inicializar() {
    game.cellSize(30)
    game.height(30)
    game.width(25)
    game.boardGround("pasto.png")
    game.title("Tenis")
    game.addVisual(menu)
  }
  method playGame(){
       game.clear()
    self.inicializar()
  
 
    menu.iniciar()
	  keyboard.space().onPressDo({game.stop()})
		game.start()
    
  }
}