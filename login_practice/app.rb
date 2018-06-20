require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'
require './model'

enable :sessions

get '/' do
    erb :index
end

get '/signup' do
    erb :signup
end

get '/register' do
    User.create(
        email: params[:email],
        password: params[:password]
        )
    redirect '/'
end

get '/admin' do
    @users = User.all
    erb :admin
end

get '/login' do
    erb :login
end

get '/session_new' do
    
    @users = User.all
    @users.each do |u|
        if u.email == params[:email] && u.password == params[:password]
                session[:email] = u.email
                redirect '/'
        else
            redirect '/login'
        end
    end
end

#  1. 로그인 로직 구현(유저 검증 == DB에 저장된 유저인지 확인)
#  2. 만약 유효한 유저라면
# 	session[:email]에 유저 저장
# 	redirect '/'
#     아니면
# 	redirect '/login'