class Contact

  attr_accessor :id, :first_name, :last_name, :email, :notes

  def initialize(first_name, last_name, email, notes)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @notes = notes
  end

  def to_s
    "First Name: #{@first_name} " +
    "Last Name: #{@last_name} " +
    "Email: #{@email} " +
    "Notes: #{@notes} " +
    "Contact ID: #{@id}"
  end

end

# Here we are defining the Contact class. Each instantiation will represent
# a single contact with the five attributes as data. We let id be a method
# so it can be accessible to our database Rolodex. The contact is not reponsible
# setting their own id. Rolodex is reponsible for this and thus the responsiblity
# is handed over to rolodex.rb.