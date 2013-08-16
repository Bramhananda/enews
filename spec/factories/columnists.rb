# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :columnist do
    name 'Test coumnist'
    email 'example2@example.com'
    password 'changeme2'
    password_confirmation 'changeme2'
    add_role(:columnist)
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end
