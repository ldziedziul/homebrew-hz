class HazelcastAT51Snapshot < Formula
    desc "Hazelcast is a streaming and memory-first application platform for fast, stateful, data-intensive workloads on-premises, at the edge or as a fully managed cloud service."
    homepage "https://github.com/hazelcast/hazelcast-command-line"
    url "https://oss.sonatype.org/content/repositories/snapshots/com/hazelcast/hazelcast-distribution/5.1-SNAPSHOT/hazelcast-distribution-5.1-20220218.103948-408.tar.gz"
    sha256 "d1e04800b650015e9672f8d5f57b6835a8704fb6617aad67c40d77733f92105b"
    conflicts_with "hazelcast-enterprise"
  
    depends_on "openjdk" => :recommended

    def install
      libexec.install Dir["*"]
      Dir["#{libexec}/bin/hz*"].each do |path|
        executable_name = File.basename(path)
        if executable_name.end_with? ".bat"
          next
        end
        (bin/executable_name).write_env_script libexec/"bin/#{executable_name}", Language::Java.overridable_java_home_env
      end
      prefix.install_metafiles
      inreplace libexec/"lib/hazelcast-download.properties", "hazelcastDownloadId=distribution", "hazelcastDownloadId=brew"
    end
  
    def post_install
      exec "echo Hazelcast has been installed."
    end

  end
