(function() {
  $(function() {
    return $.ajax({
      url: "/problem.json",
      success: function(data) {
        return new ChessBoard("chessboard", {
          position: data.start,
          draggable: true
        });
      }
    });
  });

}).call(this);
