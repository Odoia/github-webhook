class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :comment, :owner
      t.references :issue

      t.timestamps
    end
  end
end
