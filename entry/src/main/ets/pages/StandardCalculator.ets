import { router } from '@kit.ArkUI';
import Sidebar from './Sidebar';
import HistoryPanel from './HistoryPanel';
import { CalculationHistory } from '../common/utils/types';

@Entry
@Component
struct StandardCalculator {
  @State result: string = '0';
  @State firstNumber: number = 0;    // 第一个操作数
  @State secondNumber: number = 0;   // 第二个操作数
  @State currentNumber: string = '';   // 当前正在输入的数值
  @State currentOperator: string = ''; // 当前的运算符
  @State isOperatorClicked: boolean = false; // 是否按下运算符
  @State isEqualClicked: boolean = false; // 是否刚按下等号
  @State lastInputIsNumber: boolean = false; // 记录上一次输入是否为数字
  @State isBackspaceAllowed: boolean = false; // 记录是否允许退格
  @State process: string = ''; // 第一行要显示的内容
  @State processPart1: string = '*'; // 第一部分文本
  @State processOperator: string = ''; // 符号
  @State processPart2: string = '*'; // 第二部分文本
  @State prevOperator: string = ''; // 保存上一次的运算符
  @State prevSecondNumber: number = 0; // 保存上一次的第二个操作数
  @State isError: boolean = false; // 记录是否处于错误状态
  @State showSidebar: boolean = false; // 控制侧边栏显示状态
  @State showHistoryPanel: boolean = false; // 控制历史记录面板显示
  @State history: CalculationHistory[] = [];

