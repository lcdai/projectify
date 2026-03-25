JWT_SECRET = Rails.application.credentials.secret_key_base || ENV['JWT_SECRET'] || 'temporary_secret_change_me'
