class Dsmactools < Formula
  desc "Controller workbench for Mac game developers"
  homepage "https://github.com/olliejudge/dsmactools"
  url "https://github.com/olliejudge/dsmactools/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "3b9740defd6106927b5ea275fa514fc86f8ab7ae84261379de8ed4be83891642"
  license "MIT"

  bottle do
    root_url "https://github.com/olliejudge/dsmactools/releases/download/v0.5.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "dea2a739041106b1ee0a7a1cc037c05943ad128956ce3d60ce873529b066c372"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "191cd4747fc5200d15e07e4d8eed298a316ff0f22aa38866b1b755bbc0058e3c"
    sha256 cellar: :any_skip_relocation, tahoe:         "e3f67a46c95616254e2467a0d4613653f173c1ffd53334b7e56e7243cd8f5dc2"
    sha256 cellar: :any_skip_relocation, sequoia:       "aa154ba0b00c988e09bef5327d77761fa087c0484ef0a963a07d8b487a9ac30f"
  end

  env :std

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # Argument validation runs before any HID access, so no controller or network is needed.
    assert_match "Feedback duration must be 1–30 seconds",
                 shell_output("#{bin}/dsmactools --feedback rumble --duration 99 2>&1", 1)
    assert_match "require --feedback lightbar",
                 shell_output("#{bin}/dsmactools --feedback rumble --color red 2>&1", 1)
    assert_match "end must exceed start",
                 shell_output("#{bin}/dsmactools --feedback triggers --effect weapon --start 5 --end 3 2>&1", 1)
    assert_match "Only Sony DualSense and DualSense Edge",
                 shell_output("#{bin}/dsmactools --feedback rumble --pid 0x1234 2>&1", 1)
    assert_match "Use a color name",
                 shell_output("#{bin}/dsmactools --feedback lightbar --color notacolor 2>&1", 2)
    assert_match "needs a terminal", shell_output("#{bin}/dsmactools --interactive 2>&1", 1)
  end
end
