# 规则核实与参数边界

核实日期：2026-10-24。此处区分 API 的事实、实现策略和未获通用依据的产品参数。

| 视频主张或方案 | 核实结果与采用方式 | 一手依据 |
|---|---|---|
| 输入法选字中 Enter 不发送；检查 isComposing / 229 | 采用合成状态守卫。MDN 记录了合成开始、结束与 keydown 的顺序边界，229 可作已弃用 API 的定向兼容检查；原生平台另查对应输入事件 | [MDN keydown/IME](https://developer.mozilla.org/en-US/docs/Web/API/Element/keydown_event) |
| 选字结束 500ms 内一律禁发 | 未在上述文档找到通用依据，不设默认等待窗口；如需补丁，必须能复现目标环境的事件顺序问题，并验证不会吞正常回车 | [MDN keydown/IME](https://developer.mozilla.org/en-US/docs/Web/API/Element/keydown_event) |
| 距底部 40px 才跟随、超过 120px 显示入口 | DOM 尺寸可计算距离，但具体阈值不是 API 标准；采用可配置距离与显式跟随状态，普通列表允许小数误差 | [MDN scrollHeight](https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollHeight) |
| 用户一滚动就停跟随 | 修正为尊重“离开底部阅读”的意图；程序滚动也会改变位置，不能见到 scroll 事件就认定为用户上翻。此状态策略是本技能的工程建议 | [MDN scrollHeight](https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollHeight)仅支持几何计算，不规定 UX 策略 |
| 拖分栏要盖透明遮罩 | 同文档可使用 pointer capture；跨 iframe/预览有事件丢失时再考虑临时遮罩，不给所有分栏常驻遮罩 | [MDN setPointerCapture](https://developer.mozilla.org/en-US/docs/Web/API/Element/setPointerCapture) |
| Esc 回退、双击 50/50、超过 82% 自动收起 | 可选产品约定，不是 APG 要求。采用拖动期取消/恢复的思路；默认比例、最小宽度和收起规则由内容及项目决定 | [W3C Window Splitter](https://www.w3.org/WAI/ARIA/apg/patterns/windowsplitter/) |
| 拖动可用即可 | 补充方向键和有名称/值的可聚焦分隔器；另提供无需拖动的点按替代。APG 此模式仍标有待审查说明，WCAG 拖动要求与键盘要求分别验证 | [W3C APG](https://www.w3.org/WAI/ARIA/apg/patterns/windowsplitter/)、[W3C 2.5.7](https://www.w3.org/WAI/WCAG22/Understanding/dragging-movements) |
| 长文件名中间省略、后缀保留 | 作为文件识别策略采用，不是所有文本的通用省略规则；CSS ellipsis 不能自动保留后缀，完整名称及真实文件元数据须保留 | [MDN text-overflow](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Properties/text-overflow) |

边框只套一层、同心圆角属于视觉方案，统一记录在 UI 导航的 `references/visual-motion.md`，不在此复制。

选题追溯：[用户指定的聊天与桌面细节视频](https://www.douyin.com/video/7699520911870856483)。该链接只用于追溯待核实主张；本技能未安装或执行作者另行推荐的代码、仓库或工具。
