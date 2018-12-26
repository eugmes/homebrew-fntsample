class Fntsample < Formula
  desc "Program for making font samples"
  homepage "https://github.com/eugmes/fntsample"
  url "https://github.com/eugmes/fntsample/archive/release/5.3.tar.gz"
  sha256 "e4e8b50b0a5e984cfdaa32b7d133bd3bf0c62edb14f752f7df1190176023972b"

  head "https://github.com/eugmes/fntsample.git"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "cairo"
  depends_on "pango"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "glib"

  resource "unicode-blocks" do
    url "https://unicode.org/Public/11.0.0/ucd/Blocks.txt"
    sha256 "0b457b66c788a97c8521e265f0b793d4ed911356d39eb61029f9cef8554cd052"
  end

  def install
    resource("unicode-blocks").stage do
      buildpath.install "Blocks.txt"
    end

    mkdir "build" do
      # setlocale is overridden by libintl for some reason without this hack... :/
      system "cmake", "..", "-DUNICODE_BLOCKS=#{buildpath}/Blocks.txt", "-DCMAKE_C_FLAGS=-DGNULIB_defined_setlocale", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    system "#{bin}/fntsample", "--help"
  end
end
