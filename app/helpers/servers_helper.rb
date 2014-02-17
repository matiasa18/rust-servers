module ServersHelper

  def is_mine(server)
    if user_signed_in?
      if current_user.id == server.user_id 
        true
      end
      false
    end
    false
  end
end
