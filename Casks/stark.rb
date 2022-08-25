cask 'stark' do
  version '2.1.4'
  sha256 '81ebf69d93531397614c2db926c0ed1cb1d00c31aea9d53cf878d7e976c88c22'

  url 'https://s3.amazonaws.com/stark-builds/stark-2.1.4.zip'
  name 'Stark'
  homepage 'https://github.com/starkwm/stark'

  depends_on macos: :monterey

  app 'Stark.app'

  zap delete: [
    '~/Library/LaunchAgents/co.rustyrobots.Stark.plist',
    '~/Library/Preferences/co.rustyrobots.Stark.plist',
  ]
end
