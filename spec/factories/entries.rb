# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :entry do
    name "jean-louis-qui-test"
    price 106
    flag true
  end
  factory :entry_b, class: Entry do
    name "jean-paul-qui-dort"
    price 76
    flag false
  end
end
