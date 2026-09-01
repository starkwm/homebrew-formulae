class Swm < Formula
  desc 'Stark Window Manager'
  homepage 'https://github.com/starkwm/swm'

  url 'https://github.com/starkwm/swm/archive/refs/tags/v0.0.10.tar.gz'
  sha256 '1e2b9753ad6083fe07766d172db65e1be73dd2c7f21e548bc2aa3ab87a5dc69d'
  head 'https://github.com/starkwm/swm.git', branch: 'main'

  bottle do
    root_url 'https://starkwm-builds.s3.amazonaws.com'
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe: 'c49b7c6caf121dfe23ce7d04fdd24da8511a71d75a78e6ddc864f5d52c994d56'
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
