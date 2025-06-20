import Sidebar from './Sidebar';

@Entry
@Component
struct LengthConverter {
  @State inputValue: string = '0';
  @State outputValue: string = '0';
  @State inputUnit: string = '米';
  @State outputUnit: string = '厘米';
  @State showSidebar: boolean = false;
  @State unitOptions: Array<string> = ['厘米', '米', '公里'];
  @State showInputUnitSelector: boolean = false;
  @State showOutputUnitSelector: boolean = false;

  // 单位转换率
  conversionRates: Map<string, number> = new Map([
    ['厘米', 1],
    ['米', 100],
    ['公里', 100000]
  ]);

  build() {
    Column() {
      // 顶部操作栏 - 侧边栏触发按钮
      Row() {
        Button('≡')
          .width(40)
          .height(40)
          .backgroundColor('#4CAF50')
          .onClick(() => {
            this.showSidebar = !this.showSidebar;
          })
        Text('长度')
          .fontSize(20)
          .textAlign(TextAlign.Start)
          .width('flex')
          .padding({ left: 10 })
      }
      .width('100%')

      // 输入值显示，左对齐
      Text(this.inputValue)
        .fontSize(40)
        .textAlign(TextAlign.Start)
        .width('100%')
        .padding({ left: 10 })
        .height(80)
        .maxLines(1)
        .onClick(() => {
          // 可根据实际需求补充交互逻辑，比如聚焦等
        })

      // 输入单位选择，加深背景色，左对齐
      Button(this.inputUnit)
        .width('auto')
        .height(40)
        .backgroundColor('#D3D3D3')
        .onClick(() => {
          this.showInputUnitSelector = true;
          this.showOutputUnitSelector = false;
        })
        .padding({ left: 10, right: 10 })
        .margin({ left: 10 })

      // 输出值显示，左对齐
      Text(this.outputValue)
        .fontSize(40)
        .textAlign(TextAlign.Start)
        .width('100%')
        .padding({ left: 10 })
        .height(80)
        .maxLines(1)
        .onClick(() => {
          // 可根据实际需求补充交互逻辑，比如聚焦等
        })

      // 输出单位选择，加深背景色，左对齐
      Button(this.outputUnit)
        .width('auto')
        .height(40)
        .backgroundColor('#D3D3D3')
        .onClick(() => {
          this.showOutputUnitSelector = true;
          this.showInputUnitSelector = false;
        })
        .padding({ left: 10, right: 10 })
        .margin({ left: 10, top: 10 })

      // 数字键盘区域，简单布局让按钮更规整
      Grid() {
        // 第一行：空 CE 退格
        GridItem() {
          // 空单元格，可根据需求调整占位
        }
        GridItem() {
          Button('CE')
            .width(50)
            .height(50)
            .onClick(() => {
              this.clearEntry();
            })
        }
        GridItem() {
          Button('\u232B')
            .width(50)
            .height(50)
            .onClick(() => {
              this.backspace();
            })
        }

        // 第二行：7 8 9
        GridItem() {
          Button('7')
            .width(50)
            .height(50)
            .onClick(() => {
              this.clickNumber('7');
            })
        }
        GridItem() {
          Button('8')
            .width(50)
            .height(50)
            .onClick(() => {
              this.clickNumber('8');
            })
        }
        GridItem() {
          Button('9')
            .width(50)
            .height(50)
            .onClick(() => {
              this.clickNumber('9');
            })
        }

        // 第三行：4 5 6
        GridItem() {
          Button('4')
            .width(50)
            .height(50)
            .onClick(() => {
              this.clickNumber('4');
            })
        }
        GridItem() {
          Button('5')
            .width(50)
            .height(50)
            .onClick(() => {
              this.clickNumber('5');
            })
        }
        GridItem() {
          Button('6')
            .width(50)
            .height(50)
            .onClick(() => {
              this.clickNumber('6');
            })
        }

        // 第四行：1 2 3
        GridItem() {
          Button('1')
            .width(50)
            .height(50)
            .onClick(() => {
              this.clickNumber('1');
            })
        }
        GridItem() {
          Button('2')
            .width(50)
            .height(50)
            .onClick(() => {
              this.clickNumber('2');
            })
        }
        GridItem() {
          Button('3')
            .width(50)
            .height(50)
            .onClick(() => {
              this.clickNumber('3');
            })
        }

        // 第五行：空 0 点
        GridItem() {
          // 空单元格，可根据需求调整占位
        }
        GridItem() {
          Button('0')
            .width(50)
            .height(50)
            .onClick(() => {
              this.clickNumber('0');
            })
        }
        GridItem() {
          Button('.')
            .width(50)
            .height(50)
            .onClick(() => {
              this.clickDecimal();
            })
        }
      }
      .columnsTemplate('repeat(3, 1fr)')
      .rowsTemplate('repeat(5, 1fr)')
      .width('100%')
      .height('60%')
      .padding(10)
      .margin({ top: 10 })

      // 侧边栏组件 - 悬浮在上方
      if (this.showSidebar) {
        Sidebar()
          .width('50%')
          .height('100%')
          .position({ x: 0 })
          .zIndex(100);
      }

      // 输入单位选择器
      if (this.showInputUnitSelector) {
        Column() {
          ForEach(this.unitOptions, (unit: string) => {
            Button(unit)
              .width('100%')
              .height(60)
              .backgroundColor('#f0f0f0')
              .onClick(() => {
                this.inputUnit = unit;
                this.convert();
                this.showInputUnitSelector = false;
              })
          })
        }
        .width('100%')
        .height('30%')
        .backgroundColor('white')
        .borderRadius(10)
        .position({ x: 0, y: 200 })
        .zIndex(200)
        .padding(10)
      }

      // 输出单位选择器
      if (this.showOutputUnitSelector) {
        Column() {
          ForEach(this.unitOptions, (unit: string) => {
            Button(unit)
              .width('100%')
              .height(60)
              .backgroundColor('#f0f0f0')
              .onClick(() => {
                this.outputUnit = unit;
                this.convert();
                this.showOutputUnitSelector = false;
              })
          })
        }
        .width('100%')
        .height('30%')
        .backgroundColor('white')
        .borderRadius(10)
        .position({ x: 0, y: 200 })
        .zIndex(200)
        .padding(10)
      }
    }
    .padding(20)
    .width('100%')
    .height('100%');
  }

