# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title "News"
    content "#{"a"*10}"
    publish_date "2013-07-10 05:35:46"
    category
    tag_list "test, test2"
    user
    active true
  end
end
