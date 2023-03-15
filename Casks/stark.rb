cask 'stark' do
  version '2.2.0'
  sha256 '6fe21876df30bf165df2274ba47fded4310cd6d39c4a6318192fd4f4fe82450f'

  url 'https://s3.amazonaws.com/stark-builds/stark-2.2.0.zip'
  name 'Stark'
  homepage 'https://github.com/starkwm/stark'

  app 'Stark.app'

  zap delete: [
    '~/Library/LaunchAgents/co.rustyrobots.Stark.plist',
    '~/Library/Preferences/co.rustyrobots.Stark.plist',
  ]
end
