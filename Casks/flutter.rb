cask 'flutter' do
    name "Flutter SDK"
    homepage "https://flutter.dev/"

    version '1.20.4'
    sha256 "08fcbcc9c902bc6f245d660b6d68f1da420fbdd5878902b5687961a5fb43e9f7"

    url "https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_#{version}-stable.zip"

    binary "flutter/bin/dart"
    binary 'flutter/bin/flutter'
    
    auto_updates true
    depends_on macos: ">= :catalina"

    # https://github.com/MiderWong/homebrew-flutter/blob/master/Formula/flutter.rb#L19-L29
    def preflight
        current_ip = `curl http://api.db-ip.com/v2/free/self/ipAddress`
        ip_address_url = 'http://api.db-ip.com/v2/free/'.concat(current_ip)
        ip_address = `curl #{ip_address_url}`
        ip_address_hash = JSON.parse ip_address
        country_code = ip_address_hash["countryCode"]

        if (country_code == "CN")
            opoo "You are located in China"
            ENV["PUB_HOSTED_URL"] = "https://pub.flutter-io.cn"
            ENV["FLUTTER_STORAGE_BASE_URL"] = "https://storage.flutter-io.cn"
        end
    end

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
