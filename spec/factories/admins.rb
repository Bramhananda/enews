# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin, class: User do
    name 'Test admin'
    email 'example4@example.com'
    password 'changeme2'
    password_confirmation 'changeme2'
   
    after(:create) {|user| user.add_role(:admin)}
   
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end
