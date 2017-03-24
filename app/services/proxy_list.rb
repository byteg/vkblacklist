class ProxyList
  @@proxies = [
                {host: '82.146.58.164', port: 8888}, #firstvds, byte
                {host: '188.120.244.132', port: 8888}, #firstvds, byte
                {host: '188.120.242.79', port: 8888}, #firstvds, byte
                {host: '188.120.237.86', port: 8888}, #firstvds, byte
                #{host: '188.120.236.216', port: 8888}, #firstvds, bytecheg@gmail.com
                nil
              ]

  def self.any
    @@proxies.sample
  end

  def self.any_as_simple_string
    proxy = self.any
    proxy.nil? ? nil : "http://#{proxy[:host]}:#{proxy[:port]}"
  end

end
