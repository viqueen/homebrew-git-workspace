require "language/node"

class GitDevbox < Formula
  desc "Collection of useful git extensions that enhance one's local dev environment"
  homepage "https://github.com/viqueen/git-devbox"
  url "https://registry.npmjs.org/git-devbox/-/git-devbox-3.4.0.tgz"
  sha256 "d8e8ffe63c971a9fe29715b4ca890744dff5e491b68b6a598f9e1b8a1fc2fc6a"
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