  // 执行单位转换
  convert(): void {
    const inputValue: number = parseFloat(this.inputValue);
    if (isNaN(inputValue)) {
      this.outputValue = '0';
      return;
    }

    const inputRate: number = this.conversionRates.get(this.inputUnit) || 1;
    const outputRate: number = this.conversionRates.get(this.outputUnit) || 1;

    const result: number = (inputValue * inputRate) / outputRate;
    this.outputValue = this.formatNumber(result);
  }

  // 格式化数字
  formatNumber(num: number): string {
    if (Number.isInteger(num)) {
      return num.toString();
    }
    return num.toFixed(8).replace(/\.?0+$/, '');
  }

  // 点击数字按钮
  clickNumber(num: string): void {
    if (num === '0' && this.inputValue === '0') {
      return;
    }
    if (this.inputValue === '0' && num !== '.') {
      this.inputValue = num;
    } else {
      this.inputValue += num;
    }
    this.convert();
  }

  // 点击小数点
  clickDecimal(): void {
    if (!this.inputValue.includes('.')) {
      if (this.inputValue === '') {
        this.inputValue = '0.';
      } else {
        this.inputValue += '.';
      }
      this.convert();
    }
  }

  // 清除当前输入
  clearEntry(): void {
    this.inputValue = '0';
    this.outputValue = '0';
  }

  // 退格删除
  backspace(): void {
    if (this.inputValue.length > 1) {
      this.inputValue = this.inputValue.slice(0, -1);
    } else {
      this.inputValue = '0';
    }
    this.convert();
  }
}