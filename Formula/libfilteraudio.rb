class Libfilteraudio < Formula
  desc "An easy to use audio filtering library made from webrtc code"
  homepage "https://github.com/irungentoo/filter_audio"
  head "git://github.com/irungentoo/filter_audio"

  def install
    ENV["CFLAGS"] = "-mmacosx-version-min=10.6"
    ENV["LDFLAGS"] = "-mmacosx-version-min=10.6"
    system "make", "install", "PREFIX=#{prefix}"
  end
end
