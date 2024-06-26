# frozen_string_literal: true

json.games do
  json.array! @games do |game|
    json.call(game.product, :id, :name, :description)
    json.image_url rails_blob_url(game.product.image)
    json.partial! game
    json.licenses game.product.line_items.map(&:licenses).flatten.map(&:key)
  end
end
