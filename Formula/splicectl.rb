class Splicectl < Formula
  desc "This is the control CLI for Splice Machine databases on Kubernetes"
  homepage "https://github.com/splicemaahs/homebrew-utility"
  url "https://github.com/splicemaahs/homebrew-utility.git"
  version "0.0.16"
  revision 1

  if Hardware::CPU.is_32_bit?
    if OS.linux?
      def install
        bin.install "bin/linux/386/splicectl"
      end
    end
  else
    if OS.mac?
      def install
        bin.install "bin/darwin/amd64/splicectl"
      end
    elsif OS.linux?
      def install
        bin.install "bin/linux/amd64/splicectl"
      end
    end
  end

  def caveats; <<~EOS
    splicectl will look for the default ~/.kube/config configuration
    file for Kubernetes.  It will also look at KUBECONFIG environment
    variable to point to a specific Kubernetes config file.
  EOS
  end
end
