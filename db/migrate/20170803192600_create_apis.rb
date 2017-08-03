class CreateApis < ActiveRecord::Migration[5.1]
  def change
    create_table :apis do |t|
      t.string :endpoint, null: false
      t.string :request_type, null: false, default: 'getr'
      t.string :required_params
      t.string :required_headers
      t.text :success_response, null: false
      t.text :error_response
      t.timestamps
    end
  end
end
