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
#Question answer_type: [:text, :numerical, :choice]

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
    question: "Coke or Pepsi",
    answer_type: 2,
    show_in_list: true
  }
])

# User.create([
  
# ])