json.extract! user, :id, :name, :email, :company, :division, :contact_no, :auth_token, :password_reset_token, :password_reset_sent_at, :created_at, :updated_at
json.url user_url(user, format: :json)
