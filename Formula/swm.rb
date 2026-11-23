class Swm < Formula
  desc 'Stark Window Manager'
  homepage 'https://github.com/starkwm/swm'

  version '0.0.35'

  url "https://github.com/starkwm/swm/archive/refs/tags/v#{version}.tar.gz"
  sha256 '4bec29c30293c6736a257a6361d307c020203b85c469c863e5f587164eef563c'
  license 'BSD-3-Clause'
  head 'https://github.com/starkwm/swm.git', branch: 'main'

  bottle do
    root_url "https://github.com/starkwm/swm/releases/download/v0.0.35"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "d47865e61c33f3b625e6f9c5900ff4b101ab30e54cb7ed61c5ac6836de8587b4"
  end

  depends_on xcode: :build
  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    system 'make', 'release'
    bin.install "#{buildpath}/.build/release/swm"
    generate_completions_from_executable bin / 'swm', '--generate-completion-script'
  end

  service do
    run opt_bin / 'swm'
    keep_alive true
    log_path var / 'log/swm.log'
    error_log_path var / 'log/swm.log'
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "swm version v#{version}", shell_output("#{bin}/swm --version")
  end
end
