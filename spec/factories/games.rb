FactoryBot.define do
  factory :game do
    mode { %i(pvp pve both).sample }
    release_date { "2023-06-21 01:24:25" }
    developer { Faker::Company.name }
    system_requirement
  end
end
