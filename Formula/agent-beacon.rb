class AgentBeacon < Formula
  desc "MacBook Caps Lock LED status light for Codex"
  homepage "https://github.com/rynzh/Mac-Agent-Beacon"
  url "https://github.com/rynzh/Mac-Agent-Beacon/releases/download/v0.2.0/agent-beacon-0.2.0.tar.gz"
  sha256 "aeda2d4ac8c9feb0e12591d7b8a368624e7f5e904bfc4dcfa2dc7f2980434147"
  license "MIT"

  bottle do
    root_url "https://github.com/rynzh/homebrew-tap/releases/download/bottles-34676509444"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c33b37d064304373b76f6a3baa6396b954125d28e104b15b2b1c128dd863b580"
    sha256 cellar: :any_skip_relocation, sequoia:       "d257aed69d71861e2102c906278215170c563be4007431510aa443fda52f2a3d"
  end

  depends_on :macos
  depends_on "ruby"

  def install
    system "make", "all"
    libexec.install "bin", "build"
    (bin/"agent-beacon").write <<~SH
      #!/bin/bash
      export AGENT_BEACON_BREW="#{HOMEBREW_PREFIX}/bin/brew"
      export AGENT_BEACON_RUBY="#{Formula["ruby"].opt_bin}/ruby"
      export AGENT_BEACON_COMMAND="#{opt_bin}/agent-beacon"
      exec "#{opt_libexec}/bin/beacon" "$@"
    SH
    chmod 0755, bin/"agent-beacon"
  end

  service do
    run [opt_bin/"agent-beacon", "run"]
    keep_alive crashed: true
    process_type :background
    throttle_interval 30
  end

  def caveats
    "Run agent-beacon setup, then enable Input Monitoring and trust the Codex hooks."
  end

  test do
    assert_match "Agent Beacon", shell_output("#{bin}/agent-beacon --help")
  end
end
