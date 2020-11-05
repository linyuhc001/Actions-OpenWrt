#!/bin/bash


# 安装额外依赖软件包
# sudo -E apt-get -y install rename

# 更新feeds文件
# sed -i 's@#src-git helloworld@src-git helloworld@g' feeds.conf.default #启用helloworld
# cat feeds.conf.default

# 更新并安装源
./scripts/feeds clean
./scripts/feeds update -a && ./scripts/feeds install -a

# 添加第三方软件包
# git clone https://github.com/kenzok8/openwrt-packages package/openwrt-packages
git clone https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-adguardhome
git clone https://github.com/tty228/luci-app-serverchan package/luci-app-serverchan
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus package/luci-app-jd-dailybonus
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
# git clone https://github.com/garypang13/luci-theme-edge package/luci-theme-edge -b 18.06

# 替换更新默认argon主题
rm -rf package/lean/luci-theme-argon && git clone https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon -b 18.06
git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

# 替换更新passwall和ssrplus+
# rm -rf package/openwrt-packages/luci-app-passwall && svn co https://github.com/xiaorouji/openwrt-package/trunk/lienol/luci-app-passwall package/openwrt-packages/luci-app-passwall
# rm -rf package/openwrt-packages/luci-app-ssr-plus && svn co https://github.com/fw876/helloworld package/openwrt-packages/helloworld

# 添加passwall依赖库
# git clone https://github.com/kenzok8/small package/small
# svn co https://github.com/xiaorouji/openwrt-package/trunk/package package/small

# 替换更新haproxy默认版本
# rm -rf feeds/packages/net/haproxy && svn co https://github.com/lienol/openwrt-packages/trunk/net/haproxy feeds/packages/net/haproxy

# 自定义定制选项
sed -i 's#192.168.1.1#192.168.3.105#g' package/base-files/files/bin/config_generate #定制默认IP
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings #取消系统默认密码
sed -i 's#0 6#0 2#g' package/lean/luci-app-adbyby-plus/root/etc/init.d/adbyby #修改adbyby自动更新时间到凌晨2点
sed -i 's#url-test#fallback#g' package/luci-app-openclash/root/usr/share/openclash/yml_proxys_set.sh #修改openclash自动生成配置中的urltest为fallback
# sed -i 's#option commit_interval 24h#option commit_interval 10m#g' feeds/packages/net/nlbwmon/files/nlbwmon.config #修改流量统计写入为10分钟
# sed -i 's#option database_directory /var/lib/nlbwmon#option database_directory /etc/config/nlbwmon_data#g' feeds/packages/net/nlbwmon/files/nlbwmon.config #修改流量统计数据存放默认位置
# sed -i 's@background-color: #e5effd@background-color: #f8fbfe@g' package/luci-theme-edge/htdocs/luci-static/edge/cascade.css #luci-theme-edge主题颜色微调
# sed -i 's#rgba(223, 56, 18, 0.04)#rgba(223, 56, 18, 0.02)#g' package/luci-theme-edge/htdocs/luci-static/edge/cascade.css #luci-theme-edge主题颜色微调

#创建自定义配置文件 - OpenWrt-x86-64

rm -f ./.config*
touch ./.config

#
# ========================固件定制部分========================
# 

# 
# 如果不对本区块做出任何编辑, 则生成默认配置固件. 
# 

# 以下为定制化固件选项和说明:
#

#
# 有些插件/选项是默认开启的, 如果想要关闭, 请参照以下示例进行编写:
# 
#          =========================================
#         |  # 取消编译VMware镜像:                   |
#         |  cat >> .config <<EOF                   |
#         |  # CONFIG_VMDK_IMAGES is not set        |
#         |  EOF                                    |
#          =========================================
#

# 
# 以下是一些提前准备好的一些插件选项.
# 直接取消注释相应代码块即可应用. 不要取消注释代码块上的汉字说明.
# 如果不需要代码块里的某一项配置, 只需要删除相应行.
#
# 如果需要其他插件, 请按照示例自行添加.
# 注意, 只需添加依赖链顶端的包. 如果你需要插件 A, 同时 A 依赖 B, 即只需要添加 A.
# 
# 无论你想要对固件进行怎
