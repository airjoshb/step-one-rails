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
  {name: "Creating"},
  {name: "Crohn's"},
  {name: "Cycling"},
  {name: "Entrepreneurship"},
  {name: "Farrago"},
  {name: "Health"},
  {name: "Keto"},
  {name: "Listening"},
  {name: "Mindfulness"},
  {name: "Reading"},
  {name: "Recipes"},
  {name: "Running"},
  {name: "Strength"},
  {name: "Training"},
  {name: "Updates"},
  {name: "Watching"},
])
Page.create([
  {title: "about joshua", slug: "joshua"},
  {title: "home", description: "Start where you are and begin again."},

])
User.create(email: ENV.fetch('ADMIN_EMAIL'), password: ENV.fetch('ADMIN_PASSWORD'), password_confirmation: ENV.fetch('ADMIN_PASSWORD'))