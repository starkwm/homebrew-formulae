class SkbdAT2 < Formula
  desc 'Stark Keybind Daemon for macOS, bind shortcuts to shell commands'
  homepage 'https://github.com/starkwm/skbd'
  url 'https://github.com/starkwm/skbd.git', tag: 'v0.0.5', revision: 'ec97bd4a55405228ae48cfa712a74d3dc0708204'
  head 'https://github.com/starkwm/skbd.git', branch: 'main'

  bottle do
    root_url 'https://starkwm-builds.s3.amazonaws.com'
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
