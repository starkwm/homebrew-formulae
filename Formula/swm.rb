class Swm < Formula
  desc 'Stark Window Manager'
  homepage 'https://github.com/starkwm/swm'

  version '0.0.36'

  url "https://github.com/starkwm/swm/archive/refs/tags/v#{version}.tar.gz"
  sha256 '453a26098693a5088444480e95701186b665f63cfe4bbbe680bf1af3e4b29a90'
  license 'BSD-3-Clause'
  head 'https://github.com/starkwm/swm.git', branch: 'main'

  bottle do
    root_url "https://github.com/starkwm/swm/releases/download/v0.0.36"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "4a8bc8bdbe6621eb71bfa65776d3d5294917e4e2567a71b978daf561a49aac4b"
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
