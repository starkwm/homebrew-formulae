class SkbdAT2 < Formula
  desc 'Stark Keybind Daemon for macOS, bind shortcuts to shell commands'
  homepage 'https://github.com/starkwm/skbd'
  url 'https://github.com/starkwm/skbd.git', tag: 'v0.0.4', revision: '4a1c7468fbefabc00b9ac2e6a8ce9512825854fa'
  head 'https://github.com/starkwm/skbd.git', branch: 'main'

  bottle do
    root_url 'https://starkwm-builds.s3.amazonaws.com'
    rebuild 4
    sha256 cellar: :any_skip_relocation, arm64_tahoe: 'f73ef628b2fffe853cb7eb1aee67b51a22a939367d8e7cd84dda02faccb358b7'
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
