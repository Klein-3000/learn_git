# color
## green
> [!success] 成功(success)

## blue
> [!info] 信息(info)

> [!note] 笔记(note)

> [!todo]

## yellow
> [!warning] 警告(warning)

> [!question] 问题(question)

## red
> [!failure] 失败(failure)

> [!danger] 危险(danger)

> [!bug] bug

## blue-green
>[!tip] 提示(tip)

> [!summary] 总结(summary)

## grey
> [!quote] 引用(quote)

## purple
> [!example] 例子(example)

# custom-callout
```css
.callout[date-callout="警告"] {
--callout-color:0,0,0;
--callout-icon:lucide-alert-citcle
}
```
## attribute
- `data-callout` 属性的值是要使用的类型标识符，例如 `[！警告]。`
- `--callout-color` 使用数字 （0–255） 定义红色、绿色和蓝色的背景颜色。
- `--callout-icon` 可以是 lucide.dev 中的图标 ID，也可以是 SVG 元素。