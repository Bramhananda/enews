json.array!(@articles) do |article|
  json.extract! article, :title, :content, :publish_date
  json.url article_url(article, format: :json)
end
