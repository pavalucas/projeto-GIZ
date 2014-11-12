class AddSubjectToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subject, :string
  end
end
