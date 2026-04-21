// 论文基本信息配置,请根据实际情况修改以下字段的值，并设置对应的可见性（visible）为 true 或 false。
#let conf = (
  // 论文基本信息
  head: "主标题",
  head_visible: true,
  // 副标题
  title: "副标题",
  title_visible: true,
  // 英文标题
  title_en: "English Title",
  title_en_visible: false,
  // 学校信息
  school: "XX大学",
  school_visible: false,
  // 学院信息
  college: "社会科学与技术学院",
  college_visible: false,
  // 作者信息
  author: "张三",
  author_visible: true,
  // 学号
  student_id: "1145141314",
  student_id_visible: true,
  // 专业
  major: "宇宙社会学",
  major_visible: true,
  // 指导教师
  supervisor: "罗教授",
  supervisor_visible: true,
  // 日期（自动生成当前年份）
  date: datetime.today().display("[year]年[month]月[day]日"),
)
