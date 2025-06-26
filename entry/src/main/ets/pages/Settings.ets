import { router } from '@kit.ArkUI';

@Entry
@Component
struct Settings {
  @State theme: 'light' | 'dark' | 'system' = 'system';
  @State isExpanded: boolean = false;

  build() {
    Column({ space: 16 }) {
      // 返回栏
      Row() {
        Button('←').onClick(() => router.back())
          .width(40).height(40).backgroundColor('#4CAF50')
        Text('设置').fontSize(20).margin({ left: 10 })
      }.width('100%')

      // 外观设置
      Text('外观')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .align(Alignment.Start) // 左对齐
        .margin({ top: 10, bottom: 4 })
        .width('90%')
      Column() {
        // 标题行
        Row({ space: 16 }) {
          Column({ space: 4 }) {
            Text('应用程序主题')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .align(Alignment.Start) // 左对齐
              .width('70%')
            Text('选择要显示的应用主题')
              .fontSize(12)
              .fontColor('#888')
              .align(Alignment.Start) // 左对齐
              .width('70%')
          }
          Image(this.isExpanded ? 'arrow_up' : 'arrow_down')
            .width(20).height(20)
            .onClick(() => this.isExpanded = !this.isExpanded)
        }
        .padding({ top: 10, bottom: 10 })
        .backgroundColor('#F5F5F5')
        .borderRadius(4)
        .onClick(() => this.isExpanded = !this.isExpanded)

        // 展开内容（左对齐）
        if (this.isExpanded) {
          Column({ space: 12 }) {
            this.buildRadio('浅色', 'light')
            this.buildRadio('深色', 'dark')
            this.buildRadio('使用系统设置', 'system')
          }
          .padding({ left: 24, top: 8, bottom: 16 })
          .backgroundColor('#F5F5F5')
          .borderRadius(4)
          .alignItems(HorizontalAlign.Start) // 强制左对齐
        }
      }
    }
    .padding(20)
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF');
  }

  @Builder
  buildRadio(label: string, value: 'light' | 'dark' | 'system') {
    Row({ space: 8 }) {
      Radio({ value, group: 'theme' })
        .checked(this.theme === value)
        .onChange(isChecked => {
          if (isChecked) this.theme = value;
        })
      Text(label).fontSize(14)
    }
    .alignItems(VerticalAlign.Center)
    .width('80%')
  }
}