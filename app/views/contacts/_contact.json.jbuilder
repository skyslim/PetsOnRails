json.extract! contact, :id, :user_id, :fullname, :subject, :message, :created_at, :updated_at
json.url contact_url(contact, format: :json)