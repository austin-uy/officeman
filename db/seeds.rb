# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# Examples:
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User role: [ 0:user, 1:admin]
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# Examples:
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User role: [ 0:user, 1:admin]
User.delete_all
User.create([
  {
    name: 'Administrator',
    email: 'admin@localhost',
    password: 'password',
    password_confirmation: 'password',
    role: :admin
  },
  {
    name: 'Adam',
    email: 'adam@localhost',
    password: 'password',
    password_confirmation: 'password',
    role: :user
  },
  {
    name: 'User',
    email: 'user@localhost',
    password: 'useruser',
    password_confirmation: 'useruser',
    role: :user
  }
])
# Question answer_type: [:text, :numerical, :choice]
Question.delete_all
Question.create([
  {
    question: 'What is your name?',
    answer_type: :text,
    show_in_list: false
  },
  {
    question: 'How old are you?',
    answer_type: :numerical,
    show_in_list: false
  },
  {
    question: 'Where do you live?',
    answer_type: :text,
    show_in_list: true }
])

Answer.delete_all

@adam = User.find_by(email: 'adam@localhost')
@user = User.find_by(email: 'user@localhost')

# Equipment type: [:hardware :license :'online account' :peripheral]
# Equipment status: [:deployed, :stored, :defective]
Equipment.delete_all
Equipment.create([
  {
    name: 'Chair',
    equipment_type: :hardware,
    status: :stored,
    user_id: @user.id
  },
  {
    name: 'Chair',
    equipment_type: :hardware,
    status: :stored,
    user_id: @adam.id
  },
  {
    name: 'Desk',
    equipment_type: :hardware,
    status: :stored,
    user_id: @user.id
  },
  {
    name: 'Notepad',
    equipment_type: :license,
    status: :deployed,
    user_id: @user.id,
    serial_number: Faker::Number.number(digits: 3).to_s + '-' +
      Faker::Number.number(digits: 3).to_s + '-' +
      Faker::Number.number(digits: 3).to_s
  },
  {
    name: 'Mouse',
    equipment_type: :peripheral,
    status: :defective,
    user_id: @adam.id
  }
])

7.times do
  User.create(
    name: Faker::FunnyName.name,
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    role: :user
  )

  answer_type = Question.answer_types.entries.sample
  if answer_type[0].eql?('choice')
    Question.create(
      question: Faker::Lorem.question(word_count: 3),
      answer_type: answer_type[1],
      show_in_list: Faker::Boolean.boolean(true_ratio: 0.7),
      choices: Faker::Lorem.words(number: 3)
    )
  else
    Question.create(
      question: Faker::Lorem.question(word_count: 3),
      answer_type: answer_type[1],
      show_in_list: Faker::Boolean.boolean(true_ratio: 0.7)
    )
  end
end

150.times do
  eq_type = Equipment.equipment_types.entries.sample
  if eq_type[0].eql?('license')
    Equipment.create(
      name: Faker::Appliance.equipment,
      equipment_type: :license,
      status: Equipment.statuses.values.sample,
      user_id: User.where.not(role: :admin).sample.id,
      serial_number: Faker::Number.number(digits: 3).to_s + '-' +
        Faker::Number.number(digits: 3).to_s + '-' +
        Faker::Number.number(digits: 3).to_s
    )
  else
    Equipment.create(
      name: Faker::Appliance.equipment,
      equipment_type: eq_type[1],
      status: Equipment.statuses.values.sample,
      user_id: User.where.not(role: :admin).sample.id
    )
  end
end

User.where.not(role: :admin).each do |user|
  Question.all.each do |question|
    case question.answer_type
    when 'text'
      Answer.create(
        answer: Faker::Lorem.word,
        question_id: question.id,
        user_id: user.id
      )
    when 'numerical'
      Answer.create(
        answer: Faker::Number.within(range: 1..50),
        question_id: question.id,
        user_id: user.id
      )
    when 'choice'
      Answer.create(
        answer: question.choices.sample,
        question_id: question.id,
        user_id: user.id
      )
    end
  end
end
