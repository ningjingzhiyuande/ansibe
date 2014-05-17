# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'ROLES'
#YAML.load(ENV['ROLES']).each do |role|
#  Role.find_or_create_by_name(role)
#  puts 'role: ' << role
#end
#puts 'DEFAULT USERS'
#user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
#puts 'user: ' << user.name
#user.confirm!
#user.add_role :admin
mails = ["oreatial@163.com","uushuba@gmail.com",'oreatial@gmail.com','shiguodong@tianji.com','281471014@qq.com']
roles = [100,200]
(0..100).each do |i|
  mail  = i< 5 ? mails[i] : "nihao#{rand(10000)}@qq.#{rand(100)}.cn"
  role = rand > 0.6 ? roles[rand(2)] : 0
  u = User.create({email: mail,role: role,name: "test_#{rand(100)}",department: rand(10),password: "12345678"})
  #u.save(validate: false)
end