$ ->
  $.ajax
    url: "/problem.json"
    success: (data) ->
      game = new Chess(data.start)
      board = new ChessBoard "chessboard",
        position: data.start
        draggable: true
        orientation: if game.turn() == "w" then "white" else "black"
        onDragStart: (source, piece, position, orientation) =>
          return !(game.game_over() ||
                   (game.turn() == "w" && piece.search(/^b/) != -1) ||
                   (game.turn() == "b" && piece.search(/^w/) != -1))

        onDrop: (source, target) =>
          oldPosition = game.fen()
          move = game.move
            from: source
            to: target
            promotion: "q"

          if move != null && move.san == data.moves[0]
            # legal and correct move
            data.moves.shift()

            if data.moves.length == 0
              # puzzle is over
              setTimeout (->
                board.clear()
              ), 500
            else
              # make next move for opponent
              response = data.moves.shift()

              setTimeout (->
                game.move(response)
                board.position(game.fen())
              ), 250

          else
            # illegal or incorrect move
            game.load(oldPosition)
            return "snapback"
