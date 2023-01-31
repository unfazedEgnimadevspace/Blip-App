User.create!(name: "Example user", email: "example@railstutorial.org", password: "foobar", password_confirmation: "foobar", admin: true, activated: true, activated_at: Time.zone.now)

60.times do |n|
    name = Faker::Name.name 
    email = "example-#{n + 1}@railstutorial.org"
    password = "password"
    User.create(name: name, email: email, password: password, password_confirmation: password, activated: true, activated_at: Time.zone.now)
end

users = User.order(:created_at).take(15)
30.times do 
    content = Faker::Lorem.sentence(word_count: 12)
    users.each { |user| user.microposts.create!(content: content)}
end

