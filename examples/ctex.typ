#import "/lib.typ": *
#import templates.ctex.module: *

#show: template.with(style: "ctex")

#let total-page = context {
  counter(page).final().at(0)
}

#let TeX = {
  set text(font: "New Computer Modern")
  box(
    width: 1.8em,
    {
      set align(left)
      [T]
      place(top, dx: 0.56em, dy: 0.22em)[E]
      place(top, dx: 1.1em)[X]
    },
  )
}

#let LaTeX = {
  set text(font: "New Computer Modern")
  box(
    width: 2.55em,
    {
      set align(left)
      [L]
      place(top, dx: 0.3em, text(size: 0.7em)[A])
      place(top, dx: 0.7em)[#TeX]
    },
  )
}

#let sLaTeX = {
  // set text(font: "New Computer Modern Sans")
  set text(font: "New Computer Modern")
  box(
    width: 2.55em,
    {
      set align(left)
      [L]
      place(top, dx: 0.3em, text(size: 0.7em)[A])
      place(
        top,
        dx: 0.7em,
        box(
          width: 1.8em,
          {
            set align(left)
            [T]
            place(top, dx: 0.56em, dy: 0.22em)[E]
            place(top, dx: 1.1em)[X]
          },
        ),
      )
    },
  )
}

#let Arg(body) = {
  let body = text(font: "New Computer Modern", style: "italic", body)
  $angle.l body angle.r$
}

#let command(body) = {
  pad(
    left: 2em,
    block(fill: rgb("#f2f2ff"), inset: 5pt, body),
  )
}

= #LaTeX 的基本概念

#intro[
  　　欢迎使用 #sLaTeX！本章开头用简短的篇幅介绍了 #sLaTeX 的来源，然后介绍了 #sLaTeX 源代码的写法，编译 #sLaTeX 源代码生成文档的方法，以及理解接下来的章节的一些必要知识。
]

== 概述

=== #TeX

#TeX 是高德纳 (Donald E.~Knuth) 为排版文字和数学公式而开发的软件。1977 年，正在编写《计算机程序设计艺术》的高德纳意识到每况愈下的排版质量将影响其著作的发行，为扭转这种状况，他着手开发 #TeX，发掘当时刚刚用于出版工业的数字印刷设备的潜力。1982 年，高德纳发布 #TeX 排版引擎，而后在 1989 年又为更好地支持 8-bit 字符和多语言排版而予以改进。#TeX 以其卓越的稳定性、跨平台能力和几乎没有 bug 的特性而著称。它的版本号不断趋近于 $pi$，当前为 3.141592653。

#TeX 读作“Tech”，与汉字“泰赫”的发音相近，其中“ch” 的发音类似于“h”。#TeX 的拼写来自希腊词语 τεχνική (technique，技术) 开头的几个字母，在 ASCII 字符环境中写作 `TeX`。


=== #LaTeX

#LaTeX 是一种使用 #TeX 程序作为排版引擎的格式（format），可以粗略地将它理解成是对 #TeX 的一层封装。#LaTeX 最初的设计目标是分离内容与格式，以便作者能够专注于内容创作而非版式设计，并能以此得到高质量排版的作品。#LaTeX 起初由 Leslie Lamport 博士开发，目前由 #LaTeX 工作组abc#footnote[https://www.latex-project.org]进行维护。

#LaTeX 读作“Lah-tech” 或者“Lay-tech”，与汉字“拉泰赫”或“雷泰赫”的发音相近，在 ASCII 字符环境写作 `LaTeX`。#LaTeX;$2 epsilon$ 是 #LaTeX 的当前版本，意思是超出了第二版，但还远未达到第三版，在 ASCII 字符环境写作 `LaTeX2e`。


=== #LaTeX 的优缺点

经常有人喜欢对比 #LaTeX 和以 Microsoft Office Word 为代表的“所见即所得”（What You See Is What You Get）字处理工具。这种对比是没有意义的，因为 #TeX 是一个排版引擎，#LaTeX 是其封装，而 Word 是字处理工具。二者的设计目标不一致，也各自有自己的适用范围。

不过，这里仍旧总结 #LaTeX 的一些优点：

