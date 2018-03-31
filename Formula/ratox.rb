class Ratox < Formula
  desc "FIFO based tox client"
  homepage "https://ratox.2f30.org"
  url "https://dl.2f30.org/releases/ratox-0.2.1.tar.gz"
  sha256 "25ea4e7e286d23ca4fe99e0619c384fc6b371178e8877681b382d94dd958a9ba"
  head "git://git.2f30.org/ratox"

  depends_on "libtoxcore"

  patch do
    url "https://ratox.2f30.org/ratox-os_x.patch"
    sha256 "903e6ce03c6a32bbcf88083b6a7d86172566adb88ef6a2996c7a61c3b0f605e7"
  end

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end
end
