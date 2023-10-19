cask 'stark' do
  version '2.3.0'
  sha256 '02aba0f8c02bf178f7806fd6b01eca0cfbd3417d976900746561537221e40448'

  url 'https://s3.amazonaws.com/stark-builds/stark-2.3.0.zip'
  name 'Stark'
  homepage 'https://github.com/starkwm/stark'

  app 'Stark.app'

  zap delete: [
    '~/Library/LaunchAgents/co.rustyrobots.Stark.plist',
    '~/Library/Preferences/co.rustyrobots.Stark.plist',
  ]
end
