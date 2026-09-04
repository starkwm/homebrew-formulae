class Swm < Formula
  desc "Stark Window Manager"
  homepage "https://github.com/starkwm/swm"

  url "https://github.com/starkwm/swm/archive/refs/tags/v0.0.14.tar.gz"
  sha256 "e9fd3545ab9c8f2abf65b2c504cf44f5040c48aaa1acc8117245fe3bfaf2ebd1"
  head "https://github.com/starkwm/swm.git", branch: "main"

  bottle do
    root_url "https://starkwm-builds.s3.amazonaws.com"
    rebuild 5
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "5dcf858c7aeae453bd9fb3e92c2bf0be72f2f650acfe20c4b9a84f21793ac404"
  end

  depends_on xcode: :build
  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    system "make", "release"
    bin.install "#{buildpath}/.build/release/swm"
    generate_completions_from_executable bin / "swm", "--generate-completion-script"
  end

  service do
    run opt_bin / "swm"
    keep_alive true
    log_path var / "log/swm.log"
    error_log_path var / "log/swm.log"
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "swm #{version}", shell_output("#{bin}/swm --version")
  end
end
