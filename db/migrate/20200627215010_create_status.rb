class CreateStatus < ActiveRecord::Migration[6.0]
  def change
    create_table :statuses do |t|
      t.string :title, :event_type, :sender
      t.references :issue

      t.timestamps
    end
  end
end
