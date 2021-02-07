<details>
    <summary>
        <b>ssh.sh使用方法</b>
    </summary>

#### 切换到root
```shell
sudo -i
```
#### 修改密码

```shell
bash <(curl -sL https://sh.334433.xyz/ssh.sh)

or

curl -o ssh.sh -L https://sh.334433.xyz/ssh.sh && bash ssh.sh
```
默认密码是LinuxYes

#### 自定义密码(推荐)，将password替换成你要自定义的密码

```shell
bash <(curl -sL https://sh.334433.xyz/ssh.sh) password

or

curl -o ssh.sh -L https://sh.334433.xyz/ssh.sh && bash ssh.sh password
```

</details>

<details>
    <summary>
        <b>c.sh使用方法</b>
    </summary>

原链接: [Onekey_Caddy_PHP7_Sqlite3](https://github.com/dylanbai8/Onekey_Caddy_PHP7_Sqlite3)

> 仅修复了caddy无法安装和wordpress后面版本不支持的问题

### 一键安装 Caddy+PHP7+Sqlite3 环境
#### 1.解析好域名 2.执行以下命令
#### 3.提示：支持IPv6（AAAA记录）如果本地网络不支持IPv6可以通过cloudflareCDN转换为IP4
``` shell
wget -N --no-check-certificate https://raw.githubusercontent.com/eicky/Shell/master/c.sh && chmod +x c.sh && bash c.sh
```

#### 一键安装 typecho 博客
```
bash c.sh -t
```

#### 一键安装 wordpress 博客
```
bash c.sh -w
```

#### 一键安装 zblog 博客
```
bash c.sh -z
```

#### 一键安装 kodexplorer 可道云
```
bash c.sh -k
```

#### 一键安装 laverna 印象笔记
```
bash c.sh -l
```

#### 一键整站备份（一键打包/www目录 含数据库）
```
bash c.sh -a
```

#### 一键安装 v2ray 翻墙
```
bash c.sh -v
```

#### 一键安装 rinetd bbr 端口加速
```
bash c.sh -b
```

#### 一键卸载命令：
```
卸载 caddy
bash c.sh -unc

卸载 php+sqlite
bash c.sh -unp

卸载 v2ray
bash c.sh -unv

卸载 rinetdbbr
bash c.sh -unb
```

</details>


<details>
    <summary>
        <b>Linux DD 使用方法</b>
    </summary>

```shell
bash <(curl -sL https://sh.334433.xyz/dd.sh)

or

bash <(curl -sL https://cdn.jsdelivr.net/gh/eicky/Shell/DD/AutoReinstall.sh)
```

#### 如果需要efi引导，需要注释脚本中的 `sed -i '/force-efi-extra-removable/d' /tmp/InstallNET.sh` , DD `ubuntu 18.04`不能去掉,否则可能无法启动

</details>