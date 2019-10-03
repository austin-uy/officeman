FactoryBot.define do
  equipment_types = Equipment.equipment_types.keys
  statuses = Equipment.statuses.keys

  factory :equipment do
    name { "Thing" }
    equipment_type { equipment_types.sample }
    status { statuses.sample }
    user_id { nil }
  end
end