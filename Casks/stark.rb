cask 'stark' do
  version '2.1.6'
  sha256 'e3633167601aa845f6eb4aa2788964ffae4365a4b2892102d2cef5ec7f13127c'

  url 'https://s3.amazonaws.com/stark-builds/stark-2.1.6.zip'
  name 'Stark'
  homepage 'https://github.com/starkwm/stark'

  app 'Stark.app'

  zap delete: [
    '~/Library/LaunchAgents/co.rustyrobots.Stark.plist',
    '~/Library/Preferences/co.rustyrobots.Stark.plist',
  ]
end
