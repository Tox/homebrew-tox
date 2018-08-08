class Libfilteraudio < Formula
  desc "Easy to use audio filtering library made from webrtc code. Removes echoes"
  homepage "https://github.com/irungentoo/filter_audio"
  url "https://github.com/irungentoo/filter_audio/archive/v0.0.1.tar.gz"
  sha256 "fb135592c5133c3b4b664da18f988f58609db912f204059abe16277df044a366"
  head "git://github.com/irungentoo/filter_audio"

  def install
    ENV["CFLAGS"] = "-mmacosx-version-min=10.6"
    ENV["LDFLAGS"] = "-mmacosx-version-min=10.6"
    system "make", "install", "PREFIX=#{prefix}"
  end
end
