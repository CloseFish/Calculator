// config/theme.config.ts
export interface ThemeStyle {
  bg: string;
  text: string;
  cardBg: string;
  buttonBg: string;
  radioColor: string;
  radioUnselectedColor: string; // 添加这个属性
  radioBg: string;
}

export interface ThemeConfigInterface {
  light: ThemeStyle;
  dark: ThemeStyle;
}

export const ThemeConfig: ThemeConfigInterface = {
  light: {
    bg: '#FFFFFF',
    text: '#000000',
    cardBg: '#F5F5F5',
    buttonBg: '#2196F3',
    radioColor: '#2196F3',
    radioUnselectedColor: '#CCCCCC', // 浅色模式未选中颜色
    radioBg: '#EEEEEE'
  },
  dark: {
    bg: '#121212',
    text: '#FFFFFF',
    cardBg: '#1E1E1E',
    buttonBg: '#2196F3',
    radioColor: '#2196F3',
    radioUnselectedColor: '#666666', // 深色模式未选中颜色
    radioBg: '#2A2A2A'
  },
};