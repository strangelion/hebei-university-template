# 大学论文 Typst 模板

一个为本科生毕业论文设计的 Typst 排版模板。它基于中文学术规范，帮助使用者快速完成论文的封面、章节和参考文献排版，让使用者专注于写作本身。

特点

· 简洁写作：全程使用标记式语法，告别复杂的 LaTeX 命令。
· 符合学术规范：内置了中文论文标准格式（封面、各级标题、图表编号等）。
· 快速渲染：基于 Typst 引擎，实时编译，所见即所得。
· 完整的章节结构：预设了从“摘要”到“致谢”的完整文档框架。
· 参考文献支持：集成 GB/T 7714 中文国标引用样式。

使用方法

1. 环境准备

本项目需要安装 Typst。它提供本地编译与在线编辑两种使用方式：

· 本地安装：
  · Windows：从 GitHub Releases 下载 typst-x86_64-pc-windows-msvc.zip，解压后将路径添加到系统 PATH。
  · macOS/Linux：可以使用包管理器（如 Homebrew、APT、Pacman）进行安装，也可以使用 Rust 的 Cargo 工具通过 cargo install typst-cli 命令安装。
  · 验证安装：在终端中输入 typst -V，若显示版本号则说明安装成功。
  · VSCode 插件（推荐）：在 VSCode 扩展商店中搜索并安装 “Tinymit Typst”。它会在你保存代码时自动刷新 PDF 预览，带来类似 Typora 的写作体验。

2. 获取模板

你可以选择以下任一方式：

· 下载 ZIP：直接下载本项目代码并解压。
· 克隆仓库：
  ```bash
  git clone https://github.com/strangelion/university-typst-template.git
  ```

3. 编译论文

进入项目目录后，执行编译命令即可生成 PDF 文件：

```bash
cd university-typst-template
typst compile main.typ paper.pdf
```

若你安装了 VSCode 插件，打开 main.typ 文件后，插件会自动启动预览服务。之后你可以在浏览器中实时查看论文排版效果。

项目结构

```
university-typst-template/
├── main.typ           # 论文入口文件，用于引入模板并管理各章节
├── template.typ       # 核心样式模板，控制全文字体、字号、间距与封面排版[reference:4]
├── abstract.typ       # 论文摘要内容
├── acknowledgments.typ# 致谢部分
├── chapter*.typ       # 论文各章节（1至6章），具体内容可参考“绪论”示例[reference:5]
├── references.yml     # 参考文献数据源（YAML格式）[reference:6]
├── logo.png           # 封面校徽图片[reference:7]
├── fonts/             # 存放自定义字体文件的目录[reference:8]
├── typst.toml         # 配置文件，用于设置自定义字体路径（如“fonts”目录）[reference:9]
└── LICENSE            # 项目许可证
```

配置说明

你可以在 main.typ 文件中修改论文的基本信息：

```typst
#show: doc => conf(
  heading: "本科毕业设计",    // 论文封面大标题
  title: "论文题目",          // 论文具体题目
  author: "作者姓名",         // 作者名
  student-id: "学号",        // 学号
  major: "专业名称",          // 专业
  advisor: "指导教师姓名",    // 指导教师
  date: "2026年 06月 01日", // 提交日期
  doc,
)
```

所有个人信息在这里只需修改一次，即可在封面和信息表格中全局生效。

参考文献

模板默认使用 GB/T 7714-2015 中文国标引用样式（numeric）。你只需要在references.bib(references.yml默认关闭) 文件中填入文献信息，并在正文中使用 #cite 引用即可。

贡献指南

欢迎提交 Pull Request 或 Issue 来完善这个模板！无论是修复 Bug、改进样式还是补充文档，都感激不尽。

许可证

该项目基于 MIT 许可证开源。
