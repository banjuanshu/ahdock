# AHDock
AHDock is Mac OS X auto hide dock app.

#### AHDock是什么?
AHDock是一款让Mac OS X Dock 能根据窗口是否有遮挡Dock,而自动显示/隐藏的应用.

#### 教程

1. 下载脚本
2. 用Mac自代的脚本编辑器打开ahdock.scpt脚本
3. 选择文件->导出->填写名字->选择应用程序,然后导出.你得得到一个.app的应用.
4. 将应用copy到Applications中,然后打开,这时会打开"系统偏好设置"的安全管理项
5. 在"隐私"项里左侧选择"辅助功能",然后将"AHDock"选中
6. 在"系统偏好设置"里选择"用户与群组"->"登陆项",点击那个+号,找到AHDock应用.
7. 注销
8. 大功告成!


`在第3步时,你可以将生成的应用改成不在Dock中显示图标`
具体方法:
> 找到AHDock应用,右键"显示包内容", 找到Contents/Info.plist 增加：Application is agent (UIElement) ＝ YES


