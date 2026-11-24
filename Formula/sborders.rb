class Sborders < Formula
  desc 'Stark Borders for macOS'
  homepage 'https://github.com/starkwm/sborders'

  version '0.0.2'

  url "https://github.com/starkwm/sborders/archive/refs/tags/v#{version}.tar.gz"
  sha256 'f60ccf7a90f2f4daf9e64d2b2864c1534d54a9e5ac7ad6baf7f0c863c7f6383e'
  license 'BSD-3-Clause'
  head 'https://github.com/starkwm/sborders.git', branch: 'main'

  bottle do
    root_url "https://github.com/starkwm/sborders/releases/download/v0.0.2"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "7feae9d3d718c1684519bdee4c236e977c6fd49bb634e193afd548817d3722c9"
  end

  depends_on xcode: :build
  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    system 'swift', 'build', '--configuration', 'release', '--disable-sandbox'
    bin.install "#{buildpath}/.build/release/sborders"
    generate_completions_from_executable bin / 'sborders', '--generate-completion-script'
  end

  service do
    run opt_bin / 'sborders'
    keep_alive true
    log_path var / 'log/sborders.log'
    error_log_path var / 'log/sborders.log'
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/sborders --version")
  end
end
