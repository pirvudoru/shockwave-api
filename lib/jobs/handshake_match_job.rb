class HandshakeMatchJob
  HANDSHAKE_WINDOW = 15.seconds

  def perform
    Handshake.all.each do |handshake|
      matching_handshake = Handshake.where({
                                               :timestamp.gte => handshake.timestamp - HANDSHAKE_WINDOW,
                                               :timestamp.lte => handshake.timestamp + HANDSHAKE_WINDOW,
                                               :_id.ne => handshake._id
                                           })
                               .first

      if matching_handshake
        handshake.user.acquaintances.push(matching_handshake.user)
        matching_handshake.user.acquaintances.push(handshake.user)

        handshake.destroy
        matching_handshake.destroy
      end
    end
  end
end
