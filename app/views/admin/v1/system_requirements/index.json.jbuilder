# frozen_string_literal: true

json.system_requirements do
  json.array!(@system_requirements,
              :id, :name, :operational_system, :storage, :processor, :memory, :video_board)
end

json.meta do
  json.partial! "shared/pagination", pagination: @loading_service.pagination
end
