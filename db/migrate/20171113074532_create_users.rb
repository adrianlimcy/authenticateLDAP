class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      # t.string :password_digest
      t.string :email
      t.string :company
      t.string :division
      t.string :contact_no
      t.string :group
      # t.string :auth_token
      # t.string :password_reset_token
      # t.datetime :password_reset_sent_at

      t.timestamps
    end
  end
end
