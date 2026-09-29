class Dsmactools < Formula
  desc "Controller workbench for Mac game developers"
  homepage "https://github.com/olliejudge/dsmactools"
  url "https://github.com/olliejudge/dsmactools/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "254e4207d99b7410c6f6b4f84ab23b631c782b3a68b4799e6984550c4f9717a9"
  license "MIT"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "dsmactools #{version}", shell_output("#{bin}/dsmactools --version")
    assert_match "DS Mac Tools", shell_output("#{bin}/dsmactools --help")
    assert_match "needs a terminal", shell_output("#{bin}/dsmactools --interactive", 1)
  end
end
