cask 'stark' do
  version '2.5.0'
  sha256 '8fdb44b29eddf79e288c5a813bd03877b435447286e94cd1ffbed4147f1ad9d7'

  url 'https://s3.amazonaws.com/stark-builds/stark-2.5.0.zip'
  name 'Stark'
  homepage 'https://github.com/starkwm/stark'

  app 'Stark.app'

  zap delete: [
    '~/Library/LaunchAgents/co.rustyrobots.Stark.plist',
    '~/Library/Preferences/co.rustyrobots.Stark.plist',
  ]
end
