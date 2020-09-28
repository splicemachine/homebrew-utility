class Sqlshell < Formula
  desc "This is the control CLI for Splice Machine databases on Kubernetes"
  homepage "https://github.com/splicemaahs/homebrew-utility"
  url "https://splice-releases.s3.amazonaws.com/3.0.0.1960/cluster/sqlshell/sqlshell-3.0.0.1960.tar.gz"
  sha256 "a7a8b999a69f1e75c80239e2786ff7eb8d6faddd76ffc0ffe4f07cf32880d2a7"
  version "3.0.0.1960"
  revision 1

  def install
    bin.install "sqlshell/sqlshell.sh"
  end

def caveats; <<~EOS
    Rather than force a cask depencency for Java8 that you may not need,
    we will allow the sqlshell.sh script to detect and warn if your Java
    is not found, or doesn't meet the requirements.

    "brew cask install homebrew/cask-versions/java8" will satisfy the
    Java JVM requirement to run sqlshell.
  EOS
  end

end
