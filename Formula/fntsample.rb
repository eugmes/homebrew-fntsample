class Fntsample < Formula
  desc "Program for making font samples"
  homepage "https://github.com/eugmes/fntsample"
  url "https://github.com/eugmes/fntsample/archive/release/5.3.tar.gz"
  sha256 "e4e8b50b0a5e984cfdaa32b7d133bd3bf0c62edb14f752f7df1190176023972b"

  head "https://github.com/eugmes/fntsample.git"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "cairo"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "gettext"
  depends_on "glib"
  depends_on "pango"

  resource "unicode-blocks" do
    url "https://unicode.org/Public/13.0.0/ucd/Blocks.txt"
    sha256 "81a82b6a9fcf1a9c12f588d7a1decd73a9afdc4cac95b0eb7e576e7942d6c19f"
  end

  def install
    resource("unicode-blocks").stage do
      buildpath.install "Blocks.txt"
    end

    mkdir "build" do
      system "cmake", "..", "-DUNICODE_BLOCKS=#{buildpath}/Blocks.txt", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    system "#{bin}/fntsample", "--help"
  end
end
