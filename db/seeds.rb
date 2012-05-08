# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

#User.create(
#  :username => 'sysadmin',
#  :password_hash => "$2a$10$HGunSYtitJWEOe1Qdav...B7X2rMlRc8vHsiLZmp5vhm...",
#  :password_salt => "$2a$10$HGunSYtitJWEOe1Qdav..."
#)

user1 = User.new
user1.username = "sysadmin"
user1.password = "welcome"
user1.admin = true
user1.save!
