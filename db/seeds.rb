10.times do
	u = User.create!(
		username: Faker::Internet.user_name,
		email: Faker::Internet.email,
		password: Faker::Internet.password
	)

	Wiki.create(
		title: Faker::Lorem.word,
		body: Faker::Lorem.paragraph(2, false, 4),
		user: u
	)
end
users = User.all

30.times do
	Wiki.create(
		title: Faker::Lorem.word,
		body: Faker::Lorem.paragraph(2, false, 4),
		user: users.sample
	)
end