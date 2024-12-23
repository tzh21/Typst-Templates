// main 表示通用字体
// mono 表示代码字体
#let default_font = (
  main: "PingFang SC",
  mono: "Menlo",
)

#let special_block(color, title, body) = {
  block(
    fill: color,
    width: 100%,
    inset: 8pt,
    radius: (top: 8pt, bottom: 0pt),
    stroke: color,
    sticky: true,
    breakable: false,
  )[
    #set heading()
    #set text(fill: white)
    ==== #title
  ]
  v(0em, weak: true)
  block(
    width: 100%,
    inset: 8pt,
    radius: (top: 0pt, bottom: 8pt),
    stroke: color,
    body,
    breakable: true,
  )
}

#let qblock(title, body) = special_block(lime.darken(20%), title, body)

#let ablock(body) = special_block(aqua.darken(30%), "解答", body)

#let assignment_class(title, author, course_id, body) = {
  set document(title: title, author: author)
  
  // 普通字体
  set text(font: default_font.main)

  // 代码格式
  let code_bg_color = gray.lighten(90%)
  show raw: set text(font: (default_font.mono, default_font.main))
  // 行内代码
  show raw.where(block: false): box.with(
    fill: code_bg_color,
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )
  // 代码块
  show raw.where(block: true): block.with(
    fill: code_bg_color,
    inset: 8pt,
    radius: 4pt,
  )

  // 页眉和页脚
  set page(
    paper:"us-letter",
    header: context{
      if (counter(page).at(here()).first()==1) { none } 
      else if (counter(page).at(here()).first()==2) {   
        align(right, [*#author* | *#course_id | #title*])
      }
    },
    footer: context{
      let page_number = counter(page).at(here()).first()
      let total_pages = counter(page).final().last()
      align(center)[#page_number / #total_pages]
    }
  )

  set block(breakable: false)
  
  // 封面
  block(height:25%,fill:none)
  align(center, text(18pt)[*#course_id*])
  align(center, text(16pt)[*#title*])
  block(height:35%,fill:none)
  align(center, text(14pt)[*#author*])
  
  // 正文
  pagebreak(weak: false)
  body
}
