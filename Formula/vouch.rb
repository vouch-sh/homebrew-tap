class Vouch < Formula
  desc "Hardware-backed identity for developers"
  homepage "https://github.com/vouch-sh/vouch"
  version "0.1.4"
  license "Apache-2.0 OR MIT"

  on_macos do
    on_arm do
      url "https://github.com/vouch-sh/vouch/releases/download/v0.1.4/vouch-v0.1.4-aarch64-apple-darwin.tar.gz"
      sha256 "8ab4bc5c780d2a8ae518b132675d79184523a75cc944e2f41b393277c4fb69c4"
    end
  end

  def install
    bin.install "vouch"
    bin.install "vouch-agent"
    generate_completions_from_executable(bin/"vouch", "completions")
  end

  service do
    run [opt_bin/"vouch-agent", "--foreground"]
    keep_alive true
    log_path var/"log/vouch-agent.log"
    error_log_path var/"log/vouch-agent.log"
  end

  test do
    assert_match "vouch", shell_output("#{bin}/vouch --version")
  end
end
