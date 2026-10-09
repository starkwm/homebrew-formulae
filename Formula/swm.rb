class Swm < Formula
  desc 'Stark Window Manager'
  homepage 'https://github.com/starkwm/swm'

  version '0.0.26'

  url "https://github.com/starkwm/swm/archive/refs/tags/v#{version}.tar.gz"
  sha256 'e6e902dff122e60998eaf4cf6d715d92b8033db2b33a54f1a766a2bc41aa45aa'
  head 'https://github.com/starkwm/swm.git', branch: 'main'

  bottle do
    root_url 'https://github.com/starkwm/swm/releases/download/v0.0.25'
    sha256 cellar: :any_skip_relocation,
           arm64_golden_gate: 'a43214842d288f91eb5944a59898a24801e2c2ad223c26029076cfad752eeab7'
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
    assert_match "swm #{version}", shell_output("#{bin}/swm --version")
  end
end
