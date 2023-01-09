cask 'stark' do
  version '2.1.5'
  sha256 '636bbfe4193e93e6c0e94b953acd21ec88f38f839b07dde4bd0cdf8a631568a5'

  url 'https://s3.amazonaws.com/stark-builds/stark-2.1.5.zip'
  name 'Stark'
  homepage 'https://github.com/starkwm/stark'

  app 'Stark.app'

  zap delete: [
    '~/Library/LaunchAgents/co.rustyrobots.Stark.plist',
    '~/Library/Preferences/co.rustyrobots.Stark.plist',
  ]
end
