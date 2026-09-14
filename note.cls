\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{note}

% Package requirements
\LoadClass[10.5pt]{ctexbook}
\RequirePackage{xeCJK,xeCJKfntef}
\RequirePackage{array}
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{arydshln}
\RequirePackage{mathrsfs}
\RequirePackage{yhmath}
\RequirePackage{geometry}
\RequirePackage{titling}
\RequirePackage{titlesec}
\RequirePackage{zhnumber}
\RequirePackage{fontspec}
\RequirePackage{enumitem}
\RequirePackage{tabularx}
\RequirePackage{makecell}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{tikz}
\usetikzlibrary{intersections}
\RequirePackage{xcolor}
\RequirePackage[most]{tcolorbox}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{float}
\RequirePackage{caption}
\RequirePackage{keyval}
\RequirePackage{pgfplots}
\RequirePackage{pgfkeys}
\RequirePackage{ifplatform}
\RequirePackage{mathtools}
\RequirePackage{physics}
\RequirePackage{physics2}
\RequirePackage{etoolbox}
\RequirePackage{diagbox}
\RequirePackage{subcaption}
\RequirePackage{esint}
\RequirePackage{minted}

% Define page layout
\geometry{a4paper,bottom=20mm,top=25mm,left=20mm,right=20mm}

% fonts
\ifwindows
	\setCJKmainfont[BoldFont={SimHei},ItalicFont={KaiTi}]{SimSun}
\elifmacos
	\setCJKmainfont[BoldFont={Heiti SC}, ItalicFont={Kaiti SC}]{Songti SC}
\else
	\setCJKmainfont[BoldFont={Noto Sans CJK SC}, ItalicFont={AR PL UKai CN}]{Noto Serif CJK SC}
\fi

% Define header and footer
\fancypagestyle{notestyle}{
    \fancyhf{}
	\fancyhead[L]{\footnotesize\leftmark}
	\fancyhead[C]{\footnotesize\@title}
	\fancyhead[R]{\footnotesize\rightmark}
	\fancyfoot[C]{\footnotesize 第 \thepage 页 \hspace{2em} 共 \pageref{LastPage} 页}
	\renewcommand{\headrulewidth}{0.4pt}
	\renewcommand{\footrulewidth}{0.4pt}
}
\fancypagestyle{plain}{
    \fancyhf{}
	\fancyhead[C]{\footnotesize\@title}
	\fancyfoot[C]{\footnotesize 第 \thepage 页 \hspace{2em} 共 \pageref{LastPage} 页}
    \renewcommand{\headrulewidth}{0.4pt}
    \renewcommand{\footrulewidth}{0.4pt}
}
\pagestyle{notestyle}

