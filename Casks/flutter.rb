cask 'flutter' do
    name "Flutter SDK"
    homepage "https://flutter.dev/"

    version '2.0.3'
    sha256 :no_check

    url "https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_#{version}-stable.zip"

    auto_updates true
    depends_on macos: ">= :catalina"

    binary "flutter/bin/dart"
    binary 'flutter/bin/flutter'

    def postflight
        system "flutter doctor"
    end

    zap trash:  [
            '~/.flutter',
            '~/.devtools'
        ],
        rmdir:  [
            '~/.dart',
            '~/.dartServer',
            '~/.pub-cache'
        ]

    def caveats; <<~EOS
        Please note the path to the Flutter SDK:
            #{staged_path}
        EOS
    end
end
