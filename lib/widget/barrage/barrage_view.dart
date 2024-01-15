import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_craft/widget/barrage/barrage_config.dart';
import 'package:flutter_chat_craft/widget/barrage/barrage_item.dart';

import 'barrage_controller.dart';

class BarrageView extends StatefulWidget {
  const BarrageView({Key? key, required this.controller}) : super(key: key);

  final BarrageController controller;

  @override
  State<BarrageView> createState() => _BarrageViewState();
}

class _BarrageViewState extends State<BarrageView> {
  late BarrageController controller;

  @override
  void initState() {
    super.initState();
    widget.controller.setState = setState;
    controller = widget.controller;
  }

  // 构建全部的子弹
  List<Widget> buildAllBullet(BuildContext context) {
    return List.generate(controller.bullets.length,
        (index) => buildBulletToScreen(context, controller.bullets[index]));
  }

  // 构建子弹
  Widget buildBulletToScreen(BuildContext context, BarrageModel bulletModel) {
    BarrageItem bullet = BarrageItem(bulletModel.id, bulletModel.comment,
        color: bulletModel.color,);
    return Positioned(
      right: bulletModel.offsetX,
      top: bulletModel.offsetY + BarrageConfig.areaOfChildOffsetY,
      child: BarrageConfig.bulletTapCallBack == null
          ? bullet
          : GestureDetector(
              onTap: () => BarrageConfig.bulletTapCallBack!(bulletModel),
              child: bullet,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [...buildAllBullet(context)],
    );
  }
}
