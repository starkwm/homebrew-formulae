cask 'stark' do
  version '2.4.0'
  sha256 'c5d1ebb8ec9198df8102e9cf96251bb8f11053a7c3bdaf427c84ad454269a929'

  url 'https://s3.amazonaws.com/stark-builds/stark-2.4.0.zip'
  name 'Stark'
  homepage 'https://github.com/starkwm/stark'

  app 'Stark.app'

  zap delete: [
    '~/Library/LaunchAgents/co.rustyrobots.Stark.plist',
    '~/Library/Preferences/co.rustyrobots.Stark.plist',
  ]
end
