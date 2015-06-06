namespace :handshake do
  desc 'Handshake Match'
  task :match => :environment do
    HandshakeMatchJob.new.perform
  end
end