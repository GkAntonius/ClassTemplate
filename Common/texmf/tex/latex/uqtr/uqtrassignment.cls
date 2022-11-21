\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uqtrassignment}[2019/10/29 Assignment]
\LoadClassWithOptions{article}
\RequirePackage{uqtrbase}

\RequirePackage{placeins}
\RequirePackage{environ}
\RequirePackage{xifthen}
\RequirePackage{kvoptions}
\RequirePackage{amsmath}

% UQTR format and header
\RequirePackage[top=1in, bottom=1.00in, left=1.25in, right=1.25in]{geometry}


% Show solutions
\DeclareBoolOption[true]{solution}

% Document type (exercice, homework, lab, ...)
\DeclareStringOption [Document]{doclabel}[Document]


% ====================
\ProcessKeyvalOptions*
% ====================

\newif\ifsolution
\solutiontrue
\let\ifsolution\ifuqtrassignment@solution
%\solutionfalse

%\ifuqtrassignment@solution
%  \solutiontrue
%\else
%  \solutionfalse
%\fi


% Document label
\setdocumentlabel{\uqtrassignment@doclabel}






% Redefine these if you want to change the language
\newcommand{\problemlabel}{Problem}
\newcommand{\solutionlabel}{Solution}

\newcommand{\setproblemlabel}[1]{\renewcommand{\problemlabel}{#1}}
\newcommand{\setsolutionlabel}[1]{\renewcommand{\solutionlabel}{#1}}

% Let's set the default labels in French.
\setproblemlabel{Problème}


% Set up counters for problems and subproblems
\newcounter{ProblemNum}
\newcounter{SubProblemNum}[ProblemNum]
\newcounter{Choice}[SubProblemNum]
\renewcommand{\theProblemNum}{\arabic{ProblemNum}}
\renewcommand{\theSubProblemNum}{\alph{SubProblemNum}}
\renewcommand{\theChoice}{\alph{Choice}}


% The subproblem command divides a problem into parts a), b), c), ...
\newcommand*{\subproblem}{%
  \stepcounter{SubProblemNum}%
  {\bf \theSubProblemNum)\hspace{2pt}}
  }


% The choice command offers multiple choices
\newcommand*{\choice}{%
  \stepcounter{Choice}%
  {\bf \theChoice)\hspace{2pt}}
  }


% The problem environment is the base unit of content for this class.
\newcommand{\subsectiontitle}{}
\newenvironment{problem}[1]%
  {
  \stepcounter{ProblemNum}
  \renewcommand{\subsectiontitle}{\problemlabel \ \theProblemNum \ifthenelse{\isempty{#1}}{}{\ : #1}}
  \medskip \subsection*{\subsectiontitle}

  \FloatBarrier
  }
  {
  \FloatBarrier
  }

\newenvironment{choices}[1]%
  {
  \stepcounter{ProblemNum}
  \renewcommand{\subsectiontitle}{\problemlabel \ \theProblemNum \ifthenelse{\isempty{#1}}{}{\ : #1}}
  \medskip \subsection*{\subsectiontitle}
  \renewcommand{\theSubProblemNum}{\arabic{ProblemNum}.\arabic{SubProblemNum}}

  \renewcommand*{\subproblem}{%
    \bigskip
    \stepcounter{SubProblemNum}%
    {\bf \theSubProblemNum\hspace{2pt}}
    }

  \FloatBarrier
  }
  {
  \renewcommand{\theSubProblemNum}{\alph{SubProblemNum}}

  \renewcommand*{\subproblem}{%
    \stepcounter{SubProblemNum}%
    {\bf \theSubProblemNum)\hspace{2pt}}
    }

  \FloatBarrier
  }



% The solution environment should be used within the problem environment
\NewEnviron{solution}{
  \setcounter{SubProblemNum}{0}
  \ifsolution
    \FloatBarrier
    \subsubsection*{\solutionlabel}
    \BODY
  \fi}


\setlength{\parindent}{0pt}




\RequirePackage{titling}

% Header and footer
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\pagestyle{fancy}
\lhead{}\chead{}\rhead{}
\lfoot{}\cfoot{}\rfoot{\thepage \ / \pageref*{LastPage}}  % The star is for "no hyperlink"
\renewcommand{\headrulewidth}{0.0pt}
\renewcommand{\footrulewidth}{0.0pt}


\fancypagestyle{Cancelheader}{% 
   \fancyhead{}
   \renewcommand{\headrulewidth}{0pt}
}



\newcommand{\makeheader}{

  \thispagestyle{Cancelheader}
  
  \begin{minipage}[c][2cm][t]{0.45\linewidth}
  \flushleft
  \includegraphics[width=5cm]{h-DE.png}
  \end{minipage}
  \hfill
  \begin{minipage}[c][2cm][c]{0.45\linewidth}
  \flushright
  \color{VertUQTR}
  {\Large
  {\sc \thedocumentlabel}
  }
  \end{minipage}
  
  \medskip
  
  \hrule
  
  
  \medskip
  
  \noindent
  \begin{minipage}[c][12mm][t]{0.50\linewidth}
  \flushleft
  {\bf \thedepartment}
  \end{minipage}
  \hfill
  \begin{minipage}[c][12mm][t]{0.45\linewidth}
  \flushright
  {\bf \theauthor}\\
  \theauthormail
  \end{minipage}
  
  \hrule
  
  \begin{center}
  
  {
  \bf
  {\large \thecoursecode}%
  \hfill
  {\Large \thetitle}% 
  \hfill
  {\large \thesemester}
  }
  
  \end{center}
  
  \hrule
  
  \vspace{6mm}
}

\makeatletter
\renewcommand{\maketitle}{\makeheader}
\makeatother

