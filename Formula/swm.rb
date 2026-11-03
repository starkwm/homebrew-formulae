class Swm < Formula
  desc 'Stark Window Manager'
  homepage 'https://github.com/starkwm/swm'

  version '0.0.30'

  url "https://github.com/starkwm/swm/archive/refs/tags/v#{version}.tar.gz"
  sha256 'f3602c1297ac6e29d644603d79cfa58fda6a98e82f763e4be7c898e54576a14b'
  license 'BSD-3-Clause'
  head 'https://github.com/starkwm/swm.git', branch: 'main'

  bottle do
    root_url 'https://github.com/starkwm/swm/releases/download/v0.0.30'
    rebuild 1
    sha256 cellar: :any_skip_relocation,
           arm64_golden_gate: 'b7b177f3b8d8050c7f3a261acb3921d17e3e209443af933f94e3867a5fb2bba9'
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
