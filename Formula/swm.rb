class Swm < Formula
  desc 'Stark Window Manager'
  homepage 'https://github.com/starkwm/swm'
  url 'https://github.com/starkwm/swm.git', tag: 'v0.0.6', revision: 'cf3f32481baa4c0be1988f4bb1d2626fe8d3e61d'
  head 'https://github.com/starkwm/swm.git', branch: 'main'

  bottle do
    root_url 'https://starkwm-builds.s3.amazonaws.com'
    sha256 cellar: :any_skip_relocation, arm64_tahoe: 'bb0d2792121a6607f2a74d1e26c7099c431dc257dd51106dabfe2c44691179b2'
  end

  depends_on xcode: :build

  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    system 'make', 'release'
    bin.install "#{buildpath}/.build/release/swm"
  end

  service do
    run HOMEBREW_PREFIX / 'bin/swm'
    keep_alive true
    log_path var / 'log/swm.log'
    error_log_path var / 'log/swm.log'
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "swm #{version}", shell_output("#{bin}/swm --version")
  end
end
