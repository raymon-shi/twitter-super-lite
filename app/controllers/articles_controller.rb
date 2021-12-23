class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  require 'news-api'

  


  # GET /articles or /articles.json
  def index
    news_api_client = News.new("c343000fe54d4e7187370a0bb15e5a70")
    @articles = news_api_client.get_top_headlines(sources: "bbc-news", from: '2021-12-01', to: '2021-12-07', language: 'en')
    return nil
  end

end
