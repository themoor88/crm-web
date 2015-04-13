class Rolodex
  attr_reader :contacts

  def initialize
    @contacts = []
    @id = 1
  end

  def find(contact_id)
    @contacts.find { |contact| contact.id == contact_id}
  end

  def store_new_contact(contact)
    contact.id = @id
    @contacts << contact
    @id += 1
  end

  def modify_contact(contact, attribute, new_attribute)
      if attribute == "first name"
        contact.first_name = new_attribute
      elsif attribute == "last name"
        contact.last_name = new_attribute
      elsif attribute == "email"
        contact.email = new_attribute
      elsif attribute == "notes"
        contact.notes = new_attribute
      else
        puts "That is an invalid attribute."
      end
  end

  def delete_contact(contact)
    @contacts.delete(contact)
  end
end

# This defines a new class called Rolodex and initializes two new instance variables
# called @contacts and @id. @contacts is the array of all of the contacts. contact
# is a single entry of the array composed of the elements of the object. These methods
# can change the values of Rolodex but Rolodex protects contacts from the outside. Rolodex
# can be considered the database which searches using the @id.