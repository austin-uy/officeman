FactoryBot.define do
  factory :user, class: User do
    name { 'User' }
    email { 'user@localhost' }
    role { 'user' }
    password { 'password' }
  end

  factory :admin, class: User do
    name { 'Administrator' }
    email { 'admin@localhost' }
    role { 'admin' }
    password { 'password' }
  end
end
