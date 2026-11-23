class SkbdAT2 < Formula
  desc 'Stark Keybind Daemon for macOS, bind shortcuts to shell commands'
  homepage 'https://github.com/starkwm/skbd'

  version '0.0.10'

  url "https://github.com/starkwm/skbd/archive/refs/tags/v#{version}.tar.gz"
  sha256 'e36192878afd94f4c8f47fe779d9d536c2fda25875b4ddbae0f44eac7bf470f9'
  license 'BSD-3-Clause'
  head 'https://github.com/starkwm/skbd.git', branch: 'main'

  bottle do
    root_url "https://github.com/starkwm/skbd/releases/download/v0.0.10"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "9b98e3138ed0d9491dbe99a8b4c894e9c7a0871d111a2882086db2f6043e1778"
  end

  depends_on xcode: :build
  depends_on arch: :arm64
  depends_on macos: :tahoe

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
    assert_match "skbd v#{version}", shell_output("#{bin}/skbd --version")
  end
end
