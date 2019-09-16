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
    answer_type: 0
  },
  {
    question: "How old are you?",
    answer_type: 1
  },
  {
    question: "Where do you live?",
    answer_type: 0
  },
  {
    question: "Sex?",
    answer_type: 2,
    show_in_list: true,
    choices: ["Male", "Female"]
  },
  {
    question: "Civil Status?",
    answer_type: 2,
    show_in_list: true,
    choices: ["Single", "Married", "Divorced", "Widowed"]
  }
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