  build() {
    Column() {
      // 顶部操作栏 - 添加侧边栏触发按钮
      Row() {
        Button('≡')
          .width(40)
          .height(40)
          .backgroundColor('#4CAF50')
          .onClick(() => {
            this.showSidebar = !this.showSidebar;
          })
        Text('标准')
          .fontSize(20)
          .textAlign(TextAlign.Start)
          .width('flex')
          .padding({ left: 10 })

        Button('📜') // 使用卷轴emoji作为图标
          .width(40)
          .height(40)
          .margin({ left: 10 })
          .backgroundColor('#2196F3') // 蓝色区别于侧边栏绿色
          .onClick(() => {
            this.showHistoryPanel = !this.showHistoryPanel;
          })
      }
      .width('100%')

      // 显示过程
      Text(this.process)
        .fontSize(20)
        .textAlign(TextAlign.End)
        .width('100%')
        .padding(10)
        .backgroundColor('#ffb8afaf')
        .height(40)
        .maxLines(1)

      // 显示结果
      Text(this.result)
        .fontSize(40)
        .textAlign(TextAlign.End)
        .width('100%')
        .padding(10)
        .backgroundColor('#ffb8afaf')
        .height(80)
        .maxLines(1)

      Grid() {
        GridItem() { Button('%')
          .onClick(() => {
            if (!this.isError) {
              this.processCurrentNumber();
              this.setSecondNumber();
              this.calculatePercentage();
            }
          })
          .width(50)
          .height(50)
          .opacity(this.isError? 0.5 : 1)
          .enabled(!this.isError)
        }
        GridItem() { Button('CE')
          .onClick(() => {
            if (this.isError) {
              this.clear();
            } else {
              this.processCurrentNumber();
              this.clearEntry();
            }
          })
          .width(50)
          .height(50)
        }
        GridItem() { Button('C')
          .onClick(() => {
            if (this.isError) {
              this.clear();
            } else {
              this.processCurrentNumber();
              this.clear();
            }
          })
          .width(50)
          .height(50)
        }
        // 使用Unicode字符表示退格键
        GridItem() { Button('\u232B')
          .onClick(() => {
            if (this.isError) {
              this.clear();
            } else {
              this.processCurrentNumber();
              this.backspace();
            }
          })
          .width(50)
          .height(50)
        }
        GridItem() { Button('1/x')
          .onClick(() => {
            if (!this.isError) {
              this.processCurrentNumber();
              this.setSecondNumber();
              this.calculateReciprocal();
            }
          })
          .width(50)
          .height(50)
          .opacity(this.isError? 0.5 : 1)
          .enabled(!this.isError)
        }
        GridItem() { Button('x²')
          .onClick(() => {
            if (!this.isError) {
              this.processCurrentNumber();
              this.setSecondNumber();
              this.calculateSquare();
            }
          })
          .width(50)
          .height(50)
          .opacity(this.isError? 0.5 : 1)
          .enabled(!this.isError)
        }
        GridItem() { Button('√x')
          .onClick(() => {
            if (!this.isError) {
              this.processCurrentNumber();
              this.setSecondNumber();
              this.calculateSquareRoot();
            }
          })
          .width(50)
          .height(50)
          .opacity(this.isError? 0.5 : 1)
          .enabled(!this.isError)
        }
        GridItem() { Button('÷')
          .onClick(() => {
            if (!this.isError) {
              this.processCurrentNumber();
              this.clickOperator('÷');
            }
          })
          .width(50)
          .height(50)
          .opacity(this.isError? 0.5 : 1)
          .enabled(!this.isError)
        }
        GridItem() { Button('7')
          .onClick(() => {
            if (this.isError) {
              this.clear();
            }
            this.clickNumber('7');
          })
          .width(50)
          .height(50)
        }
        GridItem() { Button('8')
          .onClick(() => {
            if (this.isError) {
              this.clear();
            }
            this.clickNumber('8');
          })
          .width(50)
          .height(50)
        }
        GridItem() { Button('9')
          .onClick(() => {
            if (this.isError) {
              this.clear();
            }
            this.clickNumber('9');
          })
          .width(50)
          .height(50)
        }
        GridItem() { Button('×')
          .onClick(() => {
            if (!this.isError) {
              this.processCurrentNumber();
              this.clickOperator('×');
            }
          })
          .width(50)
          .height(50)
          .opacity(this.isError? 0.5 : 1)
          .enabled(!this.isError)
        }
        GridItem() { Button('4')
          .onClick(() => {
            if (this.isError) {
              this.clear();
            }
            this.clickNumber('4');
          })
          .width(50)
          .height(50)
        }
        GridItem() { Button('5')
          .onClick(() => {
            if (this.isError) {
              this.clear();
            }
            this.clickNumber('5');
          })
          .width(50)
          .height(50)
        }
        GridItem() { Button('6')
          .onClick(() => {
            if (this.isError) {
              this.clear();
            }
            this.clickNumber('6');
          })
          .width(50)
          .height(50)
        }
        GridItem() { Button('−')
          .onClick(() => {
            if (!this.isError) {
              this.processCurrentNumber();
              this.clickOperator('-');
            }
          })
          .width(50)
          .height(50)
          .opacity(this.isError? 0.5 : 1)
          .enabled(!this.isError)
        }
        GridItem() { Button('1')
          .onClick(() => {
            if (this.isError) {
              this.clear();
            }
            this.clickNumber('1');
          })
          .width(50)
          .height(50)
        }
        GridItem() { Button('2')
          .onClick(() => {
            if (this.isError) {
              this.clear();
            }
            this.clickNumber('2');
          })
          .width(50)
          .height(50)
        }
        GridItem() { Button('3')
          .onClick(() => {
            if (this.isError) {
              this.clear();
            }
            this.clickNumber('3');
          })
          .width(50)
          .height(50)
        }
        GridItem() { Button('+')
          .onClick(() => {
            if (!this.isError) {
              this.processCurrentNumber();
              this.clickOperator('+');
            }
          })
          .width(50)
          .height(50)
          .opacity(this.isError? 0.5 : 1)
          .enabled(!this.isError)
        }
        GridItem() { Button('+/-')
          .onClick(() => {
            if (!this.isError) {
              this.processCurrentNumber();
              this.calculateNegate();
            }
          })
          .width(50)
          .height(50)
          .opacity(this.isError? 0.5 : 1)
          .enabled(!this.isError)
        }
        GridItem() { Button('0')
          .onClick(() => {
            if (this.isError) {
              this.clear();
            }
            this.clickNumber('0');
          })
          .width(50)
          .height(50)
        }
        GridItem() { Button('.')
          .onClick(() => {
            if (!this.isError) {
              this.clickDecimal();
            }
          })
          .width(50)
          .height(50)
          .opacity(this.isError? 0.5 : 1)
          .enabled(!this.isError)
        }
        GridItem() { Button('=')
          .onClick(() => {
            if (this.isError) {
              this.clear();
            } else {
              this.processCurrentNumber();
              this.setSecondNumber();
              this.clickEqual();
            }
          })
          .width(50)
          .height(50)
        }
      }
      .columnsTemplate('repeat(4, 1fr)')
      .rowsTemplate('repeat(6, 1fr)')
      .width('100%')
      .height('80%')
      .padding(10)

      Text("112200205官瑜")

      // 侧边栏组件 - 悬浮在上方
      if (this.showSidebar) {
        // 通过构造函数传递 @Link 绑定的状态
        Sidebar({ isShow: $showSidebar })
          .width('50%')
          .height('100%')
          .position({ x: 0 })
          .zIndex(100);
      }

      // 历史记录面板组件 - 悬浮在下方
      if (this.showHistoryPanel) {
        HistoryPanel({
          isShow: $showHistoryPanel,
          history: $history
        })
          .width('100%')
          .height('60%')
          .position({ x: 0, y: '40%' }) // 定位在屏幕下方60%区域
          .zIndex(100) // 确保悬浮在最上层
          .border({ width: 1, color: '#E0E0E0' })
          .shadow({ radius: 10, color: '#40000000' })
      }
    }
    .padding(20)
    .width('100%')
    .height('100%');
  }

