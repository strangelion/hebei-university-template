set text(lang: "zh", region: "cn")
// 定义一个辅助函数：将字符串拆分并插入 1fr 间距实现两端对齐
#let justify-text(body) = {
  if type(body) != str { return body }
  let chars = body.clusters()
  let n = chars.len()
  if n < 2 { return body }
  for (i, char) in chars.enumerate() {
    char
    if i < n - 1 { h(1fr) }
  }
}

#let template(
  doc,
  head: "",
  head_visible: none,
  title: "",
  title_visible: none,
  title_en: "",
  title_en_visible: none,
  // 学校信息
  school: "",
  school_visible: none,
  college: "",
  college_visible: none,
  // 作者信息
  author: "",
  author_visible: none,
  student_id: "",
  student_id_visible: none,
  major: "",
  major_visible: none,
  // 指导教师
  supervisor: "",
  supervisor_visible: none,
  date: "",
) = {
  // 1. 页面设置
  set page(
    paper: "a4",
    margin: (top: 3cm, bottom: 3cm, left: 2.5cm, right: 2.5cm),
  )

  // 2. 基础字体和段落设置
  set text(font: ("Times New Roman", "simsun"), size: 12pt)
  set par(leading: 1em, first-line-indent: 2em, justify: true)

  // 3. 封面生成
  align(center)[
    #v(2cm)
    #image("resource/logo.png", width: 80%)
    #v(1cm)
    #if head_visible {
      text(size: 26pt, weight: "bold")[#head]
      v(2cm)
    }
    #if title_visible {
      text(size: 22pt, weight: "bold")[#title]
      v(1cm)
    }
    #if title_en_visible {
      text(size: 18pt)[#title_en]
      v(2cm)
    }
    #v(1fr)

    // 1. 先测量所有信息的宽度，找出最大宽度
    #context {
      let field-map = (
        school: (school, school_visible),
        college: (college, college_visible),
        author: (author, author_visible),
        "student-id": (student_id, student_id_visible),
        major: (major, major_visible),
        supervisor: (supervisor, supervisor_visible),
      )
      let visible-values = field-map.values().filter(((_, visible)) => visible).map(((field, _)) => field)
      let max-width = if visible-values.len() > 0 {
        let widths = visible-values.map(f => measure(block(width: auto, text(size: 14pt)[#f])).width)
        calc.max(..widths) + 20pt
      } else {
        0pt
      }

      // 2. 重新定义 info-row
      let info-row(label, value) = {
        grid(
          columns: (80pt, max-width),
          column-gutter: 0pt,
          align: (right + horizon, center + horizon),
          text(weight: "bold", size: 14pt)[#label],
          block(width: 100%, stroke: (bottom: 1pt), inset: (bottom: 4pt))[
            #set text(size: 14pt)
            #justify-text(value)
          ],
        )
      }
      v(1fr)

      if school_visible {
        info-row("学　　校：", school)
        v(1.5em)
      }
      if college_visible {
        info-row("学　　院：", college)
        v(1.5em)
      }
      if author_visible {
        info-row("学生姓名：", author)
        v(1.5em)
      }
      if student_id_visible {
        info-row("学　　号：", student_id)
        v(1.5em)
      }
      if major_visible {
        info-row("专　　业：", major)
        v(1.5em)
      }
      if supervisor_visible {
        info-row("指导教师：", supervisor)
        v(1.5em)
      }

      v(1fr)
    }

    #v(1fr)
    #text(size: 14pt)[#date]

  ]

  pagebreak()

  // 4. 章节标题格式设置 (等同于 ctexset)
  set heading(numbering: "1.1")

  show heading: it => {
    set text(weight: "bold")
    if it.level == 1 {
      // 一级标题：第X章，居中，三号字(16pt)
      let num = if it.numbering != none {
        numbering("1", ..counter(heading).at(it.location()))
      }
      pagebreak(weak: true)
      v(15pt)
      align(center)[
        #text(size: 16pt)[
          #(if num != none { "第" + num + "章　" })
          #it.body
        ]
      ]
      v(20pt)
    } else if it.level == 2 {
      // 二级标题：四号字(14pt)
      text(size: 14pt)[#it]
    } else if it.level == 3 {
      // 三级标题：小四号(12pt)
      text(size: 12pt)[#it]
    } else {
      it
    }
  }

  // 设置图表自动按章节编号：(一级章节号)-(图表序号)
  set figure(numbering: n => {
    let h1 = counter(heading).at(here()).at(0)
    numbering("1-1", h1, n)
  })

  // 每一级标题（第X章）出现时，重置图表计数器
  show heading.where(level: 1): it => {
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    it
  }

  // 设置图表名称的样式
  show figure.where(kind: image): set figure(supplement: [图])
  show figure.where(kind: table): set figure(supplement: [表])

  // 设置图表标题的间隔符，例如“图 1-1：标题”
  show figure.caption: it => [
    #set text(size: 10.5pt, font: ("Times New Roman", "SimSun"))
    #it.supplement #context it.counter.display(it.numbering) ：#it.body
  ]

  // 目录样式修正
  show outline.entry.where(level: 1): it => {
    v(12pt, weak: true)
    strong(it)
  }

  doc
}
