# flutter-image-preview
### 初衷
在实际APP开发中，图片预览是必不可少的组件，通过photo_view来进行封装，以此分享

### 使用方法
* pubspec.yaml中安装
```java
photo_view: ^0.13.0
```

* 使用的地方
注意：要达到微信图片预览的从小变大从图片位置直至满屏的效果，一定要加Hero
```dart
InkWell(
  child: Hero(
      tag: '$index',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Common.w_6),
        child: Image.network(
          widget.studyModel.imageList[index],
          fit: BoxFit.cover,
        ),
      )),
  onTap: () {
    List<PreviewEntity> list = [];

    for (int i = 0,
            len = widget.studyModel.imageList.length;
        i < len;
        i++) {
      list.add(PreviewEntity(
          id: '$i',
          imgUrl: widget.studyModel.imageList[i]));
    }

    // 图片预览
    Common.pushFromFade(
        context,
        PreviewPage(
          imageUrlList: list,
          startIndex: index,
          onLongTap: (int index) {
            Common.showSheet(context, ['分享', '保存相册'])
                .then((value) async {
              switch (value) {
                case '分享':
                  final path =
                      await Common.saveFileToAlbum(
                          list[index].imgUrl);
                  if (path == null) return;
                  Share.shareFiles([path]);
                  break;
                case '保存相册':
                  Common.saveFileToAlbum(
                      list[index].imgUrl);
                  break;
              }
            });
          },
        ));

    //
  },
)
```

* 核心代码
```dart
PreviewPage(
  imageUrlList: list,
  startIndex: index,
  onLongTap: (int index) {
    // TODO 长按触发的操作
  },
)
```

* 效果
