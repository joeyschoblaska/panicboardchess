require "sinatra/json"
require "open-uri"


class PanicBoardChess < Sinatra::Base
  set :cache, Dalli::Client.new

  get "/" do
    haml :index
  end

  get "/problem.json" do
    response_hash = settings.cache.fetch("response-hash", (60*60)) do
      homepage = Nokogiri::HTML(open("http://chess.com"))
      puzzle_url = homepage.css("a").find{ |a| a.text =~ /Click to Solve/ }.attributes["href"].value
      puzzle_page = Nokogiri::HTML(open(puzzle_url))
      puzzle = puzzle_page.at_css(".dailyPuzzleDiv").children.first.content

      start = puzzle.match(/\[FEN \"([^\"]+)/)[1]
      moves_string = puzzle.match(/\r\n\r\n([^\*]+)/)[1]
      moves = moves_string.split(/(\s|\d{1,2}\.{1,3})/).select{ |m| m =~ /^\D/ && m =~ /^\S/ }

      {start: start, moves: moves}
    end

    json response_hash
  end
end
