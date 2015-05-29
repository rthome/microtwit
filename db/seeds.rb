User.create!(name: 'Example User',
             email: 'example@rmt.name',
             password: 'password',
             password_confirmation: 'password',
             admin: true)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@rmt.name"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

users = User.order(:created_at).take(10)
users.each do |user|
  100.times do
    content = Faker::Lorem.sentence(5)
    user.chirps.create!(content: content)
  end
end

users = User.all
first_user = User.first
follows = users[2..5]
followers = users[6..10]
follows.each { |f| first_user.follow(f) }
followers.each { |f| f.follow(first_user) }
