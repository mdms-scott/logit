class Request < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'hstore'
    create_table :requests do |t|
      t.string :uuid
      t.text :full_body
      t.hstore :parameters, default: {}
      t.integer :response
      t.boolean :successful
      t.float :view_time
      t.float :ar_time
      t.float :total_time
      t.string :controller
      t.string :action
      t.string :uri
      t.boolean :has_warning
      t.text :message
      t.datetime :timestamp
      t.string :request_type
      t.string :render
      t.float :render_time

      t.index :response
      t.index :successful
      t.index :total_time
      t.index :controller
      t.index :has_warning
      t.index :request_type
    end
  end
end
