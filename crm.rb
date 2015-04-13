# require_relative 'contact'
# require_relative 'rolodex'
require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
  include DataMapper::Resource

  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :email, String
  property :notes, String
  # We get rid of attr_accessor and added properties from the DataMapper resource.

  # attr_accessor :id, :first_name, :last_name, :email, :notes

  # def initialize(first_name, last_name, email, notes)
  #   @first_name = first_name
  #   @last_name = last_name
  #   @email = email
  #   @notes = notes
  # end

  # def to_s
  #   "First Name: #{@first_name} " +
  #   "Last Name: #{@last_name} " +
  #   "Email: #{@email} " +
  #   "Notes: #{@notes} " +
  #   "Contact ID: #{@id}"
  # end
end

DataMapper.finalize
DataMapper.auto_upgrade!

# Here we are defining the Contact class. Each instantiation will represent
# a single contact with the five attributes as data. We let id be a method
# so it can be accessible to our database Rolodex. The contact is not reponsible
# setting their own id. Rolodex is reponsible for this and thus the responsiblity
# is handed over to rolodex.rb.


# $rolodex = Rolodex.new
# A route we made. For this particular URL and GET method this is the response.
get '/' do
  # puts "Hello World"
  # puts params
  @crm_app_name = "My CRM"
  erb :index
  # Sinatra convention is to store erb files in views.
end

# Things that show up in the terminal is called the terminal log.
# Params hash collects information and is stored.

get '/contacts' do
  @contacts = Contact.all
  # Shows all the contact from the database called contacts.
  erb :contacts
end
# The get request routes to the views /contacts

get '/contacts/new' do
  erb :new_contact
end
# The get request routes to the views /new_contact which then redirects to post '/contacts'

get '/contacts/:id/edit' do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end
# Rolodex finds the specific contact and goes to the views /contacts/id/edit which redirects as a put request.

get '/contacts/:id' do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

post '/contacts' do
  new_contact = Contact.create(
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email],
    notes: params[:notes]
    )
  redirect to('/contacts')
end
# Stores new contacts to the contacts array.


put '/contacts/:id' do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.notes = params[:notes]
    @contact.save
    redirect to ("/contacts")
  else
    raise Sinatra::NotFound
  end
end

delete '/contacts/:id' do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    @contact.destroy
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

# get '/:name' do
#   @name = params[:name].capitalize
  # Instance variable so it can be used outside of the route by the views.
  # Captures the key value from the params hash.
  # Can put symbol instead of string.
  # :name is a wildcard and params will store it in that hash.
  # "Hello #{name.capitalize}"
#   erb :hello
# end

# Mornings are only good at the slash level.
# Params hash disappears after it has been used.
# erb means embedded ruby. It gets read first.