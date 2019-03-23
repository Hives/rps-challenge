require 'sinatra/base'
require './lib/game'

class RockPaperScissors < Sinatra::Base
  enable :sessions

  before do
    @game = Game.instance
  end

  get '/' do
    erb :register
  end

  post '/enter-name' do
    Game.create(params['player1_name'])
    redirect '/play'
  end

  get '/play' do
    erb :play
  end

  post '/choose' do
    session[:choice] = params['choice'].to_i
    redirect '/result'
  end

  get '/result' do
    @player1_choice = session[:choice]
    @player2_choice = Kernel.rand(0..2)
    @result_index = (@player1_choice - @player2_choice) % 3
    @result = ["It's a draw", "You win", "You lose"][@result_index]
    erb :result
  end

end
