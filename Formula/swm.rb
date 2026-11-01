class Swm < Formula
  desc 'Stark Window Manager'
  homepage 'https://github.com/starkwm/swm'

  version '0.0.29'

  url "https://github.com/starkwm/swm/archive/refs/tags/v#{version}.tar.gz"
  sha256 'c26f73088a419cfad00773783c162f908041c1d5f5bd1f2279a9d81685c93c2d'
  license 'BSD-3-Clause'
  head 'https://github.com/starkwm/swm.git', branch: 'main'

  bottle do
    root_url 'https://github.com/starkwm/swm/releases/download/v0.0.29'
    sha256 cellar: :any_skip_relocation,
           arm64_golden_gate: '13ee0992dc8be1d675140bd85ec86af274908d3e86bb465ab5855a834cae4ef0'
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
