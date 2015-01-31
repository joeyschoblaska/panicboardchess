$ ->
  $.ajax
    url: "/problem.json"
    success: (data) ->
      new ChessBoard("chessboard", data.start)
