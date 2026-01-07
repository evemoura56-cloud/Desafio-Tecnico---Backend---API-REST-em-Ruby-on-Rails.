FactoryBot.define do
  factory :cart do
    session_id { SecureRandom.uuid }
    abandoned { false }
    last_interaction_at { Time.current }
  end
end
