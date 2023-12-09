#!/bin/bash
cd coredns
git checkout .
git clean -dfx .
git pull
cd ../dnsredir
git pull
cd ../coredns_custom_build
git pull
cd ../coredns
git apply ../coredns_custom_build/forward.go.patch
git apply ../coredns_custom_build/forward-setup.go.patch
sed -i.bak 's|forward:forward|alternate:github.com/coredns/alternate\ndnsredir:github.com/leiless/dnsredir\nforward:forward\nproxy:github.com/missdeer/proxy\nhttps:github.com/v-byte-cpu/coredns-https|g' plugin.cfg
sed -i.bak 's|cache:cache|cache:cache\nmeshname:github.com/zhoreeq/coredns-meshname\nmeship:github.com/zhoreeq/coredns-meship\nens:github.com/wealdtech/coredns-ens\nwgsd:github.com/jwhited/wgsd\nredisc:github.com/missdeer/redis|g' plugin.cfg
echo "replace (" >> go.mod
echo "    github.com/leiless/dnsredir => ../dnsredir" >> go.mod
echo ")" >> go.mod
sed -i.bak '/azure/d' plugin.cfg
sed -i.bak '/route53/d' plugin.cfg
sed -i.bak '/trace/d' plugin.cfg
sed -i.bak '/etcd/d' plugin.cfg
sed -i.bak '/clouddns/d' plugin.cfg
sed -i.bak '/k8s_external/d' plugin.cfg
sed -i.bak '/kubernetes/d' plugin.cfg
sed -i.bak '/geoip/d' plugin.cfg
sed -i.bak '/nsid/d' plugin.cfg
sed -i.bak '/debug/d' plugin.cfg
sed -i.bak '/autopath/d' plugin.cfg
sed -i.bak '/erratic/d' plugin.cfg
sed -i.bak '/metadata/d' plugin.cfg
sed -i.bak '/cancel/d' plugin.cfg
sed -i.bak '/pprof/d' plugin.cfg
sed -i.bak '/dnstap/d' plugin.cfg
sed -i.bak '/dns64/d' plugin.cfg
sed -i.bak '/acl/d' plugin.cfg
sed -i.bak '/chaos/d' plugin.cfg
sed -i.bak '/dnssec/d' plugin.cfg
sed -i.bak '/secondary/d' plugin.cfg
sed -i.bak '/sign/d' plugin.cfg
