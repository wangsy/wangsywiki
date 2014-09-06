Rails 4.1 부터 새롭게 추가된 기능

	class Conversation < ActiveRecord::Base
	  enum status: [ :active, :archived ]
	end

	# conversation.update! status: 0
	conversation.active!
	conversation.active? # => true
	conversation.status  # => "active"

	# conversation.update! status: 1
	conversation.archived!
	conversation.archived? # => true
	conversation.status    # => "archived"

	# conversation.update! status: 1
	conversation.status = "archived"

	# conversation.update! status: nil
	conversation.status = nil
	conversation.status.nil? # => true
	conversation.status      # => nil
