cask 'flutter' do
    name "Flutter SDK"
    homepage "https://flutter.dev/"

    version :latest

    if OS.mac?
        url "https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_v1.12.13+hotfix.5-stable.zip"
        sha256 "78a0c5a757df74800e3c11632d4b8d2818904f0ceb075d9a2ab44ee74af6e67c"
    elsif OS.linux?
        url "https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.12.13+hotfix.5-stable.tar.xz"
        sha256 "d792c92895623da35e1a9ccd8bc2fe84c81dd72c2c54073f56fe70625866d800"
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
