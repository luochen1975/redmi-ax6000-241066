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

# ==========================================================
# 修复 distfeeds.conf 修改：改为在固件首次启动时执行
# 原因：新版 ImmortalWrt 的 distfeeds.conf 是编译时动态生成的，
#      构建阶段源码中不存在该文件，直接 sed 会报错。
# ==========================================================
mkdir -p files/etc/uci-defaults

cat > files/etc/uci-defaults/99-custom-feeds.sh << 'EOF'
#!/bin/sh
# 删除 passwall2 相关源
sed -i '/passwall2/d' /etc/opkg/distfeeds.conf
sed -i '/mirrors.vsean.net.*passwall/d' /etc/opkg/distfeeds.conf

# 阻止 opkg 升级核心系统包（防止覆盖 MTK 补丁）
sed -i '/base-files/d' /etc/opkg/distfeeds.conf
sed -i '/libubox/d' /etc/opkg/distfeeds.conf
sed -i '/libucode/d' /etc/opkg/distfeeds.conf
sed -i '/ucode/d' /etc/opkg/distfeeds.conf
sed -i '/jshn/d' /etc/opkg/distfeeds.conf
EOF

chmod +x files/etc/uci-defaults/99-custom-feeds.sh
