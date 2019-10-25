cask 'flutter' do
    name "Flutter SDK"
    desc "Manage your Flutter app development."
    homepage "https://flutter.dev/"

    version :latest
    sha256 :no_check

    if OS.mac?
        url "https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_v1.9.1+hotfix.6-stable.zip"
    elsif OS.linux?
        url "https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.9.1+hotfix.6-stable.tar.xz"
    end

    binary 'flutter/bin/flutter'

    zap trash: '~/.flutter'
end
