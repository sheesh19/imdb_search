class MoviesController < ApplicationController

  def index
    # PG_SEARCH EXAMPLE

    @results = PgSearch.multisearch(params[:query])

    # ACTIVERECORD/SQL/POSGRESQL EXAMPLE

    if params[:query].present?
      sql_query = " \
        movies.title @@ :query \
        OR movies.syllabus @@ :query \
        OR directors.first_name @@ :query \
        OR directors.last_name @@ :query \
      "
      @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")
    else
      @movies = Movie.all
    end
  end
end
