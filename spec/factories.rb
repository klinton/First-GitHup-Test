# Symbols utlization (:user), allows Factory Girl to simulate the (user) model.
Factory.define :user do |user|
  user.name         "Yogi Bear"
  user.email        "theavgbear@jellystonepark.gov"
  user.password     "picnic basket"
  user.password_confirmation "picnic basket"
end

