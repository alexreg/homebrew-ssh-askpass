require "formula"

class SshAskpass < Formula
  homepage "https://github.com/theseal/ssh-askpass/"
  url "https://github.com/theseal/ssh-askpass/archive/v1.1.0.tar.gz"
  sha256 "fc3439f9573f8c348ab4b32323f14bec96d48dd080251ec5991d0cc6f8c7bf85"

  def install
    bin.install "ssh-askpass"
  end

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
                <key>Label</key>
                <string>#{plist_name}</string>
                <key>ProgramArguments</key>
                <array>
                        <string>/usr/bin/ssh-agent</string>
                        <string>-l</string>
                </array>
                <key>EnvironmentVariables</key>
                <dict>
                        <key>SSH_ASKPASS</key>
                        <string>#{opt_bin}/ssh-askpass</string>
                        <key>DISPLAY</key>
                        <string>0</string>
                </dict>
                <key>Sockets</key>
                <dict>
                        <key>Listeners</key>
                        <dict>
                                <key>SecureSocketWithKey</key>
                                <string>SSH_AUTH_SOCK</string>
                        </dict>
                </dict>
                <key>EnableTransactions</key>
                <true/>
        </dict>
        </plist>
    EOS
  end

  def caveats; <<-EOF.undent
    NOTE: After you have started the launchd service (read below) you need to log out and in (reboot might be easiest) before you can add keys to the agent with `ssh-add -c`.
    EOF
  end
end

