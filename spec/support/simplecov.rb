# frozen_string_literal: true

require "simplecov"
require "simplecov_json_formatter"

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::JSONFormatter,
  SimpleCov::Formatter::HTMLFormatter,
])

SimpleCov.start do
  add_group "Controllers", "app/controllers"
  add_group "Models", "app/models"
end
