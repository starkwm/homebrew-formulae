class Stags < Formula
  desc 'Stark window tags for macOS'
  homepage 'https://github.com/starkwm/stags'

  version '0.0.2'

  url "https://github.com/starkwm/stags/archive/refs/tags/v#{version}.tar.gz"
  sha256 'cc6b685af8c8f21ea4de6387a2228b1e209005373b94f265bd97fd4f139d2d38'
  license 'BSD-3-Clause'
  head 'https://github.com/starkwm/stags.git', branch: 'main'

  bottle do
    root_url "https://github.com/starkwm/stags/releases/download/v0.0.2"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "d952f33e3da9f58c4f15a4fd69b286cc524410b25a54c1dc024ee5a52648a23d"
  end

  depends_on xcode: :build
  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    system 'swift', 'build', '--configuration', 'release', '--disable-sandbox'
    bin.install "#{buildpath}/.build/release/stags"
  end

  service do
    run [opt_bin / 'stags', 'daemon']
    keep_alive true
    log_path var / 'log/stags.log'
    error_log_path var / 'log/stags.log'
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "stags version v#{version}", shell_output("#{bin}/stags --version")
  end
end
