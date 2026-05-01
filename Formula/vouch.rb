class Vouch < Formula
  desc "Hardware-backed identity for developers"
  homepage "https://github.com/vouch-sh/vouch"
  version "2026.4.9"
  license "Apache-2.0 OR MIT"

  on_macos do
    on_arm do
      url "https://github.com/vouch-sh/vouch/releases/download/v2026.4.9/vouch-v2026.4.9-aarch64-apple-darwin.tar.gz"
      sha256 "89f5074abd477f6901bb1beed4fb0bf48bc29bb26dd0f62846086e6ba4562f2e"
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

  def caveats
    <<~EOS
      To restart the vouch-agent service after upgrading:
        brew services restart vouch
    EOS
  end

  test do
    assert_match "vouch", shell_output("#{bin}/vouch --version")
  end
end
