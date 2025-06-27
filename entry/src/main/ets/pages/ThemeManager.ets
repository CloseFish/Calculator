// 定义主题配置接口
interface ThemeConfig {
  bg: string;
  text: string;
  card: string;
}

// 主题配置常量
const lightTheme: ThemeConfig = {
  bg: '#FFFFFF',
  text: '#000000',
  card: '#F5F5F5'
};

const darkTheme: ThemeConfig = {
  bg: '#121212',
  text: '#FFFFFF',
  card: '#1E1E1E'
};

export class ThemeManager {
  // 设置主题（无 this）
  static setTheme(theme: 'light' | 'dark'): void {
    const config = theme === 'light' ? lightTheme : darkTheme;
    AppStorage.Set('bgColor', config.bg);
    AppStorage.Set('textColor', config.text);
    AppStorage.Set('cardColor', config.card);
    AppStorage.Set('currentTheme', theme);
  }

  // 初始化主题（无 this）
  static initTheme(): void {
    const savedTheme = AppStorage.Get('currentTheme') as string;
    if (savedTheme === 'light' || savedTheme === 'dark') {
      ThemeManager.setTheme(savedTheme); // 直接调用静态方法
      return;
    }
    ThemeManager.setTheme('light'); // 直接调用静态方法
  }
}