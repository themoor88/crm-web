require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'

$rolodex = Rolodex.new
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
  erb :contacts
end

get '/contacts/new' do
  erb :new_contact
end

post '/contacts' do
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:notes])
  $rolodex.store_new_contact(new_contact)
  redirect to('/contacts')
end

get '/contacts/:id/edit' do
  @contact = $rolodex.find(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

put '/contacts/:id' do
  @contact = $rolodex.find(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.notes = params[:notes]
    redirect to ("/contacts")
  else
    raise Sinatra::NotFound
  end
end

delete '/contacts/:id' do
  @contact = $rolodex.find(params[:id].to_i)
  if @contact
    $rolodex.delete_contact(@contact)
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

get '/contacts/:id' do
  @contact = $rolodex.find(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

# get '/:name' do
#   @name = params[:name].capitalize
  # Instance variable so it can be used outside of the route.
  # Captures the key value from the params hash.
  # Can put symbol instead of string.
  # :name is a wildcard and params will store it in that hash.
  # "Hello #{name.capitalize}"
#   erb :hello
# end

# Mornings are only good at the slash level.
# Params hash disappears after it has been used.
# erb means embedded ruby. It gets read first.