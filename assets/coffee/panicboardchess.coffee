$ ->
  $.ajax
    url: "/problem.json"
    success: (data) ->
      game = new Chess(data.start)
      board = new ChessBoard "chessboard",
        position: data.start
        draggable: true
        onDragStart: (source, piece, position, orientation) =>
          return !(game.game_over() ||
                   (game.turn() == "w" && piece.search(/^b/) != -1) ||
                   (game.turn() == "b" && piece.search(/^w/) != -1))

        onDrop: (source, target) =>
          move = game.move
            from: source
            to: target
            promotion: "q"

          # illegal move
          return "snapback" if (move == null)

        onSnapEnd: =>
          board.position(game.fen)
