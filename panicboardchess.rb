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

    json start: start
  end
end
