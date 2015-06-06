class HandshakeMatchJob
  HANDSHAKE_WINDOW = 15.seconds

  def perform
    Handshake.all.each do |handshake|
      matching_handshake = Handshake.find_by({
                                              :timestamp.gte => handshake.timestamp - HANDSHAKE_WINDOW,
                                              :timestamp.lte => handshake.timestamp + HANDSHAKE_WINDOW
                                          })

      if matching_handshake
        handshake.user.acquaintances.push(matching_handshake.user)
        matching_handshake.user.acquaintances.push(handshake.user)
      end
    end
  end
end
