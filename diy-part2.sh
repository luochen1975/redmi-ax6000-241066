#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate
sed -i '/passwall2/d' /etc/opkg/distfeeds.conf
sed -i '/mirrors.vsean.net.*passwall/d' /etc/opkg/distfeeds.conf

# 阻止 opkg 升级核心系统包（防止覆盖 MTK 补丁）
sed -i '/base-files/d' /etc/opkg/distfeeds.conf
sed -i '/libubox/d' /etc/opkg/distfeeds.conf
sed -i '/libucode/d' /etc/opkg/distfeeds.conf
sed -i '/ucode/d' /etc/opkg/distfeeds.conf
sed -i '/jshn/d' /etc/opkg/distfeeds.conf
