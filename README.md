<h2><b>关于osapp2dmg</b></h2>
<p>此脚本能够很方便的使用由Itunes下载的Mac OS安装APP制作一个dmg系统安装镜像。</p>
<h3><b>支持版本</b></h3>
<p>Mac OS X 10.9及以上版本</p>
<p>macOS 10.12及以上版本</p>
<h3><b>使用方法</b></h3>
<p>第一步：下载脚本</p>
<p><code>wget https://github.com/hitechbeijing/osapp2dmg/raw/master/osapp2dmg.sh</code></p>
<p>直接用浏览器下载也可以</p>
<p>第二步：安装Xcode命令行工具（如已安装，这一步可以省略）</p>
<p><code>xcode-select --install</code></p>
<p>第三步：执行脚本</p>
<p><code>sudo osapp2dmg.sh</code></p>
<p>直接把脚本拖进终端以root权限执行即可</p>
<p>注意：执行脚本前请确保没有dmg被挂载在/Volumes路径下</p>
<p><code>Please enter the OSAPP location -></code></p>
<p>这里直接把Itunes下载的app拖进终端即可</p>
<p><code>Please enter the OSAPP version, ep:Sierra -></code></p>
<p>这里输入系统的版本名称，作为最后输出dmg的文件名，注意名称需符合w3c命名标准，即两个字符之间不能有空格，请用下划线_代替</p>
<p><code>Please enter the volume name, ep: Install macOS Sierra - ></code></p>
<p>这里输入卷名，也就是开机按住Option出现在启动菜单的启动盘名称</p>
<p>再输入完以上参数后稍等一会(试机器CPU速度而异)，桌面上就会生成刚才制作的dmg文件</p>
<h3><b>DMG镜像下载</b></h3>
<p>如果不想自己制作，可以下载已经制作好的DMG镜像</p>
<p>链接: https://pan.baidu.com/s/1jHW6mqi 密码: 8tcm</p>
<p>文件这么大，当然不能放github</p>
<p>每个文件都有校验信息，避免下载出错</p>
