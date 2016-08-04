class AddParticipationTable < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.belongs_to :participant, index: true
      t.belongs_to :pin, index: true
      t.timestamps
    end
  end
end