  updateProcessDisplay(mode: number, haveEqual: boolean) {
    let part1 = this.processPart1;
    let part2 = this.processPart2;

    // 判断 processPart1 是否为 '*'，如果是则将其替换为 '0'
    if (part1 === '*') {
      part1 = '0';
    }
    // 判断 processPart2 是否为 '*'，如果是则将其替换为 '0'
    if (part2 === '*') {
      part2 = '0';
    }

    switch (mode) {
      case 1:
        this.process = `${part1}`;
        break;
      case 2:
        this.process = `${part1} ${this.processOperator}`;
        break;
      case 3:
        this.process = `${part1} ${this.processOperator} ${part2}`;
        break;
      default: // case 0
        break;
    }
    if (haveEqual) {
      this.process += ' =';
    }
    return 0;
  }

  // 新增平方功能
  calculateSquare(): void {
    if (this.isEqualClicked) {
      this.processPart1 = this.result;
    }
    if (this.currentOperator === '') {
      if (this.processPart1 === '*' || this.isBackspaceAllowed) {
        if (this.currentNumber === '') {
          this.currentNumber = '0';
        }
        this.processPart1 = this.currentNumber;
      }
      this.processPart1 = `sqr(${this.processPart1})`;
      this.updateProcessDisplay(1, false);
    } else {
      if (this.processPart2 === '*' || this.isBackspaceAllowed) {
        if (this.currentNumber === '') {
          this.currentNumber = '0';
        }
        this.processPart2 = this.currentNumber;
      }
      this.processPart2 = `sqr(${this.processPart2})`;
      this.updateProcessDisplay(3, false);
    }

    const currentValue = parseFloat(this.currentNumber);
    const square = currentValue * currentValue;
    const roundedResult = this.roundToFixed(square, 15);
    this.result = roundedResult.toString();
    this.currentNumber = roundedResult.toString();
    this.isOperatorClicked = true;
    this.lastInputIsNumber = true;
    this.isBackspaceAllowed = false;
  }

