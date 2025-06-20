import { router } from '@kit.ArkUI';

@Component
export default struct Sidebar {
  @State isShow: boolean = true;  // 控制侧边栏显示状态
  @State isNavigating: boolean = false; // 标记是否正在进行路由跳转

  // 路由跳转函数 - 跳转到标准计算器页面
  navigateToStandard() {
    this.prepareNavigation();
    router.pushUrl({ url: 'pages/StandardCalculator' });
  }

  // 路由跳转函数 - 跳转到长度转换器页面
  navigateToLengthConverter() {
    this.prepareNavigation();
    router.pushUrl({ url: 'pages/LengthConverter' });
  }

  // 准备导航 - 在路由跳转前执行
  prepareNavigation() {
    this.isNavigating = true;
    this.isShow = false; // 立即隐藏侧边栏
  }

  build() {
    Column() {
      // 仅在isShow为true时渲染侧边栏
      if (this.isShow) {
        Column() {
          Text('计算器')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 20, bottom: 10 })
            .width('100%')
            .textAlign(TextAlign.Start);

          Button('标准')
            .width('100%')
            .height(50)
            .borderRadius(0)
            .onClick(() => {
              this.navigateToStandard();
            });

          Blank().height(20);

          Text('转换器')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 10, bottom: 10 })
            .width('100%')
            .textAlign(TextAlign.Start);

          Button('长度')
            .width('100%')
            .height(50)
            .borderRadius(0)
            .onClick(() => {
              this.navigateToLengthConverter();
            });
        }
        .width('50%') // 侧边栏宽度设置为50%
        .height('100%')
        .backgroundColor('#f0f0f0')
        .position({ x: 0 }) // 固定位置在左侧
        .zIndex(100) // 确保侧边栏在主页面上方
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('transparent');
  }
}