import { router } from '@kit.ArkUI';
import { ThemeConfig } from '../pages/config/theme.config'; // 确保路径正确
import { CustomRadio } from '../pages/CustomRadio'; // 导入独立组件

const GLOBAL_THEME_KEY = 'globalTheme';

@Entry
@Component
struct Settings {
  @State theme: 'light' | 'dark' | 'system' = 'system';
  @State isExpanded: boolean = false;

  // 初始化主题
  aboutToAppear() {
    const savedTheme = AppStorage.get<string>(GLOBAL_THEME_KEY);
    if (savedTheme === 'light' || savedTheme === 'dark' || savedTheme === 'system') {
      this.theme = savedTheme;
    }
  }

  build() {
    Column({ space: 16 }) {
      // 标题栏
      Row() {
        Button('←')
          .onClick(() => router.back())
          .width(40)
          .height(40)
          .backgroundColor(this.theme === 'dark' ? ThemeConfig.dark.buttonBg : ThemeConfig.light.buttonBg)
          .fontColor(this.theme === 'dark' ? ThemeConfig.dark.text : ThemeConfig.light.text)

        Text('设置')
          .fontSize(20)
          .margin({ left: 10 })
          .fontColor(this.theme === 'dark' ? ThemeConfig.dark.text : ThemeConfig.light.text)
      }
      .width('100%')

      // 外观设置区域
      Column() {
        // 主题标题
        Text('外观')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .align(Alignment.Start)
          .margin({ top: 10, bottom: 4 })
          .width('90%')
          .fontColor(this.theme === 'dark' ? ThemeConfig.dark.text : ThemeConfig.light.text)

        // 可折叠主题选项卡片
        Column() {
          // 卡片头部
          Row({ space: 16 }) {
            Column({ space: 4 }) {
              Text('应用程序主题')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.theme === 'dark' ? ThemeConfig.dark.text : ThemeConfig.light.text)

              Text('选择要显示的应用主题')
                .fontSize(12)
                .fontColor(this.theme === 'dark' ? '#AAAAAA' : '#666666')
            }
            .layoutWeight(1)

            Text(this.isExpanded ? '▲' : '▼')
              .fontSize(24)
              .fontColor(this.theme === 'dark' ? ThemeConfig.dark.text : ThemeConfig.light.text)
              .margin({ right: 8 })
          }
          .padding(10)
          .onClick(() => this.isExpanded = !this.isExpanded)

          // 展开后的选项
          if (this.isExpanded) {
            Column({ space: 8 }) {
              this.buildRadioOption('浅色模式', 'light')
              this.buildRadioOption('深色模式', 'dark')
              this.buildRadioOption('使用系统设置', 'system')
            }
            .padding({ left: 16, right: 16, bottom: 8 })
          }
        }
        .backgroundColor(this.theme === 'dark' ? ThemeConfig.dark.cardBg : ThemeConfig.light.cardBg)
        .borderRadius(8)
        .width('100%')
        .shadow(this.theme === 'dark' ?
          {
            radius: 8,
            color: '#000000',
            offsetX: 0,
            offsetY: 4
          } :
          {
            radius: 8,
            color: '#40000000',
            offsetX: 0,
            offsetY: 2
          }
        )
      }
      .width('100%')
    }
    .padding(20)
    .width('100%')
    .height('100%')
    .backgroundColor(this.theme === 'dark' ? ThemeConfig.dark.bg : ThemeConfig.light.bg)
    .onDisAppear(() => {
      AppStorage.setOrCreate(GLOBAL_THEME_KEY, this.theme);
    });
  }

  // 构建单选选项
  @Builder
  buildRadioOption(label: string, value: 'light' | 'dark' | 'system') {
    CustomRadio({
      label: label,
      value: value,
      selected: this.theme === value,
      theme: $theme // 双向绑定
    })
      .onClick(() => {
        this.theme = value;
        // 不需要额外操作，@Link会自动同步
      })
  }
}