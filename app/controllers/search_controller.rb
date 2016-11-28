class SearchController < ApplicationController
  def index
    Item.reindex
    @query = query;
    @items = Item.search @query, page: params[:page], per_page: 8, order: [title: :asc]
  end

  private

  def query
    params[:search][:keyword]
  end
end
