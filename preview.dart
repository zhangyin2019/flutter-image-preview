import 'package:flutter/material.dart';
import 'package:kxy_party/common.dart';
import 'package:kxy_party/model/preview_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class _PreviewPage extends State<PreviewPage> {
  int _currentIndex = 0; // 当前序号

  late int _startTapTsp;
  final int longTapTsp = 500; // 长按毫秒数

  @override
  void initState() {
    super.initState();

    if (widget.startIndex != null) _currentIndex = widget.startIndex!;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Material(
          child: GestureDetector(
            onLongPress: () {
              widget.onLongTap!(_currentIndex);
            },
            child: PhotoViewGallery.builder(
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                    imageProvider:
                        NetworkImage(widget.imageUrlList[index].imgUrl),

                    // Hero承接
                    heroAttributes: PhotoViewHeroAttributes(
                        tag: widget.imageUrlList[index].id),

                    // 缩放最大最小
                    minScale: PhotoViewComputedScale.contained * 1.0,
                    maxScale: PhotoViewComputedScale.covered * 1.5,

                    // 按下事件
                    onTapDown: (BuildContext context, TapDownDetails details,
                        PhotoViewControllerValue controllerValue) {
                      _startTapTsp = DateTime.now().millisecondsSinceEpoch;

                      //
                    },

                    // 抬起事件
                    onTapUp: (
                      BuildContext context,
                      TapUpDetails details,
                      PhotoViewControllerValue controllerValue,
                    ) {
                      int nowTsp = DateTime.now().millisecondsSinceEpoch;

                      // 普通点击
                      if (nowTsp - _startTapTsp < longTapTsp) {
                        Navigator.pop(context);
                      }
                    }

                    //
                    );
              },

              // 拉动效果
              scrollPhysics: const ClampingScrollPhysics(),

              // 总数
              itemCount: widget.imageUrlList.length,

              // 初始序号
              pageController: PageController(initialPage: _currentIndex),

              // 加载图片效果
              loadingBuilder: (context, event) {
                return Container(
                  width: Common.w_20,
                  height: Common.h_20,
                  color: Common.col000,
                  child: const Center(
                      child: SizedBox(
                    width: Common.w_20,
                    height: Common.h_20,
                    child: CircularProgressIndicator(
                      strokeWidth: Common.w_2,
                      color: Common.colFFF,
                    ),
                  )),
                );
              },

              // 翻页变化
              onPageChanged: (int index) {
                _currentIndex = index;
              },

              //
            ),
          ),
        ),
        onWillPop: () async {
          Navigator.pop(context);
          return false;
        });
  }
}

class PreviewPage extends StatefulWidget {
  final List<PreviewEntity> imageUrlList; // 图片集合
  final int? startIndex; // 初始序号
  final Function(int index)? onLongTap;

  const PreviewPage(
      {Key? key, required this.imageUrlList, this.startIndex, this.onLongTap})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PreviewPage();
}
