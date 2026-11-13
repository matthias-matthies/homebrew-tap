cask "lights-off" do
  version "0.2.53"
  sha256 "74f8fb068ee0ebb0641ea5c2a6d43d41c826a961f11d44ed9bbf05893d7c1c14"

  url "https://github.com/matthias-matthies/lights-off/releases/download/v#{version}/lights-off_v#{version}_darwin_arm64.tar.gz"
  name "lights-off"
  desc "Takes GitHub tickets from start to merge using sandboxed agents"
  homepage "https://github.com/matthias-matthies/lights-off"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma
  depends_on cask: "docker/tap/sbx"
  depends_on formula: "gh"

  binary "lights-off"

  # The binary isn't notarized, and Homebrew quarantines every cask download,
  # so Gatekeeper would refuse to run it.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-d", "com.apple.quarantine", "{{staged_path}}/lights-off"],
        must_succeed: false
  end

  zap trash: [
    "~/.cache/lights-off",
    "~/.config/lights-off",
    "~/.local/state/lights-off",
  ]
end
