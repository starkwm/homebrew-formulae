class SkbdAT2 < Formula
  desc 'Stark Keybind Daemon for macOS, bind shortcuts to shell commands'
  homepage 'https://github.com/starkwm/skbd'
  url 'https://github.com/starkwm/skbd.git', tag: 'v0.0.3', revision: '85030171cd70f7a1e4e1d71a87d3787b9785d5ef'
  head 'https://github.com/starkwm/skbd.git', branch: 'main'

  bottle do
    root_url 'https://starkwm-builds.s3.amazonaws.com'
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_tahoe: 'e74733c42ce48fa94c5dc9d0472e1fff73792e20ed916d8d80f6bb1e4a520e7d'
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
