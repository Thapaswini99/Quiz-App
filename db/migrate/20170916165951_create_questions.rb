class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :Question
      t.string :variety
      t.references :subgenre, foreign_key: true

      t.timestamps
    end
  end
end
