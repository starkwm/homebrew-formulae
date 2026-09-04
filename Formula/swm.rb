class Swm < Formula
  desc "Stark Window Manager"
  homepage "https://github.com/starkwm/swm"

  url "https://github.com/starkwm/swm/archive/refs/tags/v0.0.13.tar.gz"
  sha256 "72dedd434781fe592681d9bc09ef3a8730f4dc95ad9de0bda7b2b43f17e6b67d"
  head "https://github.com/starkwm/swm.git", branch: "main"

  bottle do
    root_url "https://starkwm-builds.s3.amazonaws.com"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "39da50f6a59e16acd6762905aef10d826ad555a98af5865d2d45668994d755f5"
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
