$ ->
  $.ajax
    url: "/problem.json"
    success: (data) ->
      new ChessBoard "chessboard",
        position: data.start
        draggable: true
