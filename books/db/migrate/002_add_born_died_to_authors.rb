class AddBornDiedToAuthors < ActiveRecord::Migration[5.0]
  def change
    add_column :authors, :born, :date
    add_column :authors, :died, :date
  end
end
