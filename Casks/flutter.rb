cask 'flutter' do
    name "Flutter SDK"
    homepage "https://flutter.dev/"

    version :latest
    
    if OS.mac?
        url "https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_v1.9.1+hotfix.6-stable.zip"
        sha256 "cbfa31d9bf5d4b1e5331301b607cfaf10aec7a4fa8dc4ad97b3fdc4eeba1c3f5"
    elsif OS.linux?
        url "https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.9.1+hotfix.6-stable.tar.xz"
        sha256 "a09831ba3d90f9dcdf866e341dc547d0b60062154e5ab66d64d97bba8b6d9331"
    end

    binary 'flutter/bin/flutter', target: "flutter"

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
