\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uqtrcours}[2019/08/01 Exam]
%\LoadClass[xcolor=svgnames,t,aspectratio=169]{beamer}
\LoadClassWithOptions{beamer}
\RequirePackage{uqtrbase}



\AtBeginDocument{
  \institute[UQTR]{\includegraphics[height=16mm]{h-UQTR.png}}
  }


% Footnote full citations
\RequirePackage[citestyle=authoryear-ibid,bibstyle=authoryear,%
            labelyear=true,backend=biber,isbn=false,%
            maxcitenames=2,%
            firstinits=true,% Abbreviate first names.
            url=false,doi=false,eprint=false]{biblatex}
%\AtEveryCitekey{\clearfield{title}}  % Do not show title in citations
\renewbibmacro{in:}{} % Do not precede journal by "In:"
\AtEveryCitekey{\clearlist{language}}  % Do not show language

%\RequirePackage{amssymb}
%\RequirePackage{amsmath}
%\RequirePackage{amsthm}
%\RequirePackage{mathrsfs}
%\RequirePackage{mathptmx}
%\RequirePackage{newtxtext}
\RequirePackage{newtxmath}

% Distinguish between v and nu
% FIXME If I do that, then I cannot use a bold v in math mode!
%\DeclareSymbolFont{CMletters}{OML}{cmm}{m}{it}
%\DeclareMathSymbol{\nu}{\mathord}{CMletters}{23}
%\DeclareMathSymbol{v}{\mathord}{CMletters}{`v}

\RequirePackage{tabularx}

\RequirePackage{bm}
\RequirePackage{graphicx}
\RequirePackage{braket}
%\RequirePackage{indent}
%\RequirePackage{natbib}


\RequirePackage{datetime}
\newdateformat{monthyeardate}{%
  \monthname[\THEMONTH] \THEYEAR}
\let\oldtoday\today
\renewcommand{\today}{\monthyeardate\oldtoday}

%========== Preample ==========
%== Style ==
%\usetheme{CambridgeUS}
%\usetheme{Berkeley}
%\usetheme{Boadilla}
%\usetheme{Madrid}
%\usetheme{Frankfurt}
\usetheme{Rochester}

%== Color ==
%
\RequirePackage{uqtrbeamercolors}

%== Some Beamer elements ==
\setbeamertemplate{sections/subsections in toc}[square]
\setbeamerfont{section number projected}{family=\rmfamily,series=\bfseries,size=\normalsize}
%\setbeamercolor{section number projected}{bg=BluerSlate,fg=white}
%\setbeamercolor{enumerate subitem} {fg=BluerSlate}

\setbeamertemplate{enumerate item}[square]
\setbeamertemplate{itemize item}[square]  
\setbeamertemplate{itemize subitem}[triangle]  
\setbeamertemplate{navigation symbols}{}  % No navigation icons

% slide counter
\setbeamertemplate{footline}[frame number]
\setbeamerfont{page number in head/foot}{size=\large}  % Add page number

%\RequirePackage{enumitem}
%\setlist[itemize,〈levels〉]{〈format〉}
%\setlist[itemize]{label=\color{BerkeleyBlue}{$\blacksquare$}}
%\setlist[itemize, 2]{label=\color{BerkeleyBlue}{$\blacksquare$}}


%\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{textpos}
%\setbeamercovered{invisible}


\addtobeamertemplate{frametitle}{}{%
\begin{textblock*}{20mm}(.93\textwidth,-1.4cm)
  \includegraphics[height=13mm]{v-UQTR-r.png}
\end{textblock*}%
}


%\addtobeamertemplate{headline}{}{%
%\begin{tikzpicture}[remember picture,overlay]
%\node at([shift={(.25\paperwidth,-.42)}]current page.north) {\includegraphics[height=.5cm,width=.7cm]{v-UQTR-r.png}};
%\end{tikzpicture}}






%== Fonts ==
\RequirePackage{helvet}
\usefonttheme[onlymath]{serif}

%\defaultfontfeatures{Mapping=tex-text} 
%\usefonttheme{serif}
%\setmainfont{Coolvetica}

%\setbeamerfont{title}      {family=\rmfamily}
%\setbeamerfont{subtitle}   {family=\rmfamily}
%\setbeamerfont{normal text}{family=\rmfamily}
%\setbeamerfont{frametitle} {family=\rmfamily}
%\setbeamerfont{block title}{family=\rmfamily}
%\setbeamerfont{block body} {family=\rmfamily}

%== Some more text arrangement ==
\setbeamersize{text margin left=5mm} 
\setbeamersize{text margin right=5mm} 


% =========================== %
% Macro
% =========================== %
\newenvironment{reference}[2]
 {\begin{textblock*}{\textwidth}(#1,#2)
   \tiny\it\bgroup\color{BluerSlate!50!black}}
 {\egroup\end{textblock*}}

\newenvironment<>{sblock}[2]
 {\begin{center}\begin{minipage}{#1\linewidth}\begin{block}{#2}}
 {\end{block}\end{minipage}\end{center}}

\newenvironment{mytable}[3]
 {\begin{sblock}{#1}{#2}\begin{tabular}{#3}}
 {\end{tabular}\end{sblock}}

\newcommand{\twocol}[4]{
  \begin{minipage}{#1\textwidth}
    {#3}
  \end{minipage}
  \hfill
  \begin{minipage}{#2\textwidth}
    {#4}
  \end{minipage}
  }

\newcommand{\mysplit}[5]{
  %\hfill
  \begin{minipage}[c][#1\textheight][t]{#2\textwidth}{#4}\end{minipage}
  \hfill
  \begin{minipage}[c][#1\textheight][t]{#3\textwidth}{#5}\end{minipage}
  %\hfill
  }

\newcommand{\mysplitapart}[5]{
  \begin{minipage}[c][#1\textheight][t]{#2\textwidth}{#4}\end{minipage}
  \hfill
  \begin{minipage}[c][#1\textheight][t]{#3\textwidth}{#5}\end{minipage}
  }

\newcommand{\mysplitc}[5]{
  \begin{minipage}[c][#1\textheight][c]{#2\textwidth}{#4}\end{minipage}
  \hfill
  \begin{minipage}[c][#1\textheight][c]{#3\textwidth}{#5}\end{minipage}
  }

\newcommand{\threewaysplit}[7]{
  \begin{minipage}[c][#1\textheight][t]{#2\textwidth}{#5}\end{minipage}
  \hfill
  \begin{minipage}[c][#1\textheight][t]{#3\textwidth}{#6}\end{minipage}
  \hfill
  \begin{minipage}[c][#1\textheight][t]{#4\textwidth}{#7}\end{minipage}
  }

\newcommand{\fourwaysplit}[9]{
  \begin{minipage}[c][#1\textheight][t]{#2\textwidth}{#6}\end{minipage}
  \hfill
  \begin{minipage}[c][#1\textheight][t]{#3\textwidth}{#7}\end{minipage}
  \hfill
  \begin{minipage}[c][#1\textheight][t]{#4\textwidth}{#8}\end{minipage}
  \hfill
  \begin{minipage}[c][#1\textheight][t]{#5\textwidth}{#9}\end{minipage}
  }


% This is to have the backup slides
% out of the slide counter
\newcommand{\beginbackup}
  {\newcounter{framenumbervorappendix}\setcounter{framenumbervorappendix}{\value{framenumber}}}
\newcommand{\backupend}
  {\addtocounter{framenumbervorappendix}{-\value{framenumber}}
   \addtocounter{framenumber}{\value{framenumbervorappendix}}}

% This is to remove the institute from the footer
%\makeatletter
%\setbeamertemplate{footline}
%{
%  \leavevmode%
%  \hbox{%
%  \begin{beamercolorbox}[wd=.333333\paperwidth,ht=2.25ex,dp=1ex,center]{author in head/foot}%
%    \usebeamerfont{author in head/foot}\insertshortauthor%~~\beamer@ifempty{\insertshortinstitute}{}{(\insertshortinstitute)}
%  \end{beamercolorbox}%
%  \begin{beamercolorbox}[wd=.333333\paperwidth,ht=2.25ex,dp=1ex,center]{title in head/foot}%
%    \usebeamerfont{title in head/foot}\insertshorttitle
%  \end{beamercolorbox}%
%  \begin{beamercolorbox}[wd=.333333\paperwidth,ht=2.25ex,dp=1ex,right]{date in head/foot}%
%    \usebeamerfont{date in head/foot}\insertshortdate{}\hspace*{2em}
%    \insertframenumber{} / \inserttotalframenumber\hspace*{2ex} 
%  \end{beamercolorbox}}%
%  \vskip0pt%
%}
%\makeatother


\newcommand{\mycite}[1]{{\footnotesize #1}}


% This columntype creates transparent columns
% on the slides specified by the argument. e.g. T{2,3,4}
\RequirePackage{array}
\newcommand{\transon}[1]{\only<#1| handout:0>{\color{Trans}}}
\newcolumntype{T}[1]{>{\raggedright\transon{#1}}c}

\renewcommand{\sectionpage}{%
  \vfill
  \centering
  \begin{beamercolorbox}[sep=8pt,center,shadow=true,rounded=true]{title}
    %\usebeamerfont{title}\thesection. \secname\par%
    \usebeamerfont{title} \secname\par%
  \end{beamercolorbox}
  \vfill
  }


%\AtBeginSection{
%  \frame{\sectionpage}
%  }


% Reset footnote counter for each slide
\RequirePackage{etoolbox}
\BeforeBeginEnvironment{frame}{\setcounter{footnote}{0}}



\RequirePackage[most]{tcolorbox}

%\setbeamersize{text margin left = -5pt, text margin right = -5pt}

\definecolor{BerkeleyBlue}{HTML}{003262}                                                                                                                         
\definecolor{WellmanTile}{HTML}{D9661F}
\newtcolorbox{mybox}[2][]{%
    colback=bg, 
    colframe=BerkeleyBlue!75!black,
    fonttitle=\bfseries\footnotesize,
    coltitle=black!75!black, 
    colbacktitle=bg,
    enhanced,
    attach boxed title to top center={yshift=-3mm},
  title=#2,
  #1}

\newtcolorbox{myboxhl}[2][]{%
    colback=bg, 
    colframe=WellmanTile!75!black,
    fonttitle=\bfseries\footnotesize,
    coltitle=black!75!black, 
    colbacktitle=bg,
    enhanced,
    %attach boxed title to top left={yshift=-1.2mm, xshift=2mm},
    attach boxed title to top center={yshift=-3mm},
  title=#2,
  #1}

\newcommand{\quickcite}[1]{\color{darkgray}{\tiny #1}}
\newcommand{\myfullcite}[1]{{\tiny \linespread{0.5}\selectfont \fullcite{#1}}}
\newcommand{\myformat}{\bf \small}

%\preto\fullcite{\tiny}

\newlength{\imwidth}
\setlength{\imwidth}{4cm}
\newlength{\imheight}
\setlength{\imheight}{3cm}

\definecolor{lightergray}{gray}{0.95}



\newcommand{\PutTitlePageLogoUQTR}{\institute[UQTR]{\includegraphics[height=16mm]{h-UQTR.png}}}



% Hyperlinks
\hypersetup{
    colorlinks=false,  % false: boxed links; true: colored links
    linkcolor=blue,   % color of internal links
    citecolor=blue,   % color of links to bibliography
    filecolor=black,  % color of file links
    urlcolor=blue     % color of external links
  }

