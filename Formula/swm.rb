class Swm < Formula
  desc 'Stark Window Manager'
  homepage 'https://github.com/starkwm/swm'
  url 'https://github.com/starkwm/swm.git', tag: 'v0.0.5', revision: 'fe77f14afd43a0f18ec013022cf44ae550ec09b2'
  head 'https://github.com/starkwm/swm.git', branch: 'main'

  bottle do
    root_url 'https://starkwm-builds.s3.amazonaws.com'
    sha256 cellar: :any_skip_relocation, arm64_tahoe: '516a33c44eff598066b84d21b8577ccbb4694e78789cb4172ebf0116f3137ef3'
  end

  depends_on xcode: :build

  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    system 'make', 'release'
    bin.install "#{buildpath}/.build/release/swm"
  end

  service do
    run opt_bin / 'swm'
    keep_alive true
    log_path var / 'log/swm.log'
    error_log_path var / 'log/swm.log'
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "swm #{version}", shell_output("#{bin}/swm --version")
  end
end
