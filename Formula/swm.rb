class Swm < Formula
  desc 'Stark Window Manager'
  homepage 'https://github.com/starkwm/swm'
  url 'https://github.com/starkwm/swm.git', tag: 'v0.0.3', revision: '980e46a075d63a96ea3bebc11b128b3822c8d915'
  head 'https://github.com/starkwm/swm.git', branch: 'main'

  bottle do
    root_url 'https://starkwm-builds.s3.amazonaws.com'
    sha256 cellar: :any_skip_relocation, arm64_tahoe: '547d30b26683094a73ee80a2f0b2508492d06bb3e686965fc001ab56ed8e0303'
  end

  depends_on xcode: :build

  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    system 'make', 'release'
    bin.install "#{buildpath}/.build/release/swm"

    identity = ENV['SWM_SIGN_IDENTITY'] || '-' # fallback to ad-hoc
    args = %W[
      --force
      --sign #{identity}
      --identifier dev.tombell.swm
      --timestamp
    ]
    args.delete('--timestamp') if identity == '-' # ad-hoc can't timestamp
    args.delete('--options') && args.delete('runtime') if identity == '-'

    system 'codesign', *args, bin / 'swm'
    system 'codesign', '--verify', '--strict', '--verbose=2', bin / 'swm'
  end

  service do
    run opt_bin / 'swm'
    keep_alive true
    log_path var / 'log/swm.log'
    error_log_path var / 'log/swm.log'
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "swm #{version}", shell_output("#{bin}/skbd --version")
  end
end
