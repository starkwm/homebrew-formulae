class Skbd < Formula
  desc "Stark Keybind Daemon"
  homepage "https://usestark.app"
  url "https://github.com/starkwm/skbd.git", tag: "v0.0.12", revision: "7bbf6aba2f49d145a8ba3395e41b172f4684d690"
  head "https://github.com/starkwm/skbd.git", branch: "main"

  bottle do
    root_url "https://skbd-builds.s3.amazonaws.com"
    sha256 cellar: :any_skip_relocation, ventura: "d6270995a55c748b14fe5a26d3e993c19d22daad9cd89647e83199209b44d94d"
  end

  depends_on xcode: :build
  depends_on macos: :monterey

  def install
    system "make", "package"
    bin.install "#{buildpath}/.build/release/skbd"
  end

  service do
    run opt_bin/"skbd"
    keep_alive true
    log_path var/"log/skbd.log"
    error_log_path var/"log/skbd.log"
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "skbd version #{version}", shell_output("#{bin}/skbd --version")
  end
end
