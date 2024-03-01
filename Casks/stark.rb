cask 'stark' do
  name 'Stark'
  desc 'Power your window management with JavaScript.'
  homepage 'https://github.com/starkwm/stark'

  version '2.5.0'
  url 'https://stark-builds.s3.amazonaws.com/stark-2.5.0.zip', verified: 'https://stark-builds.s3.amazonaws.com'
  sha256 '8fdb44b29eddf79e288c5a813bd03877b435447286e94cd1ffbed4147f1ad9d7'

  depends_on macos: :sonoma

  app 'Stark.app'

  zap delete: [
    '~/Library/LaunchAgents/co.rustyrobots.Stark.plist',
    '~/Library/Preferences/co.rustyrobots.Stark.plist',
  ]
end
