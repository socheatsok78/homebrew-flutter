cask 'flutter' do
    name "Flutter SDK"
    homepage "https://flutter.dev/"

    version :latest
    
    if OS.mac?
        url "https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_v1.9.1+hotfix.6-stable.zip"
        sha256 "8d0b3e217e45fbde64e117c5932ec5bd18ced0e8e8fba80a0fec95e38854bb6a"
    elsif OS.linux?
        url "https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.9.1+hotfix.6-stable.tar.xz"
        sha256 "b67f530cce561ed76c113921bace82daa6262944f912d177fbd1cc68029fd918"
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
