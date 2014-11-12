json.array!(@teachers) do |teacher|
  json.extract! teacher, :name, :email, :subject, :password_digest
  json.url teacher_url(teacher, format: :json)
end