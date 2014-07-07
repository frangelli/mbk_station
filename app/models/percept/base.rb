class Percept::Base < ActiveRecord::Base
  #its not a table
  self.abstract_class = true

  establish_connection("percept_#{::Rails.env}")
end