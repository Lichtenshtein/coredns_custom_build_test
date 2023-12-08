#!/bin/bash
pwd
APPVEYOR_BUILD_FOLDER=../coredns_custom_build
cd ..
rm -rf fallback
git clone --depth=1 https://github.com/missdeer/fallback.git
cd fallback
pwd
go mod init github.com/missdeer/fallback
cd ..
rm -rf on
git clone --depth=1 github.com/coredns/caddy/onevent.git
cd on
pwd
go mod init github.com/coredns/caddy/onevent
cd ..
rm -rf meshname
git clone --depth=1 github.com/zhoreeq/coredns-meshname.git
cd meshname
pwd
go mod init github.com/zhoreeq/coredns-meshname
cd ..
rm -rf meship
git clone --depth=1 github.com/zhoreeq/coredns-meship.git
cd meship
pwd
go mod init github.com/zhoreeq/coredns-meship
cd ..
rm -rf ens
git clone --depth=1 github.com/wealdtech/coredns-ens.git
cd ens
pwd
go mod init github.com/wealdtech/coredns-ens
cd ..
rm -rf wgsd
git clone --depth=1 github.com/jwhited/wgsd.git
cd wgsd
pwd
go mod init github.com/jwhited/wgsd
cd ..
rm -rf redis
git clone --depth=1 https://github.com/missdeer/redis.git
cd redis
pwd
go mod init github.com/missdeer/redis
cd ..
rm -rf proxy
git clone --depth=1 https://github.com/missdeer/proxy.git
cd proxy
pwd
go mod init github.com/missdeer/proxy
cd ..
rm -rf ads
git clone --depth=1 https://github.com/missdeer/ads.git
cd ads
pwd
rm -f go.mod go.sum
go mod init github.com/missdeer/ads
cd ..
rm -rf dnsredir
git clone --depth=1 https://github.com/leiless/dnsredir.git
cd dnsredir
pwd
rm -f go.mod go.sum
go mod init github.com/leiless/dnsredir
cd ../coredns
pwd
git checkout .
git apply "$APPVEYOR_BUILD_FOLDER/forward.go.patch"
git apply "$APPVEYOR_BUILD_FOLDER/forward-setup.go.patch"
sed -i 's|forward:forward|fallback:github.com/missdeer/fallback\ndnsredir:github.com/leiless/dnsredir\nforward:forward\nproxy:github.com/missdeer/proxy|g' plugin.cfg
sed -i 's|hosts:hosts|ads:github.com/missdeer/ads\nhosts:hosts|g' plugin.cfg
sed -i 's|cache:cache|cache:cache\non:github.com/coredns/caddy/onevent\nmeshname:github.com/zhoreeq/coredns-meshname\nmeship:github.com/zhoreeq/coredns-meship\nens:github.com/wealdtech/coredns-ens\nwgsd:github.com/jwhited/wgsd\nredisc:github.com/missdeer/redis|g' plugin.cfg
sed -i 's|rewrite:rewrite|rewrite:rewrite\nbogus:github.com/missdeer/bogus\nipset:github.com/missdeer/ipset|g' plugin.cfg
echo "replace (" >> go.mod
echo "    github.com/missdeer/fallback => ../fallback" >> go.mod
echo "    github.com/missdeer/redis => ../redis" >> go.mod
echo "    github.com/missdeer/proxy => ../proxy" >> go.mod
echo "    github.com/missdeer/ads => ../ads" >> go.mod
echo "    github.com/leiless/dnsredir => ../dnsredir" >> go.mod
echo "    github.com/coredns/caddy/onevent => ../on" >> go.mod
echo "    github.com/zhoreeq/coredns-meshname => ../meshname" >> go.mod
echo "    github.com/zhoreeq/coredns-meship => ../meship" >> go.mod
echo "    github.com/wealdtech/coredns-ens => ../ens" >> go.mod
echo "    github.com/jwhited/wgsd => ../wgsd" >> go.mod
echo ")" >> go.mod
sed -i '/azure/d' plugin.cfg
sed -i '/route53/d' plugin.cfg
sed -i '/etcd/d' plugin.cfg
sed -i '/clouddns/d' plugin.cfg
sed -i '/k8s_external/d' plugin.cfg
sed -i '/kubernetes/d' plugin.cfg
sed -i '/chaos/d' plugin.cfg
sed -i '/dnstap/d' plugin.cfg
sed -i '/prometheus/d' plugin.cfg
sed -i '/geoip/d' plugin.cfg
