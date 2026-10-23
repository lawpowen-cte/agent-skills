# 组件边界与规则核实

核实日期：2026-10-24。按实际涉及的组件读取本表，不要求每次 UI 任务加载全部资料。

## 定义、行为与采用边界

| 模式 | 已核实的事实 | 本技能采用的处理与边界 | 官方依据 |
|---|---|---|---|
| Bottom Sheet | Android 提供模态底部面板及部分展开状态；Flutter 分别提供模态与非模态入口 | 先确定模态性，再选择内容高度、档位、手势和关闭方式；表单仍需未保存保护 | [Android 面板](https://developer.android.com/develop/ui/compose/components/bottom-sheets)、[部分展开](https://developer.android.com/develop/ui/compose/components/bottom-sheets-partial)、[Flutter 模态与非模态](https://api.flutter.dev/flutter/material/ModalBottomSheetRoute-class.html) |
| Action Sheet | Apple 定义为响应用户动作、提供相关选项的模态视图；呈现随系统与设备变化 | 少量动作选用平台原生模式；危险动作语义明确，取消方式按当前系统；不固定位置、红色值或按钮布局 | [Apple HIG](https://developer.apple.com/design/human-interface-guidelines/action-sheets)、[Apple UIKit 指南](https://developer.apple.com/documentation/uikit/getting-the-user-s-attention-with-alerts-and-action-sheets) |
| Snackbar | Android 定义为不打断任务的简短反馈，动作与时长可配置，Undo 是一个用例 | 有撤销需求且确实可恢复时才加动作；重要信息有持续可达入口，不抢焦点 | [Android Snackbar](https://developer.android.com/develop/ui/compose/components/snackbar) |
| AlertDialog | W3C 用于打断流程、传达简短重要信息并取得回应；键盘行为引用 Modal Dialog | Web 提供取消或关闭、焦点管理与 Esc 退出；取消不执行危险动作，未保存内容走统一保护流程 | [W3C AlertDialog](https://www.w3.org/WAI/ARIA/apg/patterns/alertdialog/)、[W3C Modal Dialog](https://www.w3.org/WAI/ARIA/apg/patterns/dialog-modal/) |
| Tour | Ant Design 提供产品引导组件，并支持不同遮罩与交互配置 | “可跳过、重入、目标缺失可恢复”是工程建议；不要用引导弥补看不懂的布局 | [Ant Design Tour](https://ant.design/components/tour/) |
| Lightbox | Lightbox 是媒体查看器模式名；Web 中的模态查看器可依据 Dialog 模式处理键盘与焦点 | 是否缩放、翻页由媒体任务决定；应用实现的拖动、多指或路径手势须按相应规则提供替代入口，注意必要功能等标准例外；滚轮缩放不是该模式的必要定义 | [W3C Modal Dialog](https://www.w3.org/WAI/ARIA/apg/patterns/dialog-modal/)、[W3C 拖动替代](https://www.w3.org/WAI/WCAG22/Understanding/dragging-movements)、[W3C 指针手势](https://www.w3.org/WAI/WCAG22/Understanding/pointer-gestures.html) |
| Inline error | W3C 表单指南提供错误状态、字段关联与动态通知方法 | 描述出错字段和修正方式；重新校验后更新，避免每敲一个字就强制打断读屏 | [W3C 表单通知](https://www.w3.org/WAI/tutorials/forms/notifications/)、[W3C 校验](https://www.w3.org/WAI/tutorials/forms/validation/) |

## 视频主张的处理

| 待核实主张 | 核实结论与写入决定 |
|---|---|
| 底部面板固定半屏或遵循统一“三分屏”高度 | 未找到通用标准依据。官方 API 支持不同状态；高度、吸附和关闭按内容、可用视口、键盘及目标平台决定。 |
| Action Sheet 必须在底部，取消按钮必须独立放在底部 | 不能跨系统通用。Apple 当前呈现可锚定到来源控件，popover 中的取消方式也有差异；沿用已安装平台组件。 |
| Snackbar 必须带 Undo | 不成立。官方动作是可选项，是否可撤销由业务恢复能力决定。 |
| 高危 AlertDialog 一律锁死遮罩和 Esc | 不采用。阻止点击遮罩意外关闭可以按业务设置；W3C 模态键盘模式支持 Esc 关闭，并建议可见关闭/取消控件，不能把取消解释成同意危险动作。 |
| 新功能上线都应弹 Tour | 只是选型建议，缺乏普遍必要性。只有上下文引导能解决实际理解问题时采用。 |
| Lightbox 必须滚轮缩放 | 只是功能选择。允许缩放时不应只依赖滚轮、拖动或多指手势。 |
| 字段错误只要改过输入就消失 | 修正：更新或清除应跟随相应校验结果；仅改变值不证明错误已解决，服务端错误需相应复核。 |

本表结论对应上节官方来源；“未找到通用标准依据”表示本次核实范围内未证实，不代表不能作为明确的产品约定。

## 选题追溯

用户指定作品：[原提示组件视频](https://www.douyin.com/video/7698358547440094502)、[组件补充视频](https://www.douyin.com/video/7698679307312303394)。仅记录主张来源，不采信其中的“大厂”“铁律”等措辞作为规范依据，也不推断它们代表任何平台全部实现。
