# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :picture do
    title "My picture"
    image File.new(Rails.root + 'spec/factories/images/rails.png')
  end
end
