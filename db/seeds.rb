User.create!(name: 'Example User',
             email: 'example@rmt.name',
             password: 'password',
             password_confirmation: 'password')

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@rmt.name"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end