  // 新增根号功能
  calculateSquareRoot(): void {
    if (this.isEqualClicked) {
      this.processPart1 = this.result;
    }
    if (this.currentOperator === '') {
      if (this.processPart1 === '*' || this.isBackspaceAllowed) {
        if (this.currentNumber === '') {
          this.currentNumber = '0';
        }
        this.processPart1 = this.currentNumber;
      }
      this.processPart1 = `√(${this.processPart1})`;
      this.updateProcessDisplay(1, false);
    } else {
      if (this.processPart2 === '*' || this.isBackspaceAllowed) {
        if (this.currentNumber === '') {
          this.currentNumber = '0';
        }
        this.processPart2 = this.currentNumber;
      }
      this.processPart2 = `√(${this.processPart2})`;
      this.updateProcessDisplay(3, false);
    }

    const currentValue = parseFloat(this.currentNumber);
    if (currentValue < 0) {
      this.result = '无效输入';
      this.currentNumber = '0';
      this.isError = true;
    } else {
      const squareRoot = Math.sqrt(currentValue);
      const roundedResult = this.roundToFixed(squareRoot, 15);
      this.result = roundedResult.toString();
      this.currentNumber = roundedResult.toString();
    }
    this.isOperatorClicked = true;
    this.lastInputIsNumber = true;
    this.isBackspaceAllowed = false;
  }

  clearEntry(): void {
    this.currentNumber = '';
    this.result = '0';
    this.lastInputIsNumber = false;
    this.isBackspaceAllowed = false;
    this.isError = false;
  }

  calculateReciprocal(): void {
    if (this.isEqualClicked) {
      this.processPart1 = this.result;
    }
    if (this.currentOperator === '') {
      if (this.processPart1 === '*' || this.isBackspaceAllowed) {
        if (this.currentNumber === '') {
          this.currentNumber = '0';
        }
        this.processPart1 = this.currentNumber;
      }
      this.processPart1 = `1/(${this.processPart1})`;
      this.updateProcessDisplay(1, false);
    } else {
      if (this.processPart2 === '*' || this.isBackspaceAllowed) {
        if (this.currentNumber === '') {
          this.currentNumber = '0';
        }
        this.processPart2 = this.currentNumber;
      }
      this.processPart2 = `1/(${this.processPart2})`;
      this.updateProcessDisplay(3, false);
    }

    let valueToReciprocal: number;
    if (this.currentOperator!== '') {
      valueToReciprocal = this.firstNumber;
    } else {
      valueToReciprocal = parseFloat(this.currentNumber);
    }

    if (valueToReciprocal === 0) {
      this.result = '除数不能为零';
      this.isError = true;
    } else {
      const reciprocal = 1 / valueToReciprocal;
      const roundedResult = this.roundToFixed(reciprocal, 15);
      this.result = roundedResult.toString();
      this.currentNumber = roundedResult.toString();
    }

    this.isOperatorClicked = true;
    this.lastInputIsNumber = true;
    this.isBackspaceAllowed = false;
  }

  clickEqual(): void {
    if (this.isEqualClicked) {
      // 如果是连续按等号，使用上一次的运算符和第二个操作数
      this.firstNumber = parseFloat(this.result);
      this.currentOperator = this.prevOperator;
      this.secondNumber = this.prevSecondNumber;

      this.processPart1 = this.result;
      this.processPart2 = `${this.prevSecondNumber}`;
    } else {
      // 第一次按等号
      // 保存当前的运算符和第二个操作数
      this.prevOperator = this.currentOperator;
      this.prevSecondNumber = this.secondNumber;
    }

    if (this.currentOperator === '') {
      // 输完数字直接按等于号的情况
      this.firstNumber = parseFloat(this.currentNumber);
      if (this.processPart1 === '*' || this.isBackspaceAllowed) {
        this.processPart1 = this.currentNumber;
      }
      this.result = this.currentNumber;
      this.updateProcessDisplay(1, true);
    } else {
      if (this.isBackspaceAllowed) {
        this.processPart2 = `${this.secondNumber}`;
      }
      this.updateProcessDisplay(3, true);

      let result = this.calculate(this.firstNumber, this.secondNumber, this.currentOperator);
      if (typeof result === 'string') {
        this.result = result;
        this.currentNumber = '0';
        this.isError = true;
        this.updateProcessDisplay(2, false);
      } else {
        // 对结果进行四舍五入处理
        result = this.roundToFixed(result, 15);
        this.result = result.toString();
        this.currentNumber = result.toString();
        this.firstNumber = result;
      }
    }

    if (!this.isError) {
      this.history.push({
        process: this.process + ' =',
        result: this.result
      });
    }

    this.currentOperator = '';
    this.isEqualClicked = true;
    this.lastInputIsNumber = false;
    this.isBackspaceAllowed = false;
  }

