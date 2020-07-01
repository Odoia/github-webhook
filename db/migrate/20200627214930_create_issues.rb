class CreateIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :issues do |t|
      t.string :title, :description, :owner
      t.bigint :issue_id

      t.timestamps
    end
  end
end
