class CreateTeachers < ActiveRecord::Migration
  def up
	begin
	    create_table :teachers do |t|
	      t.string :name
	      t.string :email
	      t.string :subject
	      t.string :password_digest

	      t.timestamps
	    end
	rescue
		1
	end
  end

  def down
  	drop_table :teachers
  end
end