  // 新增退格功能函数
  backspace(): void {
    if (this.isBackspaceAllowed && this.currentNumber.length > 0 && this.currentNumber!== '0') {
      this.currentNumber = this.currentNumber.slice(0, -1);
      if (this.currentNumber === '') {
        this.currentNumber = '0';
      }
      this.result = this.currentNumber;
    }
    this.isError = false;
  }

  // 辅助函数：四舍五入到指定小数位数
  roundToFixed(num: number, decimalPlaces: number): number {
    const multiplier = Math.pow(10, decimalPlaces);
    return Math.round(num * multiplier) / multiplier;
  }

  calculate(firstNumber: number, secondNumber: number, currentOperator: string) {
    switch (currentOperator) {
      case '+':
        return firstNumber + secondNumber;
      case '-':
        return firstNumber - secondNumber;
      case '×':
        return firstNumber * secondNumber;
      case '÷':
        if (secondNumber === 0) {
          if (firstNumber === 0) {
            return '结果未定义';
          } else {
            return '除数不能为零';
          }
        }
        return firstNumber / secondNumber;
      default:
        return 0;
    }
  }

  clickNumber(num: string): void {
    // 避免连续按多次 0 的情况
    if (num === '0' && this.currentNumber === '0') {
      return;
    }
    // 避免输入 0 开头非小数的情况
    if (this.currentNumber === '0' && num!== '.' && num!== '0') {
      this.currentNumber = num;
    } else {
      if (this.isEqualClicked) {
        this.firstNumber = 0;
        this.currentNumber = '';
        this.isEqualClicked = false;
        this.prevOperator = '';
        this.prevSecondNumber = 0;
      }
      if (this.isOperatorClicked) {
        this.currentNumber = '';
        this.isOperatorClicked = false;
      }
      this.currentNumber += num;
    }
    if (!this.isBackspaceAllowed && this.lastInputIsNumber) {
      this.updateProcessDisplay(2, false);
    }

    this.result = this.currentNumber;
    this.lastInputIsNumber = true;
    this.isBackspaceAllowed = true;
    this.isError = false;
  }

  clickOperator(operator: string): void {
    this.processOperator = operator;

    if (this.lastInputIsNumber && this.currentOperator!== '') {
      // 上一次点击的是数字且已有运算符，调用 clickEqual() 进行计算
      this.setSecondNumber();
      this.clickEqual();
    }

    if (this.isEqualClicked) {
      this.firstNumber = parseFloat(this.result);
      this.currentNumber = '';
      this.isEqualClicked = false;
      this.prevOperator = '';
      this.prevSecondNumber = 0;

      this.processPart1 = this.result;
    }

    if (this.currentNumber!== '') {
      this.firstNumber = parseFloat(this.currentNumber);

      if (this.isBackspaceAllowed) {
        this.processPart1 = this.currentNumber;
      }
    }

    this.currentOperator = operator;
    this.isOperatorClicked = true;
    this.lastInputIsNumber = false;
    this.isBackspaceAllowed = false;

    this.updateProcessDisplay(2, false);
  }

