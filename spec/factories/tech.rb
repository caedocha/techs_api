FactoryBot.define do
  factory :tech, class: Tech do
    sequence :name do |n|
      "#{Faker::ProgrammingLanguage.name} #{n}"
    end
    description { Faker::Lorem.sentence }
  end
end
