class MoviesController < ApplicationController
  helper_method :sort_column
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def movie
    @all_ratings = ['G','PG','PG-13','R']
  end
  def index
    @movies = Movie.order(params[:sort_by]).find(:all, :conditions => {:rating => filter_rating})
    movie
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private

  def sort_column
    Movie.column_names.include?(params[:sort_by]) ? params[:sort_by] : "title"
  end
  def filter_rating
    if params[:ratings] == nil
      keys = movie
    else
      ratings = params[:ratings]
      keys = ratings.keys
    end
  end
end