  clear(): void {
    this.result = '0';
    this.firstNumber = 0;
    this.secondNumber = 0;
    this.currentNumber = '';
    this.currentOperator = '';
    this.isOperatorClicked = false;
    this.isEqualClicked = false;
    this.lastInputIsNumber = false;
    this.isBackspaceAllowed = false;
    this.prevOperator = '';
    this.prevSecondNumber = 0;
    this.process = '';
    this.processPart1 = '*';
    this.processOperator = '';
    this.processPart2 = '*';
    this.isError = false;
  }

  calculateNegate(): void {
    if (this.currentNumber!== '') {
      const num = parseFloat(this.currentNumber);
      this.currentNumber = (-num).toString();
      this.result = this.currentNumber;
    }
    this.lastInputIsNumber = false;
  }

  clickDecimal(): void {
    if (!this.currentNumber.includes('.')) {
      if (this.isOperatorClicked || this.currentNumber === '') {
        this.currentNumber = '0.';
        this.isOperatorClicked = false;
      } else if (this.isEqualClicked) {
        this.firstNumber = 0;
        this.currentNumber = '0.';
        this.isEqualClicked = false;
        this.prevOperator = '';
        this.prevSecondNumber = 0;
      } else {
        this.currentNumber += '.';
      }
      this.result = this.currentNumber;
    } else if (!this.isBackspaceAllowed) {
      this.secondNumber = 0;
      this.currentNumber = '0.';
      this.isOperatorClicked = false;
      this.result = this.currentNumber;
    }
    this.lastInputIsNumber = false;
    this.isBackspaceAllowed = true;
  }

  // 新增百分比计算功能
  calculatePercentage(): void {
    if (this.currentOperator) {
      const percentValue = parseFloat(this.currentNumber);
      switch (this.currentOperator) {
        case '+':
          this.secondNumber = this.firstNumber * (percentValue / 100);
          this.secondNumber = this.roundToFixed(this.secondNumber, 15);
          this.currentNumber = this.secondNumber.toString();
          this.result = this.currentNumber;
          break;
        case '-':
          this.secondNumber = this.firstNumber * (percentValue / 100);
          this.secondNumber = this.roundToFixed(this.secondNumber, 15);
          this.currentNumber = this.secondNumber.toString();
          this.result = this.currentNumber;
          break;
        case '×':
          this.secondNumber = percentValue / 100;
          this.secondNumber = this.roundToFixed(this.secondNumber, 15);
          this.currentNumber = this.secondNumber.toString();
          this.result = this.currentNumber;
          break;
        case '÷':
          this.secondNumber = percentValue / 100;
          this.secondNumber = this.roundToFixed(this.secondNumber, 15);
          this.currentNumber = this.secondNumber.toString();
          this.result = this.currentNumber;
          break;
      }
      this.processPart2 = this.currentNumber;
      this.updateProcessDisplay(3, false);
    } else if (this.processOperator === '') {
      this.processPart1 = '*';
      this.updateProcessDisplay(1, false);
      this.currentNumber = '0';
      this.result = '0';
    } else {
      //code here
    }
    this.isOperatorClicked = true;
    this.lastInputIsNumber = false;
    this.isBackspaceAllowed = false;
  }

  // 封装设置 secondNumber 的逻辑
  setSecondNumber(): void {
    if (this.currentNumber === '') {
      this.secondNumber = this.firstNumber;
      this.processPart2 = `${this.firstNumber}`;
    } else {
      this.secondNumber = parseFloat(this.currentNumber);
      if (this.isBackspaceAllowed) {
        this.processPart2 = this.currentNumber;
      }
    }
  }

  // 处理 currentNumber，去除小数点后的 0 后缀
  processCurrentNumber(): void {
    if (this.currentNumber.includes('.')) {
      this.currentNumber = this.currentNumber.replace(/\.?0+$/, '');
    }
  }
}