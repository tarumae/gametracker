require 'sidekiq-scheduler';
require 'open-uri'
require 'nokogiri'

class ScrapingJob < ApplicationJob
  self.queue_adapter = :sidekiq

  def perform(*args)
    game = Game.find(3)
    url = game.url
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)
    response = html_doc.search(".view_detail_area").text.gsub(/\r\n\s+/, "\n").gsub("View list", "")
    game.update(content: response)
  end
end