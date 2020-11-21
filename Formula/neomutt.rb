class Neomutt < Formula
  desc "E-mail reader with support for Notmuch, NNTP and much more"
  homepage "https://neomutt.org/"
  url "https://github.com/neomutt/neomutt/archive/20201120.tar.gz"
  sha256 "48191d4f17cb1e5fd094ca92c581e1bb9599f058c122cc0e35df4e1c0cb53f47"
  license "GPL-2.0-or-later"
  head "https://github.com/neomutt/neomutt.git"

  bottle do
    sha256 "5c4977430b85cd9123c671bd8f70d34579730187f927a6e13112ec8727e04b49" => :big_sur
    sha256 "bb9829de2249a318f926a8f435ece8731f1534c58fb0256ca34409bbb22c42fe" => :catalina
    sha256 "79dff03b1a3485f63c0d2affd5327d70246e72707a0c66830ff871a591bb8300" => :mojave
    sha256 "a5fb829bdcf7cdc5925339fe37bdcdfbd1f4fdbb9d000b73592fe75c5d00ee53" => :high_sierra
  end

  depends_on "docbook-xsl" => :build
  depends_on "gettext"
  depends_on "gpgme"
  depends_on "libidn"
  depends_on "lmdb"
  depends_on "lua"
  depends_on "notmuch"
  depends_on "openssl@1.1"
  depends_on "tokyo-cabinet"

  def install
    ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"
    system "./configure", "--prefix=#{prefix}",
                          "--enable-gpgme",
                          "--with-gpgme=#{Formula["gpgme"].opt_prefix}",
                          "--gss",
                          "--lmdb",
                          "--notmuch",
                          "--sasl",
                          "--tokyocabinet",
                          "--with-ssl=#{Formula["openssl@1.1"].opt_prefix}",
                          "--with-ui=ncurses",
                          "--lua",
                          "--with-lua=#{Formula["lua"].prefix}"
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/neomutt -F /dev/null -Q debug_level")
    assert_equal "set debug_level = 0", output.chomp
  end
end
