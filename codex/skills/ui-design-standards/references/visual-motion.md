# 视觉与动效补充参考

核实日期：2026-10-24。在需要处理视觉质感、暗色排版、流式文字或微动效时读取。先沿用项目 token 和组件，再按需结合 `ui-ux-pro-max`；本文件是可选参考，不要求所有界面采用同一种风格。

## 可采用的机制与有条件建议

| 议题 / 视频主张 | 核实结果与采用方式 | 官方依据 |
|---|---|---|
| 用 1%–3% 明度差分层、禁纯黑、全部去边框 | 这些是风格参数，未获通用标准依据。可以减少装饰性边框，但必须保留识别控件与状态所需的信息；装饰性表面层次不必全部达到 3:1，承担控件边界等必要识别功能的视觉信息须满足相应非文本对比要求 | [W3C 非文本对比](https://www.w3.org/WAI/WCAG22/Understanding/non-text-contrast.html) |
| 边框只能套一层 | 作为减少视觉噪声的设计建议，不能禁止必要的按钮、输入框或选中边界。先用分组和间距表达关系；决定是否去边框后复核识别性与焦点 | [W3C 非文本对比](https://www.w3.org/WAI/WCAG22/Understanding/non-text-contrast.html)、[焦点可见](https://www.w3.org/WAI/WCAG22/Understanding/focus-visible.html) |
| focus 不加 outline，只用双环 shadow | 不采用“禁 outline”。可使用自定义焦点环，但必须清晰、持续可见；forced-colors 可移除 box-shadow，须保留系统 outline 或提供适配回退 | [W3C 焦点可见](https://www.w3.org/WAI/WCAG22/Understanding/focus-visible.html)、[MDN forced-colors](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/At-rules/@media/forced-colors) |
| 用 inset box-shadow 代替描边以免布局抖动 | box-shadow 不改变盒模型尺寸，作为可选机制成立；也可预留透明 border 再改变颜色，不必全站替换。shadow 不能成为高对比模式中唯一控件边界 | [MDN box-shadow](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Properties/box-shadow)、[forced-colors](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/At-rules/@media/forced-colors) |
| 暗色字重统一减 40，如 400→360 | 未找到统一视觉补偿标准。中间字重是否有实际效果取决于字体文件及可用字重；非可变字体会按可用字重回退。按字体、字号、背景和实际设备检查，不全局减重 | [MDN font-weight](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Properties/font-weight) |
| 流式字逐个 blur(6px)、90ms、间隔 30ms | 效果与数值属于风格选择，未证实为通用最佳做法。默认优先文字立即可读，不把网络流式输出速度和装饰动画绑定；需要此效果时验证长回复性能、复制/选字及减少动态效果模式 | [MDN prefers-reduced-motion](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/At-rules/@media/prefers-reduced-motion)支持偏好检测；具体流式策略为工程建议 |
| 数字防抖用 tabular-nums | 机制成立：请求字体的等宽数字特性，适合计数器、计时器和数据列；不保证符号、小数位或数字位数变化时整体宽度恒定，必要时预留容器宽度 | [MDN font-variant-numeric](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Properties/font-variant-numeric) |
| 行内图标统一 vertical-align: -0.125em | vertical-align 适用于行内、行内块和表格单元格等上下文；固定偏移受字体及图标影响，不设统一值。按钮等可用现有 flex 对齐方案 | [MDN vertical-align](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Properties/vertical-align) |
| 折叠一律 Grid 0fr→1fr、无需 JS 算高度 | Grid 轨道具备有条件插值能力，可选用同结构轨道的过渡；内容的最小尺寸和 overflow 仍会影响折叠结果。折叠后子控件不能留在 Tab 顺序中；沿用现有 disclosure/accordion 语义与组件，按钮的 aria-expanded 与显示状态一致。不要求全站采用同一技术 | [W3C Grid 轨道与插值](https://www.w3.org/TR/css-grid-1/#track-sizing)、[Google web.dev Grid 动画](https://web.dev/articles/css-animated-grid-layouts)、[W3C Disclosure](https://www.w3.org/WAI/ARIA/apg/patterns/disclosure/) |
| 正文都加 text-wrap: pretty 就能防孤字 | 可作为渐进增强，排版质量和表现由浏览器实现决定，不保证消除所有短末行；检查目标浏览器、中文/英文及性能，不改动原始文本来伪造换行 | [MDN text-wrap](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Properties/text-wrap) |
| 拖拽 1200/80、点赞 380/18 是统一弹簧配方 | stiffness、damping、mass 等由库共同解释，这两组值不具跨库通用性。“直接操控跟手、完成反馈可克制回弹”是设计建议；沿用项目 motion token，支持减少动态效果 | [Motion animate](https://motion.dev/docs/animate)、[MDN reduced motion](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/At-rules/@media/prefers-reduced-motion) |
| 复制对勾 2.5 秒自动恢复 | 可作为短暂反馈的产品参数，不是通用期限；先等复制成功再显示，重复触发时正确更新。持续操作结果、失败与补救不能仅靠定时图标表达 | [Android Snackbar 可配置反馈](https://developer.android.com/develop/ui/compose/components/snackbar)仅支持可配置反馈机制，不规定复制图标期限 |
| 外圆角 = 内圆角 + padding | 在等距内缩且边界定义明确时可作为几何起点；CSS 同一盒子的内边缘圆角还需扣除 border，并截断到非负值。不同盒子、非均匀间距、椭圆及半径归一化时需按实际几何复核，不能总是仅加 padding | [W3C CSS Corner Shaping](https://www.w3.org/TR/css-backgrounds-3/#corner-shaping) |

“未找到通用标准依据”表示本次查阅的官方来源未支持该统一规则，不表示禁止明确的产品风格选择。表中的参数保留用于核实追溯，不能复制为项目默认值。

## 使用时的底线

普通文本检查 4.5:1，大号文本按标准定义检查 3:1，并注意标准中的适用范围与例外；不要把视频的明度百分比当 WCAG 对比度比值。[依据：W3C Contrast Minimum](https://www.w3.org/WAI/WCAG22/Understanding/contrast-minimum.html)。

键盘焦点必须可见；减少动态效果时降低或移除非必要的位移、回弹和模糊呈现，同时保留清楚的状态变化。不能为了“高级感”延迟可读内容或删掉错误、单位、操作后果。[依据：W3C Focus Visible](https://www.w3.org/WAI/WCAG22/Understanding/focus-visible.html)、[MDN prefers-reduced-motion](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/At-rules/@media/prefers-reduced-motion)；内容及时可读是本技能的设计建议。

选择折叠实现时可评估支持范围内的 `interpolate-size`，并保留无需动画也能正常展开/收起的回退；该能力与 Grid 是不同方案，先核对目标浏览器，不把试验性或有限支持能力写成全平台默认。[依据：MDN interpolate-size](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Properties/interpolate-size)。

## 验证范围

按改动检查浅/暗主题、正文和控件对比度、键盘焦点与 forced-colors、reduced-motion、长文本及动态数字。涉及流式文字和展开时，再检查性能、选字、读屏和隐藏控件焦点；仅补充参考文档不等于已验证任何产品界面。

## 选题追溯

用户指定的[视觉质感视频](https://www.douyin.com/video/7699196387954642214)和[界面细节视频](https://www.douyin.com/video/7699520911870856483)只作为待核实主张来源。这里未对“来自大厂源码”的说法作独立确认，也不将个人经验升级为官方规范。
