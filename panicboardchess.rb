class PanicBoardChess < Sinatra::Base
  get "/" do
    haml :index
  end
end
