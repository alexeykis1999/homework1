require 'sinatra'
require 'ohm'
require 'pry'
require 'slim'
class Person <Ohm::Model
	attribute :name
	attribute :country
	attribute :time
end

set :public_folder, File.dirname(__FILE__) + '/static'

get '/' do
	#binding.pry
	@persons = Person.all.to_a
  slim :index, layout: :application
end

get '/new' do
	slim :new, layout: :application
end

post '/add' do
	Person.create(params[:person])
	redirect to ('/')
end

post '/remove/:id' do |id|
	person = Person[id]
	person.delete
	redirect to ('/')  
end

