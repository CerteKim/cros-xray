require 'package'

class xray < Package
    description 'A platform for building proxies to bypass network restriction.'
    homepage 'http://xtls.github.io/'
    version `curl -k -s https://api.github.com/repos/XTLS/Xray-core/releases | grep -m 1 "tag_name" | grep -o "v[0-9.]*"`
    license 'MPL'
    compatibility 'all'

    binary_url({
        aarch64: 'https://github.com/XTLS/Xray-core/releases/download/latest/Xray-linux-arm64-v8a.zip',
         armv7l: 'https://github.com/XTLS/Xray-core/releases/download/latest/Xray-linux-arm32-v7a.zip',
           i686: 'https://github.com/XTLS/Xray-core/releases/download/latest/Xray-linux-32.zip',
         x86_64: 'https://github.com/XTLS/Xray-core/releases/download/latest/Xray-linux-64.zip',
    })
    binary_sha256({
        aarch64: `curl -sL https://github.com/XTLS/Xray-core/releases/download/latest/Xray-android-arm64-v8a.zip.dgst | grep SHA256 | awk '{print $2}'`,
         armv7l: `curl -sL https://github.com/XTLS/Xray-core/releases/download/latest/Xray-android-arm32-v7a.zip.dgst | grep SHA256 | awk '{print $2}'`,
           i686: `curl -sL https://github.com/XTLS/Xray-core/releases/download/latest/Xray-linux-32.zip.dgst | grep SHA256 | awk '{print $2}'`,
         x86_64: `curl -sL https://github.com/XTLS/Xray-core/releases/download/latest/Xray-linux-64.zip.dgst | grep SHA256 | awk '{print $2}'`,
    })

    def self.install
        FileUtils.mkdir_p(CREW_DEST_PREFIX + '/share/xray')
        FileUtils.cp_r('.', CREW_DEST_PREFIX + '/share/xray')
        FileUtils.mkdir_p(CREW_DEST_PREFIX + '/bin')
        FileUtils.cd(CREW_DEST_PREFIX + '/bin') do
            FileUtils.ln_s(CREW_PREFIX + '/share/xray/xray', 'xray')
        end
    end

    def self.postinstall
        FileUtils.chmod('u=x, go=x', CREW_PREFIX + '/share/xray/xray')
        puts
        puts 'To start using xray, type `xray`.'.lightblue
        puts
        puts 'You can use customer config. about how to use xray command, see https://xtls.github.io/'.lightblue
        puts 'If you want to remove xray'.lightblue
        puts
        puts 'crew remove xray'.lightblue
        puts
    end

end