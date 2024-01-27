# frozen_string_literal: true

json.licenses do
  json.array!(@licenses, :id, :key, :platform, :status, :game_id)
end

json.meta do
  json.partial! "shared/pagination", pagination: @loading_service.pagination
end
