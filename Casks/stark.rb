cask 'stark' do
  version '2.2.0'
  sha256 '59df1657669e458e192baa5697418155543e1258d9c006b8d95b124493439fcf'

  url 'https://s3.amazonaws.com/stark-builds/stark-2.2.0.zip'
  name 'Stark'
  homepage 'https://github.com/starkwm/stark'

  app 'Stark.app'

  zap delete: [
    '~/Library/LaunchAgents/co.rustyrobots.Stark.plist',
    '~/Library/Preferences/co.rustyrobots.Stark.plist',
  ]
end
