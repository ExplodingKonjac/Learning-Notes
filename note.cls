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
\RequirePackage{physics2}

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

\newtheorem{property}{性质}[section]
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

\newenvironment{solution}
	{\begin{proof}[解]\let\qed\relax}
	{\end{proof}}

\undef\AddTCB

% math definitions

% constants
\newcommand{\E}{\mathrm{e}}
\newcommand{\I}{\mathrm{i}}

% linear algebra
\newcommand{\vect}[1]{\boldsymbol{#1}}
\newcommand{\matr}[1]{\boldsymbol{#1}}

% calculus
\newcommand{\dif}{\mathrm{d}}

% some functions
\newcommand{\sgn}{\operatorname{sgn}}
\newcommand{\lcm}{\operatorname{lcm}}
\newcommand{\bitnot}{\operatorname{NOT}}
\newcommand{\bitand}{\operatorname{AND}}
\newcommand{\bitor}{\operatorname{OR}}
\newcommand{\bitxor}{\operatorname{XOR}}
\newcommand{\bitnand}{\operatorname{NAND}}
\newcommand{\bitnor}{\operatorname{NOR}}
\newcommand{\bitnxor}{\operatorname{NXOR}}

% probability theory
\newcommand{\expect}[1]{\operatorname{\mathbb{E}}\left[#1\right]}
\newcommand{\var}[1]{\operatorname{Var}\left(#1\right)}
\newcommand{\cov}[2]{\operatorname{Cov}\left(#1, #2\right)}
\newcommand{\prob}[1]{\operatorname{\mathbb{P}}\left(#1\right)}

% paired delimiters
\DeclarePairedDelimiter{\floor}{\lfloor}{\rfloor}
\DeclarePairedDelimiter{\ceil}{\lceil}{\rceil}
\DeclarePairedDelimiter{\abs}{\lvert}{\rvert}
\DeclarePairedDelimiter{\norm}{\lVert}{\rVert}
