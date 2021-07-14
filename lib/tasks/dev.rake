namespace :dev do
  desc 'Configures dev environment'
  task setup: :environment do
    puts 'Reseting db'
    %x(rails db:drop db:create db:migrate)

    puts 'Generating kinds of contact'
    kinds = %w(Amigo Comercial Conhecido)
    kinds.each do |k|
      Kind.create!(
        description: k
      )
    end
    puts 'Kinds created successfully!'
    ###################################
    puts 'Seeding contacts...'
    100.times do
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 65.years.ago, to: 18.years.ago),
        kind: Kind.all.sample
      )
    end
    puts 'Contacts created successfully!'

    ##################################
    puts 'Generating phones...'
    Contact.all.each do |c|
      Random.rand(5).times do
        phone = Phone.create!(number: Faker::PhoneNumber.cell_phone)
        c.phones << phone
        c.save!
      end
    end
    puts 'Phones created!'

    puts 'Generating addresses...'
      Contact.all.each do |c|
        Address.create(
          street: Faker::Address.street_address,
          city: Faker::Address.city,
          contact: c
        )
      end
    puts 'Phones created!'
  end
end
