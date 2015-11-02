## Secken PAM Module

- 你需要安装 ssh server 和 pam 的开发库，具体请参见 dep.sh 。
- 运行 make init 会编译出 get_uid 程序。
- ./get_uid &lt;appid&gt; &lt; appkey &gt; 其中appid 是你在 Secken 添加的 app 对应的 appid，appkey 与此类似。
- get_uid 返回一个二维码的连接，在你最喜爱的浏览器中打开它，用洋葱客户端扫描。
- get_uid 程序会输出你的 uid。
- 运行 make && make install 将会把 pam_secken.so 安装到合适的位置。
- 编辑 /etc/pam.d/sshd 文件，在 auth required pam_secken.so 后面添加你的 appid, appkey 和 uid
    看起来像这样
```
auth required pam_secken.so abcdefghijklmnopqrstuvwxyz789012 theappkeyshouldkeepsecret ABCDEFGHIJK==
```
-- 支持多个uid验证，顺序验证，任何一个uid验证通过即验证通过。你需要这样配置。(使用,作为分隔符)
```
auth required pam_secken.so abcdefghijklmnopqrstuvwxyz789012 theappkeyshouldkeepsecret ABCDEFGHIJK==,KJHGFDSA==
```
- 再次 ssh 登录时，系统会像你的手机发送通知，请求允许登陆。
