json.followers @followers do |follower|
  json.extract! follower, :id, :first_name, :last_name, :gender, :phone_number, :email
end
json.following @following do |following|
  json.extract! following, :id, :first_name, :last_name, :gender, :phone_number, :email
end