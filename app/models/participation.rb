class Participation < ActiveRecord::Base
  belongs_to :pin
  belongs_to :participant, class_name: 'User' 
end
