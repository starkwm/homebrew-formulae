class Swm < Formula
  desc 'Stark Window Manager'
  homepage 'https://github.com/starkwm/swm'

  url 'https://github.com/starkwm/swm/archive/refs/tags/v0.0.8.tar.gz'
  sha256 '7650871bc89229ee63de878c2f7b822c7a336d38dad09d8a7fcb63804e78fd46'
  head 'https://github.com/starkwm/swm.git', branch: 'main'

  bottle do
    root_url 'https://starkwm-builds.s3.amazonaws.com'
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe: '87e556721401cc2b1cc8d61f336c83b0bc3a1b165466379d25ad203fbe8052b1'
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
