import { router } from '@kit.ArkUI';

@Entry
@Component
export default struct Sidebar {
  @State isShow: boolean = false;

  // 路由跳转函数
  navigateToStandard() {
    router.pushUrl({ url: 'pages/StandardCalculator' });
    this.isShow = false; // 跳转后隐藏侧边栏
  }

  // 切换侧边栏显示状态
  toggleSidebar() {
    this.isShow = !this.isShow;
  }

  build() {
    Column() {
      // 主界面内容
      Row() {
        Button('打开侧边栏')
          .onClick(() => {
            this.toggleSidebar();
          });
        Text('主界面内容')
          .fontSize(24);
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center);

      // 侧边栏内容
      Column() {
        // 计算器部分
        Text('计算器')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20, bottom: 10 })
          .width('100%')
          .textAlign(TextAlign.Start);

        Button('标准')
          .width('100%')
          .onClick(() => {
            this.navigateToStandard();
          });

        // 添加间距
        Blank()
          .height(20);

        // 转换器部分
        Text('转换器')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 10, bottom: 10 })
          .width('100%')
          .textAlign(TextAlign.Start);

        Button('长度')
          .width('100%');
      }
      .width('50%')
      .height('100%')
      .backgroundColor('#f0f0f0')
      .position({ x: this.isShow ? 0 : -1000 }) // 使用固定值确保侧边栏完全隐藏
      .zIndex(1000); // 确保侧边栏在最上层
    }
    .width('100%')
    .height('100%')
    .backgroundColor('transparent');
  }
}
