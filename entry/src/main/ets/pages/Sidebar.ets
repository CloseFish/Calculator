import { router } from '@kit.ArkUI';

@Component
export default struct Sidebar {
  @Link isShow: boolean;

  build() {
    if (this.isShow) {
      Column() {
        Text('计算器')
          .fontSize(20)
          .padding({ left: 15, top: 20, bottom: 10 })
          .width('100%')
          .textAlign(TextAlign.Start);

        Button('标准')
          .onClick(() => {
            this.isShow = false;
            console.info('[路由] 尝试跳转到标准计算器页面');

            router.pushUrl({ url: 'pages/StandardCalculator' })
              .then(() => {
                console.info('[路由] ✅ 成功跳转到标准计算器页面');
              })
              .catch((error: Error) => { // 明确指定错误类型为 Error
                console.error('[路由] ❌ 跳转到标准计算器失败:', error);
              });
          })
          .width('100%')
          .height(50)
          .backgroundColor('#f0f0f0');

        Text('转换器')
          .fontSize(20)
          .padding({ left: 15, top: 20, bottom: 10 })
          .width('100%')
          .textAlign(TextAlign.Start);

        Button('长度')
          .onClick(() => {
            this.isShow = false;
            console.info('[路由] 尝试跳转到长度转换器页面');

            router.pushUrl({ url: 'pages/LengthConverter' })
              .then(() => {
                console.info('[路由] ✅ 成功跳转到长度转换器页面');
              })
              .catch((error: Error) => { // 明确指定错误类型为 Error
                console.error('[路由] ❌ 跳转到长度转换器失败:', error);
              });
          })
          .width('100%')
          .height(50)
          .backgroundColor('#f0f0f0');

        Button('重量')
          .onClick(() => {
            this.isShow = false;
            console.info('[路由] 尝试跳转到重量转换器页面');

            router.pushUrl({ url: 'pages/WeightConverter' })
              .then(() => {
                console.info('[路由] ✅ 成功跳转到重量转换器页面');
              })
              .catch((error: Error) => { // 明确指定错误类型为 Error
                console.error('[路由] ❌ 跳转到重量转换器失败:', error);
              });
          })
          .width('100%')
          .height(50)
          .backgroundColor('#f0f0f0');
      }
      .width('50%')
      .height('100%')
      .backgroundColor('#f0f0f0');
    }
  }
}