require "language/node"

class GitDevbox < Formula
  desc "Collection of useful git extensions that enhance one's local dev environment"
  homepage "https://github.com/viqueen/git-devbox"
  url "https://registry.npmjs.org/git-devbox/-/git-devbox-3.2.1.tgz"
  sha256 "1bf65a7257f090524097d6d524c77e9a10b4d8ce74af5aaef1de027b5eaf31ac"
  license "Apache-2.0"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system "false"
  end
end
