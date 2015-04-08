class Rolodex
  attr_reader :contacts

  def self.attr_reader(name)
      def #{name}
        @#{name}
      end
  end

  def contacts=(value)
    @contacts = value
  end

  def initialize
    @contacts = []
    @id = 1
  end

  def find(contact_id)
    @contacts.find do |contact|
      contact.id == contact_id
    end
  end

  # def search(query)
  #   if query == "first name"
  #   @contacts.select do |contact|
  #     contact.first_name == first_name
  #   elsif query == "first name"
  #   @contacts.select do |contact|
  #     contact.first_name == first_name
  #   elsif query == "first name"
  #   @contacts.select do |contact|
  #     contact.first_name == first_name
  #   elsif query == "first name"
  #   @contacts.select do |contact|
  #     contact.first_name == first_name
  #   end
  # end

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
  # Question: WHy can't I run contact.attribute?

  def delete_contact(contact_id)
    @contacts.delete_if do |contact|
    contact.id == contact_id
    end
  end
end