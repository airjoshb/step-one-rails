# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Product.create([
  {name: "The Crohn's Disease AIP Cookbook", description: "Recipes to Reduce Inflammation and Eliminate Food Triggers on the Autoimmune Protocol"},

])
Category.create([
  {name: "Crohn's"},
  {name: "Training"},
  {name: "Mindfulness"},
  {name: "Keto"},
  {name: "Recipes"},
  {name: "Reading"},
  {name: "Watching"},
  {name: "Listening"},
  {name: "Entrepreneurship"},
  {title: "All"},
])
Page.create([
  {title: "about joshua", slug: "joshua"},
  {title: "now"},
  {title: "home", description: "Start where you are and begin again."},

])
User.create(email: ENV.fetch('ADMIN_EMAIL'), password: ENV.fetch('ADMIN_PASSWORD'), password_confirmation: ENV.fetch('ADMIN_PASSWORD'))