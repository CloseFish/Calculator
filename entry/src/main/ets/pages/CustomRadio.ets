@Component
export struct CustomRadio {
  @Prop label: string;
  @Prop value: 'light' | 'dark' | 'system';
  @Prop selected: boolean;
  @Link theme: 'light' | 'dark' | 'system';

  build() {
    Row({ space: 8 }) {
      // 三层圆形结构
      Stack({ alignContent: Alignment.Center }) {
        /* 最外层（显著调暗） */
        Circle()
          .size({ width: 24, height: 24 })
          .fill(this.theme === 'dark' ? '#D8D8D8' : '#F0F0F0') // 深色模式用更暗的灰

        /* 中间层 */
        Circle()
          .size({ width: 20, height: 20 })
          .fill(this.selected ? '#1890FF' :
            (this.theme === 'dark' ? '#3A3A3A' : '#F8F8F8'))

        /* 最内层 */
        Circle()
          .size({ width: 16, height: 16 })
          .fill(this.theme === 'dark' ? '#000000' : '#FFFFFF')
      }

      // 文本标签
      Text(this.label)
        .fontSize(16)
        .fontColor(this.theme === 'dark' ? '#FFFFFF' : '#000000')
    }
    .padding(12)
    .width('100%')
  }
}