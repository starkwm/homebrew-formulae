class Skbd < Formula
  desc "Stark Keybind Daemon"
  homepage "https://usestark.app"
  url "https://github.com/starkwm/skbd.git", tag: "v0.0.1", revision: "32262e2cb05e0b8745c24a9dbc16f1d5211a18ca"
  head "https://github.com/starkwm/skbd.git", branch: "main"

  bottle do
    root_url "https://skbd-builds.s3.amazonaws.com"
    sha256 cellar: :any_skip_relocation, ventura: "6d7410439fc3b1e219389dc58a96e193b8b3b3f63a3d4d3248014f96a6a58793"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "a715710ec155fe5d3fe9e59d079b6cf63abe6ce2740a72abfb1597d00a5b54f4"
  end

  depends_on xcode: :build
  depends_on macos: :ventura

  def install
    system "make", "release"
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
