## QT4
$ Basic XLib functionality test failed!
$ apt-get install libx11-dev libxext-dev libxtst-dev cmake

$ WebKit Warning: -no-xrender
$ apt-get install libxrender-dev

## QT4 build
$ ./configure -release -nomake examples -no-iconv -no-opengl -no-assimp -no-qt3d-profile-jobs -no-qt3d-profile-gl -xplatform linux-arm-gnueabi-g++ -prefix /home/user/QtEnv/QtEmbedded-5.9.1-arm -opensource -confirm-license

$ ./configure -embedded arm -xplatform qws/linux-arm-g++ -depths 4,8,12,16 -no-qt3support -no-qvfb -qt-mouse-tslib -prefix /home/lhc/Qt/output/qt-arm/ -qt-sql-sqlite -I/home/lhc/Qt/output/tslib/include -L/home/lhc/Qt/output/tslib/lib -no-rpath -no-largefile





# 修改configure gcc 3.4 那增加当前gcc 版本
```
 {命令行下g++ -dumpversion > 4，适用下列解决方法}：将下列代码中4*|3.4*)改为9*|8*|7*|6*|5*|4*|3.4*)

                    case "$XPLATFORM" in        
                         *-g++*)
                                 case "$(${QMAKE_CONF_COMPILER} -dumpversion)" in  #QMAKE_CONF_COMPILER=`getXQMakeConf QMAKE_CXX`
                                    4*|3.4*)
                                          ;;
                                      3.3*)
                                       canBuildWebKit="no"
                                       ;;
                                        *)
                                    canBuildWebKit="no"
                                    canBuildQtXmlPatterns="no"
                                      ;;
```

## 九宫图拉伸
```
border-image:url(:/images/backgroud.png) 10 10 10 10;
border-top: 10px transparent;
border-right: 10px transparent;
border-bottom: 10px transparent;
border-left: 10px transparent;
```

```
  setStyleSheet(
                   //正常状态样式
                   "QPushButton{"
                   "background-color:rgba(100,225,100,30);"//背景色（也可以设置图片）
                   "border-style:outset;"                  //边框样式（inset/outset）
                   "border-width:4px;"                     //边框宽度像素
                   "border-radius:10px;"                   //边框圆角半径像素
                   "border-color:rgba(255,255,255,30);"    //边框颜色
                   "font:bold 10px;"                       //字体，字体大小
                   "color:rgba(0,0,0,100);"                //字体颜色
                   "padding:6px;"                          //填衬
                   "}"
                   //鼠标按下样式
                   "QPushButton:pressed{"
                   "background-color:rgba(100,255,100,200);"
                   "border-color:rgba(255,255,255,30);"
                   "border-style:inset;"
                   "color:rgba(0,0,0,100);"
                   "}"
                   //鼠标悬停样式
                   "QPushButton:hover{"
                   "background-color:rgba(100,255,100,100);"
                   "border-color:rgba(255,255,255,200);"
                   "color:rgba(0,0,0,200);"
                   "}");
```
