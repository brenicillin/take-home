# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Customer.destroy_all
Tea.destroy_all
Subscription.destroy_all

Customer.create!(first_name: "John", last_name: "Doe", email: "john@doe.com", address: "123 Main St")
Customer.create!(first_name: "Jane", last_name: "Doe", email: "jane@doe.com", address: "123 Main St")
Customer.create!(first_name: "Gimli", last_name: "Son of Gloin", email: "dwarf@lotr.com", address: "Some Mountain")
Customer.create!(first_name: "Legolas", last_name: "Greenleaf", email: "elf@trees.com", address: "Some Forest")
Customer.create!(first_name: "Aragorn", last_name: "Son of Arathorn", email: "man@rings.com", address: "Some Castle")

Tea.create!(title: "Earl Grey", description: "Aromatic black tea with bergamot", temperature: 212, brew_time: 5)
Tea.create!(title: "English Breakfast", description: "Classic black tea", temperature: 212, brew_time: 5)
Tea.create!(title: "Chai", description: "Black tea with cardamom, cinnamon, black pepper, and more", temperature: 212, brew_time: 5)
Tea.create!(title: "Peppermint", description: "Herbal tea with a cooling, minty flavor", temperature: 208, brew_time: 3)
Tea.create!(title: "Chamomile", description: "Herbal tea with a subtle, floral flavor", temperature: 208, brew_time: 3)
