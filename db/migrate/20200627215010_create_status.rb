class CreateStatus < ActiveRecord::Migration[6.0]
  def change
    create_table :statuses do |t|
      t.string :status
      t.references :issue

      t.timestamps
    end
  end
end
