namespace :dev do
  desc 'Configures dev environment'
  task setup: :environment do
    puts 'Seeding contacts...'
    100.times do
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 65.years.ago, to: 18.years.ago)
      )
    end
    puts 'Contacts created successfully!'
  end

end
