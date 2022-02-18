class UserMoviesController < ApplicationController

  def index
    @query = params[:query]
    @user = User.find(session[:user_id])
    @top_movies = MovieFacade.top_movies
  end

  def search
    @user = User.find(session[:user_id])
    @movies = MovieFacade.search_for_movie(params[:search])
    @search = params[:search]

    render :index
  end

  def show
    @user = User.find(session[:user_id])
    @movie = MovieFacade.movie_info(params[:id])
    @reviews = MovieFacade.reviews(params[:id])
    @cast = MovieFacade.cast(params[:id]).first(10)
  end
end
