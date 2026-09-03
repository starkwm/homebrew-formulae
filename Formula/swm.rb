class Swm < Formula
  desc 'Stark Window Manager'
  homepage 'https://github.com/starkwm/swm'

  url 'https://github.com/starkwm/swm/archive/refs/tags/v0.0.11.tar.gz'
  sha256 '995f2dbfc7859e88a25391b4e6b9cebd608700043fb8b2ed3cac8131e1000bc5'
  head 'https://github.com/starkwm/swm.git', branch: 'main'

  bottle do
    root_url 'https://starkwm-builds.s3.amazonaws.com'
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "a646ebe7de6addd1781b6da1a5e82c228eec132648bff4c23217fcee7f6d844c"
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
