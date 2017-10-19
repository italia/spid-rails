key = OpenSSL::PKey::RSA.new 1024
private_key = key.to_pem
cert = OpenSSL::X509::Certificate.new
name = OpenSSL::X509::Name.parse 'CN=nobody/DC=example'
open Rails.root + 'lib/.keys/private_key.pem', 'w' do |io| io.write private_key end
# TODO:verificare senso ogni passaggio
cert.version = 2
cert.serial = 0
cert.not_before = Time.now
cert.not_after = Time.now + 3600
cert.public_key = key.public_key
cert.subject = name
cert.issuer = name
cert.sign key, OpenSSL::Digest::SHA256.new
open Rails.root + 'lib/.keys/certificate.pem', 'w' do |io| io.write cert.to_pem end
