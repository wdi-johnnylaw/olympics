class CreateAthletes < ActiveRecord::Migration
  def change
    create_table :athletes do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.integer :age
      t.string :sport
      t.string :country

      t.timestamps
    end
  end
end
