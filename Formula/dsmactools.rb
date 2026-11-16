class Dsmactools < Formula
  desc "Controller workbench for Mac game developers"
  homepage "https://github.com/olliejudge/dsmactools"
  url "https://github.com/olliejudge/dsmactools/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "3b9740defd6106927b5ea275fa514fc86f8ab7ae84261379de8ed4be83891642"
  license "MIT"

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
