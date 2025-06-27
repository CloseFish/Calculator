import { CalculationHistory } from '../common/utils/types';

@Component
export default struct HistoryPanel {
  @Link isShow: boolean;
  @Link history: CalculationHistory[]; // 使用明确定义的接口类型

  build() {
    if (this.isShow) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#50000000')
        .onClick(() => this.isShow = false)
        .position({ x: 0, y: 0 })
        .zIndex(-1)

      Column() {
        // 标题栏
        Row() {
          Text('历史记录')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)

          Button('关闭')
            .onClick(() => this.isShow = false)
            .margin({ left: 8 })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding(12)

        // 内容区域
        Column() {
          if (this.history.length === 0) {
            // 空状态
            Column() {
              Text('暂无计算历史。')
                .margin({ top: 8 })
                .opacity(0.6)
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
          } else {
            // 历史记录列表
            List() {
              ForEach(this.history.slice().reverse(), (item: CalculationHistory) => {
                ListItem() {
                  Column() {
                    // 过程文本右对齐
                    Text(item.process)
                      .fontSize(14)
                      .textAlign(TextAlign.End)
                      .width('100%')

                    // 结果文本右对齐（更大字号）
                    Text(item.result)
                      .fontSize(18)
                      .margin({ top: 4 })
                      .textAlign(TextAlign.End)
                      .width('100%')
                  }
                  .width('100%')
                  .padding(12)
                }
                .borderRadius(8)
                .backgroundColor('#FFF')
                .margin({ bottom: 8 })
              })
            }
            .width('100%')
            .height('100%')
          }
        }
        .layoutWeight(1)
        .padding(12)
        .backgroundColor('#F7F8FA')

        // 清空按钮（固定在右下角）
        Button('🗑️') // Unicode垃圾桶符号
          .width(40)
          .height(40)
          .alignSelf(ItemAlign.End)
          .backgroundColor('#FF5252') // 红色警示色
          .fontColor(Color.White)
          .onClick(() => {
            this.history = []; // 清空历史记录
          })
          .opacity(this.history.length > 0 ? 1 : 0) // 无记录时隐藏
      }
      .width('100%')
      .height('70%')
      .position({ x: 0, y: '30%' })
      .backgroundColor('#FFF')
      .border({ width: 1, color: '#EEE' })
      .shadow({ radius: 16, color: '#10000000' })
    }
  }
}