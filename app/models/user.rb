class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :administered_pins, class_name: 'Pin', foreign_key: 'admin_id'
  has_many :participations, foreign_key: 'participant_id'
  has_many :pins, through: :participations

  def participates(pin)
    pins.exists?(pin.id)
  end

  def participate(pin)
    if !participates(pin)
      pins << pin
    end
  end

  def stop_participating(pin)
    if participates(pin)
      pins.delete(pin) # important: keep delete, do not use destroy
    end
  end
end
