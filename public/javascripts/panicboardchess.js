(function() {
  $(function() {
    return $.ajax({
      url: "/problem.json",
      success: function(data) {
        return new ChessBoard("chessboard", data.start);
      }
    });
  });

}).call(this);
