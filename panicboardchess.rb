require "sinatra/json"

class PanicBoardChess < Sinatra::Base
  get "/" do
    haml :index
  end

  get "/problem.json" do
    json start: "4rk2/ppp2nR1/3p1P1p/2r3p1/6P1/2P3BP/P7/4R1K1 w - - 0 1"
  end
end
