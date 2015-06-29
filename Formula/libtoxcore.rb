require 'formula'

class Libtoxcore < Formula
  head "git://github.com/irungentoo/toxcore", :using => :git
  homepage "https://tox.chat"

  depends_on "libsodium"

  # Following dependencies are only required in build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "check" => :build
  depends_on "pkg-config" => :build

  depends_on "libconfig" if build.with? "daemon"

  depends_on "opus" unless build.include? "without-av"
  depends_on "libvpx" unless build.include? "without-av"

  option "with-testing", "Compile contents of testing/ folder (usually broken)"
  option "without-av", "Compile without A/V support"
  option "with-daemon", "Builds the bootstrap server daemon"

  def install
    args = []
    args << "--disable-av" if build.include? "without-av"
    args << "--enable-daemon" if build.with? "daemon"
    args << "--disable-testing" if !build.with? "testing"

    ENV["LDFLAGS"] = "-mmacosx-version-min=10.6"
    ENV["CFLAGS"] = "-mmacosx-version-min=10.6"
    system "autoreconf", "-if"
    system "./configure", "--prefix=#{prefix}", *args
    system "make"
    system "make", "install"
  end

  def caveats
    <<-EOF.undent
    libtoxcore has no UI. If you want to make use of it, try Toxic for a CLI:
      brew install --HEAD toxic
    or uTox for a GUI (X11):
      brew install --HEAD utox
    EOF
  end
end
