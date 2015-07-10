class CreateAccessToken < ActiveRecord::Migration
        def change
                create_table :access_tokens do |t|
                        t.string :token
                        t.integer :expires_in
                        t.timestamp :updated_at
                end
        end
end
