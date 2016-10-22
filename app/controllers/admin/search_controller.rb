class Admin::SearchController < Admin::BaseController

  def show
    #@people = Person.order(id: :desc).where(id: (PgSearch.multisearch(params[:search]).where(searchable_type: "Person").pluck(:searchable_id))).page(params[:assets_page]).per(10)
    @search_query = params[:search]
  end
end

