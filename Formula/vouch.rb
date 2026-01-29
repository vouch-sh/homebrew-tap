class Vouch < Formula
  desc "Hardware-backed identity for developers"
  homepage "https://github.com/vouch-sh/vouch"
  version "0.1.3"
  license "Apache-2.0 OR MIT"

  on_macos do
    on_arm do
      url "https://github.com/vouch-sh/vouch/releases/download/v0.1.3/vouch-v0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "8eaea65a1dba5e14e5a6d11a5cd19cd89f1130d68781dbff1e05866d57a1d68d"
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
