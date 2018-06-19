require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'
require './model'

enable :sessions

get '/' do
    @tweet=Tweet.all
    if session[:email] # 로그인이 되어있을 경우에만
        erb :index
    else
        redirect '/login'
    end
    
    # @users=User.all
end

get '/create' do
    @name = session[:email]
    @content = params[:content]
    
    Tweet.create(
        name: @name,
        content: @content
        )
    
    redirect '/'
end

get '/sign_up' do
    erb :sign_up
end

get '/register' do

    User.create(
        email: params[:email],
        password: params[:password]
        )
    
    erb :register
end

get '/admin' do
    @users = []
    @users=User.all
    erb :admin
end

get '/login' do
    @users = []
    @users=User.all
    erb :login
end

get '/login_session' do
    # 사용자를 로그인 시킨다
    # 만약에 사용자가 유효하다면 (email, password == DB에 저장된 email, password와 같아야 한다.)
    # session에 사용자를 저장한다.
    
    # @users=User.all(email: params[:email]) # 배열 안에서 검색 가능 (email: "dnjsdl91@gmail.com") all은 여러가지 값일 수 있으니까 배열로 출력 [유저1]
    # @users=User.first(email: params[:email]) # 유저1로 바로 출력가능 -> 조건문에서 else 사용가능
    
    # 만약에 @user에 어떤 값이 들어가 있으면 == 유저가 입력한 이메일의 데이터가 DB에 있다.
    # == params[] DB에 있으면
    
    @msg = "로그인 실패"
    @users = User.all
    
    @users.each do |u|
        if u.email == params[:email] && u.password == params[:password]
                @msg = "로그인 성공"
                session[:email] = u.email
        end
    end
    erb :login_session
end

get '/logout' do
   # 로그아웃 시킨다.
   session.clear
   redirect '/'
end