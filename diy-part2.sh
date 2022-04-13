#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================
# 增加软件包
echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
#echo 'src-git vssr https://github.com/jerrykuku/luci-app-vssr' >>feeds.conf.default
#echo 'src-git bypass https://github.com/kiddin9/openwrt-bypass' >>feeds.conf.default
#sed -i '$a src-git small8 https://github.com/kenzok8/small-package' feeds.conf.default
#sed -i '$a src-git kiddin9 https://github.com/kiddin9/openwrt-packages' feeds.conf.default
sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
#sed -i '$a src-git infinityfreedom https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom' feeds.conf.default
 
# Define My Package
#git clone https://github.com/vernesong/OpenClash package/molun/luci-app-openclash
#git clone https://github.com/jerrykuku/luci-app-jd-dailybonus package/molun/luci-app-jd-dailybonus
#git clone https://github.com/rufengsuixing/luci-app-adguardhome package/molun/luci-app-adguardhome
#git clone https://github.com/sirpdboy/luci-theme-opentopd package/molun/luci-theme-opentopd
#git clone https://github.com/zzsj0928/luci-app-pushbot package/molun/luci-app-pushbot
git clone -b 18.06 https://github.com/kiddin9/luci-theme-edge package/molun/luci-theme-edge

# 修改默认IP
#sed -i 's/192.168.1.1/10.32.0.1/g' package/base-files/files/bin/config_generate
# 修改网关
#sed -i 's/192.168.1.1/10.32.0.1/g' package/base-files/files/bin/config_generate

# 删除默认密码
#sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/lean/default-settings/files/zzz-default-settings

# 修改默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-edge/g' ./feeds/luci/collections/luci/Makefile

# 取消bootstrap为默认主题
#sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap

# 修改主机名称
#sed -i 's/OpenWrt/HIWIFI-B70/g' package/base-files/files/bin/config_generate

# 修改版本号
sed -i "s/OpenWrt /yuos-bit build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# 修改默认wifi名称ssid为tymishop
#sed -i 's/ssid=OpenWrt/ssid=Yuos_$(cat /sys/class/ieee80211/${dev}/macaddress|awk -F ":" '{print $5""$6 }'| tr a-z A-Z)/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#开启MU-MIMO
#sed -i 's/mu_beamformer=0/mu_beamformer=1/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#wifi加密方式，没有是none
#sed -i 's/encryption=none/encryption=psk2/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#wifi密码
#sed -i 's/key=15581822425/key=1234567890/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 删除软件包
rm -rf package/lean/luci-theme-argon

# Add kernel build user
[ -z $(grep "CONFIG_KERNEL_BUILD_USER=" .config) ] &&
    echo 'CONFIG_KERNEL_BUILD_USER="MOLUN"' >>.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_USER=\).*@\1$"MOLUN"@' .config

# Add kernel build domain
[ -z $(grep "CONFIG_KERNEL_BUILD_DOMAIN=" .config) ] &&
    echo 'CONFIG_KERNEL_BUILD_DOMAIN="GitHub Actions"' >>.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_DOMAIN=\).*@\1$"GitHub Actions"@' .config
