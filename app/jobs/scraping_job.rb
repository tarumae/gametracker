require 'sidekiq-scheduler'
require 'open-uri'
require 'nokogiri'

class ScrapingJob < ApplicationJob
  self.queue_adapter = :sidekiq

  def perform
    bdo
    gw2
  end

  def bdo
    game = Game.find(3)
    url = game.url
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)
    response = html_doc.search(".view_detail_area")
    response.search(".custom_sns_list").remove
    response.search(".inner").remove
    game.update(content: response)
  end

  def gw2
    game = Game.find(6)
    url = game.url
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)
    response = html_doc.search(".bd.post-scl")
    game.update(content: response)
  end
end
