class Libfabric < Formula
  desc "OpenFabrics libfabric"
  homepage "https://ofiwg.github.io/libfabric/"
  url "https://github.com/ofiwg/libfabric/releases/download/v1.7.0/libfabric-1.7.0.tar.bz2"
  sha256 "b3dd9cc0fa36fe8c3b9997ba279ec831a905704816c25fe3c4c09fc7eeceaac4"
  head "https://github.com/ofiwg/libfabric.git"

  bottle do
    sha256 "011527580e0bb34a0c374704b245406619ffbad08bbaf24d871c35a7574f9094" => :mojave
    sha256 "7cf9f040235c4a97f2d1b5e1018ed16fc061c0eb139e0ac0fa6d4b24d4ad3ceb" => :high_sierra
    sha256 "68bb847a11e31c2798118dbd096046e29bbb5ee76051a4b1988b01656dd9b836" => :sierra
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool"  => :build

  def install
    system "autoreconf", "-fiv"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#(bin}/fi_info"
  end
end