- 具有专业的排版输出能力，产生的文档看上去就像“印刷品”一样。

- 具有方便而强大的数学公式排版能力，无出其右者。

- 绝大多数时候，用户只需专注于一些组织文档结构的基础命令，无需（或很少）操心文档的版面设计。

- 很容易生成复杂的专业排版元素，如脚注、交叉引用、参考文献、目录等。

- 强大的可扩展性。世界各地的人开发了数以千计的 #LaTeX 宏包用于补充和扩展 #LaTeX 的功能。一些常用宏包列在了本手册附录中的 @sec:pkg-list 小节。更多的宏包参考 _The #LaTeX companion_。

- 能够促使用户写出结构良好的文档——而这也是 #LaTeX 存在的初衷。

- #LaTeX 和 #TeX 及相关软件是跨平台、免费、开源的。无论用户使用的是 Windows，macOS（OS X），GNU/Linux 还是 FreeBSD 等操作系统，都能轻松获得和使用这一强大的排版工具，并且获得稳定的输出。

　　#LaTeX 的缺点也是显而易见的：

- 入门门槛高。本手册的副标题叫做“#total-page 分钟了解 #LaTeX;2$ε$”，实际上“#total-page”是本手册正文部分（包括附录）的页数。如果真的以平均一页一分钟的速度看完了本手册，你只是粗窥门径而已，离学会它还很远。

- 不容易排查错误。#LaTeX 作为一个依靠编写代码工作的排版工具，其使用的宏语言比 #box[C++] 或 Python 等程序设计语言在错误排查方面困难得多。它虽然能够提示错误，但不提供调试的机制，有时错误提示还很难理解。

- 不容易定制样式。#LaTeX 提供了一个基本上良好的样式，为了让用户不去关注样式而专注于文档结构。但如果想要改进 #LaTeX 生成的文档样式则是十分困难的。

- 相比“所见即所得”的模式有一些不便，为了查看生成文档的效果，用户总要不停地编译。

=== 命令行基础

#LaTeX 和 #TeX 及相关软件大多仅提供了命令行接口，而不像 Word、Adobe InDesign 一样有图形用户界面。命令行程序的结构往往比较简单，它们接受用户输入，读取相关文件，进行一些操作和运算后输出目标文件，有时还会将提示信息、运行结果显示在屏幕上。在 Windows 系统上，如需进入命令行，可在开始菜单中搜索“命令提示符”，也可在“运行”窗口中输入 `cmd` 打开；Linux 或 macOS 等 \*nix#footnote[类 Unix 操作系统，包含 Linux、macOS（OS X）。]系统中可搜索“Terminal”打开终端。部分系统也提供了一些快捷方式，具体请参考相关手册。

与常规软件类似，命令行程序也都是可执行程序，在 Windows 上后缀名为 `.exe`，而在类 Unix 系统上则需要带有 `x` 权限。在大多数命令行环境中，系统会根据*环境变量* `PATH` 中存储的路径来搜索可供执行的程序。因此在运行之前，需确保 #LaTeX、#TeX 及相关程序所在路径已包含在 `PATH` 中。

在命令行中运行程序时，需要先输入程序名，其后可加一系列用空格分隔的参数，并按下 Enter 键执行。一般情况下，命令行程序执行完毕会自行退出。若遇到错误或中断，可输入 Ctrl+C 以强制结束。

使用命令行程序输入、输出文件时，需确保文件路径正确。通常需要先切换到文件所在目录，再执行有关程序。
切换路径可以执行

#command[
  `cd` #Arg[path]
]

注意 #Arg[path] 中的多级目录在 Windows 系统上使用反斜线 `\` 分隔，而在类 Unix 系统上使用正斜线 `/` 分隔。如果 #Arg[path] 中带有空格，则需加上引号 `"`。此外，在 Windows 系统上如果要切换到其他分区，还需加上 `/d` 选项，例如 `cd /d "C:\Program Files (x86)\"`。

许多用户会使用 TeXworks 或 TeXstudio 等编辑器来编写 #LaTeX 文档。这些编辑器提供的编译功能，实际上只是对特定命令行程序的封装，而并非魔法。


= 附录

== 某个节

=== 某个小节 <sec:pkg-list>
