Rails.logger.info("Start!!!")
User.all.each do |user|
  if user.is_deleted.nil?
    user.update!(is_deleted: false)
  end
  Rails.logger.info(user.inspect)
end
Rails.logger.info("DONE!!!")