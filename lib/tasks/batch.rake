namespace :batch do
  desc "Update Application and Chats count"
  task update_counts: :environment do
    chat_result = Chat.group(:application_id).count
    chat_result.each do |key, value|
      Application.find(key).update(chats_count: value)
    end
    message_result = Message.group(:chat_id).count
    message_result.each do |key, value|
      Chat.find(key).update(messages_count: value)
    end
    puts "Task Done"
  end

end
