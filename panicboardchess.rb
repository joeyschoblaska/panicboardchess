require "sinatra/json"
require "open-uri"

class PanicBoardChess < Sinatra::Base
  get "/" do
    haml :index
  end

  get "/problem.json" do
    homepage = Nokogiri::HTML(open("http://chess.com"))
    puzzle_url = homepage.css("a").find{ |a| a.text =~ /Click to Solve/ }.attributes["href"].value
    puzzle_page = Nokogiri::HTML(open(puzzle_url))
    puzzle = puzzle_page.at_css(".dailyPuzzleDiv").children.first.content

    start = puzzle.match(/\[FEN \"([^\"]+)/)[1]
    moves_string = puzzle.match(/\r\n\r\n([^\r]+)/)[1]
    moves = moves_string.split(/(\s|\d{1,2}\.{1,3})/).select{ |m| m =~ /^\D/ && m =~ /^\S/ }
    to_move = moves_string =~ /\d\.{3}/ ? :black : :white

    json start: start, moves: moves, to_move: to_move
  end
end
