class Sqlshell < Formula
  desc "This is the control CLI for Splice Machine databases on Kubernetes"
  homepage "https://github.com/splicemachine/homebrew-utility"
  url "https://splice-releases.s3.amazonaws.com/3.0.0.1960/cluster/sqlshell/sqlshell-3.0.0.1960.tar.gz"
  sha256 "a7a8b999a69f1e75c80239e2786ff7eb8d6faddd76ffc0ffe4f07cf32880d2a7"
  version "3.0.0.1960"
  revision 18

  depends_on "coreutils"

  def install
    File.write "sqlshell.patch", <<~EOS
      --- sqlshell.sh.orig	2020-09-30 23:54:45.000000000 -0500
      +++ sqlshell.sh	2020-10-01 00:02:55.000000000 -0500
      @@ -153,14 +153,24 @@
       SPLICE_LIB_DIR="##SPLICELIBDIR##"

       if [[ "$SPLICE_LIB_DIR" == *"##"* ]]; then
      -   CURDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
      -
      -   # ends in bin, go up and over to lib
      -   if [[ "$CURDIR" = *"bin" ]]; then
      -      SPLICE_LIB_DIR="${CURDIR}/../lib"
      -   else #subdir
      -      SPLICE_LIB_DIR="${CURDIR}/lib"
      -   fi
      +   SYMLINK_TARGET_DIR=$(dirname $(realpath $0))
      +   if [[ -z ${SYMLINK_TARGET_DIR} ]]; then
      +      CURDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
      +
      +      # ends in bin, go up and over to lib
      +      if [[ "$CURDIR" = *"bin" ]]; then
      +         SPLICE_LIB_DIR="${CURDIR}/../lib"
      +      else #subdir
      +         SPLICE_LIB_DIR="${CURDIR}/lib"
      +      fi
      +   else
      +      # ends in bin, go up and over to lib
      +      if [[ "${SYMLINK_TARGET_DIR}" = *"bin" ]]; then
      +         SPLICE_LIB_DIR="${SYMLINK_TARGET_DIR}/../lib"
      +      else #subdir
      +         SPLICE_LIB_DIR="${SYMLINK_TARGET_DIR}/lib"
      +      fi
      +  fi
       fi

       #check if all the tools needed to connect are found
    EOS

    system "patch sqlshell.sh sqlshell.patch"
    bin.install "sqlshell.sh"
    lib.install Dir["lib/*.*"]
  end

def caveats; <<~EOS
    Rather than force a cask dependency for Java8 that you may not need,
    we will allow the sqlshell.sh script to detect and warn if your Java
    is not found, or doesn't meet the requirements.

    "brew cask install homebrew/cask-versions/java8" will satisfy the
    Java JVM requirement to run sqlshell.
  EOS
  end

end
