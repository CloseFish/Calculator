@Component
export struct GlobalStyles {
  @State bgColor: string = '#FFFFFF'
  @State textColor: string = '#000000'

  build() {
    Column()
      .width('100%')
      .height('100%')
      .backgroundColor(this.bgColor)
  }
}