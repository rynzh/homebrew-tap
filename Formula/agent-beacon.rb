class AgentBeacon < Formula
  desc "MacBook Caps Lock LED status light for Codex"
  homepage "https://github.com/rynzh/Mac-Agent-Beacon"
  url "https://github.com/rynzh/Mac-Agent-Beacon/releases/download/v0.3.1/agent-beacon-0.3.1.tar.gz"
  sha256 "7b658420f9ca16a04b68641c87e7a415c7775dd70dbfa2d42e6d8e8e6d354d88"
  license "MIT"

  bottle do
    root_url "https://github.com/rynzh/homebrew-tap/releases/download/bottles-36516973806"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "df57a607e3a773d2d382c6ad5246862cc62880140ed5cb4038606036b201a2bf"
    sha256 cellar: :any_skip_relocation, sequoia:       "5077db4f40ef75daf525c80b8f3d52889c6536a24326552dd4ef266c46370a32"
  end

  depends_on macos: :sequoia
  depends_on "ruby"

  def install
    system "make", "all"
    libexec.install "bin", "build"
    (bin/"agent-beacon").write <<~SH
      #!/bin/bash
      export AGENT_BEACON_BREW="#{HOMEBREW_PREFIX}/bin/brew"
      export AGENT_BEACON_RUBY="#{formula_opt_bin("ruby")}/ruby"
      export AGENT_BEACON_COMMAND="#{opt_bin}/agent-beacon"
      exec "#{opt_libexec}/bin/beacon" "$@"
    SH
    chmod 0755, bin/"agent-beacon"
  end

  service do
    run [opt_bin/"agent-beacon", "run"]
    keep_alive successful_exit: false
    process_type :background
    throttle_interval 30
    log_path var/"log/agent-beacon.log"
    error_log_path var/"log/agent-beacon.log"
  end

  def caveats
    "Run agent-beacon setup, then enable Input Monitoring and trust the Codex hooks."
  end

  test do
    assert_match "Agent Beacon", shell_output("#{bin}/agent-beacon --help")
  end
end
