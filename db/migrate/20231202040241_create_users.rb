class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :google_id, null: false
      t.boolean :email_verified
      t.string :hosted_domain
      t.string :avatar_url

      t.timestamps
    end
  end
end
