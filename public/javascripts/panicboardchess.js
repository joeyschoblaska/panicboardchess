(function() {
  window.currentPosition = "";

  window.setProblem = function(data) {
    var board, game;
    window.currentPosition = data.start;
    game = new Chess(data.start);
    return board = new ChessBoard("chessboard", {
      position: data.start,
      draggable: true,
      orientation: game.turn() === "w" ? "white" : "black",
      onDragStart: (function(_this) {
        return function(source, piece, position, orientation) {
          return !(game.game_over() || (game.turn() === "w" && piece.search(/^b/) !== -1) || (game.turn() === "b" && piece.search(/^w/) !== -1));
        };
      })(this),
      onDrop: (function(_this) {
        return function(source, target) {
          var move, oldPosition, response;
          oldPosition = game.fen();
          move = game.move({
            from: source,
            to: target,
            promotion: "q"
          });
          if (move !== null && move.san === data.moves[0]) {
            data.moves.shift();
            if (data.moves.length === 0) {
              return setTimeout((function() {
                return board.clear();
              }), 500);
            } else {
              response = data.moves.shift();
              return setTimeout((function() {
                game.move(response);
                return board.position(game.fen());
              }), 250);
            }
          } else if (move === null) {
            game.load(oldPosition);
            return "snapback";
          } else {
            return setTimeout((function() {
              game.load(oldPosition);
              return board.position(oldPosition);
            }), 250);
          }
        };
      })(this)
    });
  };

  window.requestPosition = function() {
    return $.ajax({
      url: "/problem.json",
      success: function(data) {
        if (data.start !== window.currentPosition) {
          return setProblem(data);
        }
      }
    });
  };

  $(function() {
    var timeout;
    timeout = function() {
      requestPosition();
      return setTimeout((function() {
        return timeout();
      }), 3600000);
    };
    return timeout();
  });

}).call(this);
