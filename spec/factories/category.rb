FactoryBot.define do
  factory :category, class: Category do
    sequence :name do |n|
      "#{Faker::Lorem.word} #{n}"
    end
    description { Faker::Lorem.sentence }
  end
end
