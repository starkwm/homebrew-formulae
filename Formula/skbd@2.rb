class SkbdAT2 < Formula
  desc 'Stark Keybind Daemon for macOS, bind shortcuts to shell commands'
  homepage 'https://github.com/starkwm/skbd'

  url 'https://github.com/starkwm/skbd/archive/refs/tags/v0.0.6.tar.gz'
  head 'https://github.com/starkwm/skbd.git', branch: 'main'

  bottle do
    root_url 'https://starkwm-builds.s3.amazonaws.com'
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe: '14a512fb0b2d399e143c9154264ce784fe5df182ef57635352185ac7f4c448b0'
  end

  depends_on xcode: :build

  depends_on arch: :arm64
  depends_on macos: :sequoia

  def install
    system 'make', 'release'
    bin.install "#{buildpath}/.build/release/skbd"
  end

  service do
    run opt_bin / 'skbd'
    keep_alive true
    log_path var / 'log/skbd@2.log'
    error_log_path var / 'log/skbd@2.log'
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "skbd #{version}", shell_output("#{bin}/skbd --version")
  end
end
