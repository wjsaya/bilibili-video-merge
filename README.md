
-------------------------
bilibili video merge
--
>bilibili下载后的视频是blv格式（实际是flv？），将其合并、转换为mp4

起因
--
bilibili客户端可以下载视频后观看，但是于个人而言还是有很多问题，比如``只支持1.5倍加速（曾经）``，比如稍大的视频都是分多个文件，目录结构混乱难管理等等。。。说人话就是我闲的无聊。

曾经尝试写了一个安卓端的合并导出软件，但是作为一个安卓&java初学者，花了很多不必要的时间在界面美化、图片加载、列表ListView展示，自定义控件等无关事宜上，核心的视频合并功能却没有做。最终兴趣全无，项目无疾而终。等以后有心情有空闲了再搞吧。说到界面，我当初模仿的那一版bilibili界面到现在已经改版三次了。。。

前天手机内存已爆，bilibili已经下载了接近80个G。。。于是乎，全部导出到电脑，先暂时用电脑合并吧，而且暂时只合并合集视频，单个视频现在懒得弄，反正现在用不上，以后要用了再说

使用&说明
--
emm...目前这个脚本是linux版本的，尝试过用windows写脚本，但是对cmd实在无爱，写的想哭。刚好现在win10里的linux子系统可以用了，遇事直接linux下shell走起吧~使用方法：
```shell
bash bilibili_video_merge.sh
# 或者
chmod a+x bilibili_video_merge.sh && ./bilibili_video_merge.sh
```

脚本很简单，就是一个合并操作，后面可以使用ffmpeg把blv转换为mp4，但是blv实际也是可以放的，而且ffmpeg还要单独安装，放在脚本里不太合适，索性注释了，又不是不能用。。。

目录结构
--
```shell
# 结构大致如下
├── 36210854
├── bilibili_video_merge.sh
├── merged
└── readme.md
```
数字文件夹是av编号的缓存视频，
安卓手机下载位置：存储卡根目录/Android/data/tv.danmaku.bili/download，结构如下图：
![bilibili_video_merge_01](https://raw.githubusercontent.com/wjsaya/BlogPictures/master/bilibili_video_merge_01.png)
直接把这里的文件夹弄到电脑上就好，和bilibili_video_merge.sh放在同一屋檐（同一目录）下。

执行脚本后，有两个选项：

1，脚本会检查目录是否存在，存在就执行合并并输出合并进度，如果目录不存在，那么直接提示不存在并返回。如下图：
![bilibili_video_merge_02](https://raw.githubusercontent.com/wjsaya/BlogPictures/master/bilibili_video_merge_02.png)

2，脚本会遍历当前目录下的所有纯数字文件夹并按照特定的目录格式找文件进行转换，因此在这个目录下请不要自己新建其他的纯数字文件夹。

当转换完毕，脚本会提示转换完毕，此时就可以去脚本目录下的merged下找转换后的文件了，这里面的文件名已经转换。

TODO list
--
功能点|状态
---|---
单个视频单文件导出|todo
单个视频分文件合并导出|todo
分p合集视频单文件导出|done
分p合集视频多文件导出|done
多线程处理|TODO




