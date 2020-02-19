json.tweets @tweets do |tweet|
  json.extract! tweet, :id, :message
  json.user tweet.user.full_name
  json.user_email tweet.user.email
  json.user_id tweet.user.id
end