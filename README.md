# Agent Beacon Homebrew Tap

Use your MacBook Caps Lock LED to follow Codex tasks.

```sh
brew install --force-bottle rynzh/tap/agent-beacon && agent-beacon setup
```

Enable Input Monitoring for the helper path printed by setup, then review and
trust Agent Beacon hooks in Codex CLI's `/hooks` screen.

Requires Homebrew and macOS 15 or later. Bottles are built for Apple Silicon and
Intel; Homebrew manages Ruby automatically. The recommended command requires a
compatible bottle instead of silently falling back to source compilation.

```sh
agent-beacon status
brew services restart agent-beacon
brew upgrade agent-beacon
agent-beacon setup
```

To remove the integration and package:

```sh
agent-beacon uninstall
brew uninstall agent-beacon
```

See the [project documentation](https://github.com/rynzh/Mac-Agent-Beacon/blob/main/docs/HOMEBREW.md)
for migration from the source installer, compatibility, and release details.
