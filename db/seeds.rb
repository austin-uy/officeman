# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#User role: [ 0:user, 1:admin] 
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#User role: [ 0:user, 1:admin]
User.delete_all
User.create([
  {
    name: "Administrator",
    email: "admin@localhost",
    password: 'password',
    password_confirmation: 'password',
    role: 1
  },
  {
    name: "Adam",
    email: "adam@localhost",
    password: 'password',
    password_confirmation: 'password',
    role: 0
  },
  {
    name: "User",
    email: "user@localhost",
    password: 'useruser',
    password_confirmation: 'useruser',
    role: 0
  }
])
#Question answer_type: [:text, :numerical, :choice]
Question.delete_all
Question.create([
  {
    question: "What is your name?",
    answer_type: 0,
    show_in_list: false
  },
  {
    question: "How old are you?",
    answer_type: 1,
    show_in_list: false
  },
  {
    question: "Where do you live?",
    answer_type: 0,
    show_in_list: true}
  # },
  # {
  #   question: "Sex?",
  #   answer_type: 2,
  #   show_in_list: true,
  #   choices: ["Male", "Female"]
  # },
  # {
  #   question: "Civil Status?",
  #   answer_type: 2,
  #   show_in_list: true,
  #   choices: ["Single", "Married", "Divorced", "Widowed"]
  # }
])

Answer.delete_all
Answer.create([
  {
    answer: "User",
    question_id: 1,
    user_id: 3,
  },
  {
    answer: 20,
    question_id: 2,
    user_id: 3,
  },
])

#Equipment type: [:hardware, :software, :peripheral]
#Equipment status: [:deployed, :stored, :defective]
Equipment.delete_all
Equipment.create([
  {
    name: "Chair",
    equipment_type: 2,
    status: 1,
    user_id: 2
  },
  {
    name: "Chair",
    equipment_type: 2,
    status: 1,
    user_id: 3
  },
  {
    name: "Desk",
    equipment_type: 2,
    status: 1,
    user_id: 2
  },
  {
    name: "Notepad",
    equipment_type: 1,
    status: 1,
    user_id: 2
  },
  {
    name: "Mouse",
    equipment_type: 0,
    status: 2,
    user_id: 2
  },
])

7.times do 
  User.create(
    name: Faker::FunnyName.name,
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    role: 0
  )
  Question.create(
    question: Faker::Lorem.question(word_count: 3),
    answer_type: rand(0..1),
    show_in_list: Faker::Boolean.boolean(true_ratio: 0.7)
  )
end

100.times do 
  Equipment.create(
    name: Faker::Appliance.equipment,
    equipment_type: rand(0..2),
    status: rand(0..2),
    user_id: rand(2..10)
  )
end

(2..10).each do |user|
  (1..10).each do |question|
    Answer.create(
      answer: Faker::Lorem.word,
      question_id: question,
      user_id: user,
    )
  end
end