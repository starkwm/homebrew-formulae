class Swm < Formula
  desc "Stark Window Manager"
  homepage "https://github.com/starkwm/swm"

  url "https://github.com/starkwm/swm/archive/refs/tags/v0.0.15.tar.gz"
  sha256 "ffd1910b06a318d193173a293bf915250fbed2ad7f1241f6ad2ce0266f10de1a"
  head "https://github.com/starkwm/swm.git", branch: "main"

  bottle do
    root_url "https://starkwm-builds.s3.amazonaws.com"
    rebuild 6
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "3cd9892b888ce977b46e01e5ddedc87dc155eb3033d828f32cba7cdb368c3fe7"
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