% Define title format
\renewcommand{\maketitle}{
	\centering
	\vspace*{2cm}
	{\Huge \bfseries \@title \par}
	\vspace*{0.05\textheight}
	{\Large \itshape \@subtitle \par}
	\vfill
	{\large \@author \par}
	\vspace*{0.05\textheight}
	{\large \@date \par}
}
\newcommand{\subtitle}[1]{\def\@subtitle{#1}}

% Define section format
\titleformat{\chapter}[hang]
	{\normalfont\Huge\bfseries}
	{第\zhnum{chapter}章：}
	{1em}
	{\setcounter{section}{0}\Huge}
\titleformat{\section}
	{\LARGE\bfseries}
	{\thesection}
	{1em}
	{}
\titleformat{\subsection}
	{\Large\bfseries}
	{\thesubsection}
	{1em}
	{}
\titleformat{\subsubsection}
	{\normalsize\bfseries}
	{\thesubsubsection}
	{1em}
	{}

% Define theorem format
\def\AddTCB[#1]{
	\tcolorboxenvironment{#1}{
		breakable,
		enhanced jigsaw,
		boxrule=0.5pt,
		boxsep=5pt,
		colframe=black,
		colback=white!0!white
	}
}
\newtheorem{theorem}{定理}[section]
\AddTCB[theorem]

\newtheorem{lemma}[theorem]{引理}
\AddTCB[lemma]

\newtheorem{corollary}{推论}[theorem]
\AddTCB[corollary]

\newtheorem{property}[theorem]{性质}
\AddTCB[property]

\newtheorem{example}{例}[section]
\AddTCB[example]

\newtheorem{problem}{题}[section]
\AddTCB[problem]

\theoremstyle{definition}
\newtheorem{definition}{定义}[section]
\AddTCB[definition]

\theoremstyle{remark}
\newtheorem*{remark}{备注}
\AddTCB[remark]

\AtBeginEnvironment{proof}{\setlength{\parindent}{2em}}

\newenvironment{solution}{
	\begin{proof}[解]\let\qed\relax
}{
	\end{proof}
}

\undef\AddTCB

% code block settings
\usemintedstyle{vs}
\setminted{
    linenos,
    breaklines,
    autogobble,
    frame=lines,
    labelposition=topline,
    framerule=0.4pt,
    framesep=2mm,
    numbersep=0.8em,
}

\newlength{\mintednumspace}
\newlength{\mintednumleftpad}
\setlength{\mintednumleftpad}{0.3em}

\makeatletter

% 根据最大行号计算 gutter
\newcommand*\MintedLayoutSetNumSpace[1]{%
    \@tempcnta=\c@FancyVerbLine
    \c@FancyVerbLine=#1\relax
    \settowidth{\mintednumspace}{\theFancyVerbLine}%
    \c@FancyVerbLine=\@tempcnta
    \addtolength{\mintednumspace}{\FV@NumberSep}%
    \addtolength{\mintednumspace}{\mintednumleftpad}%
}

\makeatother


% 统计最终的 .highlight.minted 文件中的代码行数。
% Pygments 输出结构为：
%
% \begin{MintedVerbatim}[...]
% <code line 1>
% ...
% <code line n>
% \end{MintedVerbatim}
%
% 所以总行数减 2 即代码行数。
\ExplSyntaxOn

\ior_new:N \l__minted_layout_ior
\int_new:N \l__minted_layout_lines_int

\cs_new_protected:Npn \MintedLayoutCountHighlightedFile #1
  {
    \int_zero:N \l__minted_layout_lines_int

    \file_if_exist:nTF {#1}
      {
        \ior_open:Nn \l__minted_layout_ior {#1}

        \ior_str_map_inline:Nn \l__minted_layout_ior
          {
            \int_incr:N \l__minted_layout_lines_int
          }

        \ior_close:N \l__minted_layout_ior

        % 去掉 begin/end MintedVerbatim 两行
        \int_add:Nn \l__minted_layout_lines_int {-2}

        \int_compare:nNnT
          { \l__minted_layout_lines_int } < {1}
          {
            \int_set:Nn \l__minted_layout_lines_int {1}
          }

        \exp_args:Ne \MintedLayoutSetNumSpace
          { \int_use:N \l__minted_layout_lines_int }
      }
      {
        \MintedLayoutSetNumSpace{1}
      }
  }

\ExplSyntaxOff


\makeatletter

% 到最终 highlighted code 真正准备排版时才计算 gutter。
% minted 和 \inputminted 都会经过这里。
\pretocmd{\minted@codewrapper}{%
    \expandafter\MintedLayoutCountHighlightedFile
    \expandafter{\minted@highlightfilepath}%
}{}{%
    \PackageError{minted-layout}
      {Cannot patch \string\minted@codewrapper}{}
}

% breaklines=false
\patchcmd{\FV@ListProcessLine@NoBreak}
    {\FV@LeftListNumber}
    {\kern\mintednumspace\FV@LeftListNumber}
    {}{%
        \PackageError{minted-layout}
          {Cannot patch no-break layout}{}
    }

% breaklines=true
\patchcmd{\FV@ListProcessLine@Break}
    {\FV@LineWidth\linewidth}
    {%
        \kern\mintednumspace
        \FV@LineWidth\linewidth
        \advance\FV@LineWidth-\mintednumspace\relax
    }
    {}{%
        \PackageError{minted-layout}
          {Cannot patch break layout}{}
    }

\makeatother

% math definitions

% constants
\newcommand{\E}{\mathrm{e}}
\newcommand{\I}{\mathrm{i}}

% linear algebra
\newcommand{\vect}[1]{\boldsymbol{#1}}
\newcommand{\matr}[1]{\boldsymbol{#1}}
% \newcommand{\tr}{\operatorname{tr}}
\newcommand{\image}{\operatorname{Im}}
\newcommand{\transpose}[1]{{#1}^\top}
\newcommand{\diag}{\operatorname{diag}}

\ExplSyntaxOn
\NewDocumentCommand{\rvec}{m}{
	\ensuremath{\left[\,\clist_use:nn {#1} {,\,}\,\right]}
}
\NewDocumentCommand{\cvec}{m}{
	\ensuremath{
		\begin{bmatrix}
			\clist_use:nn {#1} { \\ }
		\end{bmatrix}
	}
}
\ExplSyntaxOff

% some functions
\newcommand{\sgn}{\operatorname{sgn}}
\newcommand{\lcm}{\operatorname{lcm}}
% \newcommand{\rank}{\operatorname{rank}}
\newcommand{\bitnot}{\operatorname{NOT}}
\newcommand{\bitand}{\operatorname{AND}}
\newcommand{\bitor}{\operatorname{OR}}
\newcommand{\bitxor}{\operatorname{XOR}}
\newcommand{\bitnand}{\operatorname{NAND}}
\newcommand{\bitnor}{\operatorname{NOR}}
\newcommand{\bitnxor}{\operatorname{NXOR}}

% probability theory
\newcommand{\expect}[1]{\operatorname{\mathbb{E}}\left[#1\right]}
\newcommand{\cov}[2]{\operatorname{Cov}\left(#1, #2\right)}
\newcommand{\prob}[1]{\operatorname{\mathbb{P}}\left(#1\right)}

\let\bbordermatrix\bordermatrix
\patchcmd{\bbordermatrix}{8.75}{4.75}{}{}
\patchcmd{\bbordermatrix}{\left(}{\left[}{}{}
\patchcmd{\bbordermatrix}{\right)}{\right]}{}{}

% paired delimiters
\newcommand{\floor}[1]{\left\lfloor #1 \right\rfloor}
\newcommand{\ceil}[1]{\left\lceil #1 \right\rceil}

% some texts
\newcommand{\lhs}{\text{LHS}}
\newcommand{\rhs}{\text{RHS}}
\newcommand{\origin}{\text{原式}}
