# flutter-image-preview
### 初衷
在实际APP开发中，图片预览是必不可少的组件，通过photo_view来进行封装，以此分享

### 使用方法
* 先把preview.dart拷贝到自己的公共组件目录中
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

### 效果

![1](https://user-images.githubusercontent.com/49790909/149075095-125f7a96-ced2-4ba7-a3ed-4805e9d2fda7.jpg)
![2](https://user-images.githubusercontent.com/49790909/149075127-c211468e-920e-49d2-9887-281c535333a8.jpg)
![3](https://user-images.githubusercontent.com/49790909/149075139-e79b296b-cf5d-4810-9ee6-ebb1ed90be62.jpg)


