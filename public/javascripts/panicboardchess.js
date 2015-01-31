(function() {
  $(function() {
    return $.ajax({
      url: "/problem.json",
      success: function(data) {
        var board, game;
        game = new Chess(data.start);
        return board = new ChessBoard("chessboard", {
          position: data.start,
          draggable: true,
          onDragStart: (function(_this) {
            return function(source, piece, position, orientation) {
              return !(game.game_over() || (game.turn() === "w" && piece.search(/^b/) !== -1) || (game.turn() === "b" && piece.search(/^w/) !== -1));
            };
          })(this),
          onDrop: (function(_this) {
            return function(source, target) {
              var move;
              move = game.move({
                from: source,
                to: target,
                promotion: "q"
              });
              if (move === null) {
                return "snapback";
              }
            };
          })(this),
          onSnapEnd: (function(_this) {
            return function() {
              return board.position(game.fen);
            };
          })(this)
        });
      }
    });
  });

}).call(this);
