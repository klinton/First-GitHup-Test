# Symbols utlization (:user), allows Factory Girl to simulate the (user) model.
Factory.define :user do |user|
  user.name         "Yogi Bear"
  user.email        "theavgbear@jellystonepark.gov"
  user.password     "Picnic Basket"
  user.password_confirmation "Picnic Basket"
end


Factory.sequence :email do |n|
  "person#{n}@example.com"
end
