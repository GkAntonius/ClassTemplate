\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uqtrplandecours}[2021/08/11 Plan de cours pour l'UQTR]
\LoadClass{article}
\RequirePackage{uqtrbase}
\RequirePackage{mathptmx}
\RequirePackage{amssymb}
\RequirePackage{titling}  % Allows to use \theauthor and \thetitle

% =========================================================================== %
% Various formatting option
% =========================================================================== %

\RequirePackage[top=1in, bottom=1.00in, left=0.75in, right=0.75in]{geometry}

% Remove spacing before itemize and between bullets
\RequirePackage{enumitem}
\setlist[itemize]{noitemsep, topsep=0pt}

\setlength{\parindent}{0pt}

% =========================================================================== %
% Plan-de-cours objects
% =========================================================================== %


% =============== Classes ============= %

% This is the main counter for each class
\newcounter{class}
\newcounter{numclass}

\newcounter{numclasscontent}[class]
\newcounter{numclasseval}[class]

% \addclass{a date}
% Add a class at a certain date. 
% TODO the first argument should be optional, in case
% one has set the date in advance with adddate
\newcommand\addclass[1]{%
  \stepcounter{class}%
  \csdef{date\theclass}{#1}
  \csxdef{lengthclasscontent\theclass}{0}
  \csxdef{lengthclasseval\theclass}{0}
  }

\newcommand{\defaultinteractiontype}{Présentiel}

\newcommand\nextclass{
  \stepcounter{class}%
  \csxdef{lengthclasscontent\theclass}{0}
  \csxdef{lengthclasseval\theclass}{0}
  \csgdef{interactiontype\theclass}{\defaultinteractiontype}
  }

\newcommand\setinteractiontype[1]{%
  \csgdef{interactiontype\theclass}{#1}
  }


% =============== Evaluations ============= %

\newcounter{evaluation}
\setcounter{evaluation}{0}
\newcounter{numeval}
\setcounter{numeval}{0}

\FPset\totalindivweight{0}
\FPset\totalgroupweight{0}
\FPset\totalweight{0}
\FPset\evaltotalweight{0}


% \addeval{name}{individual points}{group points}
% Add an evaluation to the current class
%
\newcommand\addeval[3]{%
  \stepcounter{evaluation}%
  \stepcounter{numeval}%

  \csxdef{eval\theevaluation}{#1}
  \csgdef{evalindivweight\theevaluation}{#2}
  \csgdef{evalgroupweight\theevaluation}{#3}

  \FPset\evaltotalweight{0}
  \FPadd\evaltotalweight{#2}{#3}

  \FPadd\totalweight\totalweight\evaltotalweight
  \FPadd\totalindivweight\totalindivweight{#2}
  \FPadd\totalgroupweight\totalgroupweight{#3}

  \FPeval\evaltotalweight{clip(round(evaltotalweight:1))}
  \csxdef{evalweight\theevaluation}{\evaltotalweight}

  % Now take the current date and save it
  % This means the command \addeval has to be used within
  % the calendar environment or right after the adddate command.
  \csxdef{evaldate\theevaluation}{\getdate{\theclass}}

  % Add this evaluation to the list of evaluations of this class
  \stepcounter{numclasseval}
  \csxdef{classeval\theclass\Xsep\thenumclasseval}{#1}
  \csxdef{lengthclasseval\theclass}{\thenumclasseval}

  }


\AtBeginDocument{
  \setcounter{class}{0}
  \setcounter{evaluation}{0}
  \setcounter{content}{0}
  }

\newcommand\nexteval{%
  \stepcounter{evaluation}%
  \csuse{eval\theevaluation}
  }


% Some aliases
\newcounter{homework}
\newcommand{\addhomework}[2]{\stepcounter{homework} \addeval{Devoir \arabic{homework}}{#1}{#2}}
\newcounter{lab}
\newcommand{\addlab}[2]{\stepcounter{lab} \addeval{Laboratoire \arabic{lab}}{#1}{#2}}
\newcounter{exr}
\newcommand{\addexr}[2]{\stepcounter{exr} \addeval{Exercice \arabic{exr}}{#1}{#2}}
\newcounter{exam}
\newcommand{\addexam}[2]{\stepcounter{exam} \addeval{Examen \arabic{exam}}{#1}{#2}}


% =============== Content ============= %

\newcounter{content}

% \addcontent{some content}
% Add content to the current class
%
\newcommand\addcontent[1]{%
  \stepcounter{content}
  \stepcounter{numclasscontent}
  \csgdef{content\thecontent}{#1}

  \csgdef{classcontent\theclass\Xsep\thenumclasscontent}{#1}
  \csxdef{lengthclasscontent\theclass}{\thenumclasscontent}

  }

% =============== Calendar ============= %

\newcounter{week}
\newcommand{\nextweek}{\stepcounter{week}\arabic{week}} % This is like a 

\newcommand\setdate[2]{%
  \csdef{date#1}{#2}
  }
\newcommand\adddate[1]{%
  \stepcounter{class}%
  \csdef{date\theclass}{#1}
  }
%\newcommand\addclass[1]{%
%  \stepcounter{class}%
%  \csdef{date\theclass}{#1}
%  }

\newcommand\getdate[1]{%
  \csuse{date#1}
  }
\newcommand\nextdate{%
  \stepcounter{class}%
  \csuse{date\theclass}
  }
\newcommand\classdate{%
  \csuse{date\theclass}
  }

%\AtBeginDocument{
% \setcounter{class}{0}
%  }


% Calendar Formatting

\newcommand{\calendarheader}{
  \hline
  {\bf Cours} & {\bf Date} & {\bf Contenu} & {\bf Examen / Remise de travaux}\\
  \hline
}

\def\startcalendar{%
  %\begin{table}[!htbp]
  %\renewcommand{\arraystretch}{1.1}
  %\begin{tabular}{|c|c|c|c|}
  \begin{longtable}{| p{1.5cm} | p{2.1cm} | p{8cm} | p{4cm} |} 
  \calendarheader
  }

\def\stopcalendar{\hline\end{longtable}}


\newenvironment{calendar}{\startcalendar}{\stopcalendar}


\newcommand{\printnextcalendarline}{%
  \hline
  \stepcounter{class}
  & \csuse{date\theclass}
  & \csuse{content\theclass}
  & \csuse{eval\theclass}
  \\
  }


\newcommand{\printcalendar}{
  \FloatBarrier
  \setcounter{ii}{0}%
  \begin{calendar}
    \ifnum \theclass > 0
    \Repeat{\value{class}}{%
      \stepcounter{ii}%
      \arabic{ii}
      &
      \csuse{date\theii}
      &
      \ifnum \csuse{lengthclasscontent\theii} > 0
      \vspace{-3mm}
      \begin{itemize}[left= 0pt]%
        \Repeat{\csuse{lengthclasscontent\theii}}{%
          \stepcounter{jj}%
          \item \csuse{classcontent\theii\Xsep\thejj}
        }
      \end{itemize}
      \fi
      &
      \setcounter{jj}{0}%
      \ifnum \csuse{lengthclasseval\theii} > 0
      \vspace{-3mm}
      \begin{itemize}[left= 0pt]%
        \Repeat{\csuse{lengthclasseval\theii}}{%
          \stepcounter{jj}%
          \item \csuse{classeval\theii\Xsep\thejj}
        }
      \end{itemize}
      \fi
      \\
      \hline
    }
    \fi
  \end{calendar}
  \FloatBarrier
  }









% Now, we will have a different set of commands for the 2021 remote teachning version
% (and hope these are temporary...)

\newcommand{\calendarheaderremote}{
  \hline
  {\bf Cours} & {\bf Date} & {\bf Contenu} & {\bf Examen / Remise de travaux} & {\bf \small Type d’interaction: en présentiel, comodal, à distance en mode synchrone, à distance en mode asynchrone}\\
  \hline
}

\def\startcalendarremote{%
  %\begin{table}[!htbp]
  %\renewcommand{\arraystretch}{1.1}
  %\begin{tabular}{|c|c|c|c|}
  \begin{longtable}{| p{1.2cm} | p{2.0cm} | p{6cm} | p{2.5cm} | p{3cm} |} 
  \calendarheaderremote
  }

%\newcommand{\newcalendarentryremote}[3]{
%  \hline
%  \nextclass & \csuse{date\theclass} &
%      #1
%  &
%      #2
%  &
%      #3
%  \\
%}
%
%\let\newcalentryremote\newcalendarentryremote

%\newenvironment{calendarremote}{
%  \let\newcalentry\newcalentryremote
%  \startcalendarremote%
%  }{\stopcalendar}

\newenvironment{calendarremote}{\startcalendarremote}{\stopcalendar}

% Remote version of the calendar
\newcommand{\printcalendarremote}{
  \FloatBarrier
  \setcounter{ii}{0}%
  \begin{calendarremote}
    \ifnum \theclass > 0
    \Repeat{\value{class}}{%
      \stepcounter{ii}%
      \arabic{ii}
      &
      \csuse{date\theii}
      &
      \ifnum \csuse{lengthclasscontent\theii} > 0
      \vspace{-3mm}
      \begin{itemize}[left= 0pt]%
        \Repeat{\csuse{lengthclasscontent\theii}}{%
          \stepcounter{jj}%
          \item \csuse{classcontent\theii\Xsep\thejj}
        }
      \end{itemize}
      \fi
      &
      \setcounter{jj}{0}%
      \ifnum \csuse{lengthclasseval\theii} > 0
      \vspace{-3mm}
      \begin{itemize}[left= 0pt]%
        \Repeat{\csuse{lengthclasseval\theii}}{%
          \stepcounter{jj}%
          \item \csuse{classeval\theii\Xsep\thejj}
        }
      \end{itemize}
      \fi
      &
      \csuse{interactiontype\theii}
      \\
      \hline
    }
    \fi
  \end{calendarremote}
  \FloatBarrier
  }


% =============== Evaluations table ============= %

\newcolumntype{C}{>{\centering\arraybackslash} m}

\newcommand{\evaltableheader}{
  \hline
  & \multicolumn{3}{ c |}{\bf Pondération } & \\
  & \multicolumn{3}{ c |}{\bf (maximum de 100\%)} & \\
  \cline{2-4}
  & \bf Individuel & \bf Équipe & \bf Total & \\
  \hline
  {\bf Modalité d'évaluation des apprentissages} & \bf Minimum 60\% de la note globale & \bf  Maximum 40\% de la note globale & \bf  100\% & {\bf  Date d'examen ou de remise des travaux} \\
  \hline
}


\def\startevaltable{%
  \begin{center}
  \begin{longtable}[c]{| m{4cm} | C{3.2cm} | C{3.2cm} | C{1.6cm} | m{3.8cm} |}
  \evaltableheader
  }

\def\stopevaltable{
  \end{longtable}
  \end{center}
  }

\newenvironment{evaltable}{%
  \startevaltable%
  }{%
  \stopevaltable%
  }

% Name, individual weight, team weight, toal weight, date
%\newcommand{\printevaltable}
%  {
%  \stepcounter{evaluation}
%  \csuse{eval\theevaluation}
%  }


%\newcommand{\printnextevalline}
%  {
%    \hline
%    \stepcounter{evaluation}
%    \csuse{eval\theevaluation} &
%    \csuse{evalindivweight\theevaluation} \% &
%    \csuse{evalgroupweight\theevaluation} \% &
%    \csuse{evalweight\theevaluation} \% &
%    \csuse{evaldate\theevaluation}\\
%  }

\newcommand{\printlastevalline}
  {
    \bf Total des éléments d'évaluation &
    \bf \totalindivweight \% &
    \bf \totalgroupweight \% &
    \bf \totalweight \% & \\
    \hline
  }

\newcommand{\printevaltable}{
  \FloatBarrier
  \FPeval\totalindivweight{clip(round(totalindivweight:1))}
  \FPeval\totalgroupweight{clip(round(totalgroupweight:1))}
  \FPeval\totalweight{round(totalweight:0)}
  \setcounter{ii}{0}
  \begin{evaltable}
    \Repeat{\value{evaluation}}{
      \stepcounter{ii}
      \csuse{eval\theii} &
      \csuse{evalindivweight\theii} \% &
      \csuse{evalgroupweight\theii} \% &
      \csuse{evalweight\theii} \% &
      \csuse{evaldate\theii}\\
      \hline
    }
    \printlastevalline
  \end{evaltable}
  \FloatBarrier
}


%\newcommand{\newevaltableentry}[5]{
%  \hline
%  #1 & #2 & #3 & #4 & #5\\
%}



% =========================================================================== %
% Header and course info
% =========================================================================== %


% Header and footer
\pagestyle{fancy}
\lhead{}\chead{}\rhead{}
%\lfoot{\thecoursecode}\cfoot{}\rfoot{\thepage \ / \pageref*{LastPage}}  % The star is for "no hyperlink"
\lfoot{Décanat des études}\cfoot{}\rfoot{\thepage \ / \pageref*{LastPage}}  % The star is for "no hyperlink"
\renewcommand{\headrulewidth}{0.0pt}
\renewcommand{\footrulewidth}{0.5pt}

\renewcommand{\titlesize}{\Large}

\newcommand{\makeheaderoriginal}{
  
  \thispagestyle{Cancelheader}
  
  \begin{minipage}[c][2cm][t]{0.45\linewidth}
  \flushleft
  \includegraphics[width=\logowidth]{\logofilename}
  \end{minipage}
  \hfill
  \begin{minipage}[c][2cm][c]{0.45\linewidth}
  \flushright
  \color{VertForetUQTR}
  {\Large
  {\sc Plan de cours}\\
  \hfill {\thecourselevel}

  }
  \end{minipage}
  
  \medskip
  
  \hrule

  \medskip

  \hfill {\bf \theauthor}

  \hfill {\theauthormail}

  \medskip

  \hrule

  \medskip

  \hfill {\bf \thedepartment}

  \medskip

  \hrule

  \medskip

  \hfill {\bf \thesemester}

  \medskip

  \hrule
  
  \begin{center}
  
  {\bf
  {\thecoursecode}%
  \hfill
  {\titlesize \thecoursetitle}% 
  \hfill
  {\thecourseyear$^{\text{e}}$ année}

  }
  
  \end{center}
  
  \vspace{2mm}
  
  }

\makeatletter
\renewcommand{\maketitle}{\makeheaderoriginal}
\makeatother


\newcommand{\checkedbox}{\square \raisebox{.18ex}{\hspace{-.7em}\checkmark}}


\newcommand{\signaturespremiercycle}{
\vspace{5mm}
\begin{longtable}{  p{7cm} p{1.5cm}  p{7cm}  }
  \vspace{1cm}\\
  \bf \theauthor & & \insertsignature \\
  \hline
  Nom de l'enseignant.e et nom des membres de l'équipe pédagogique (le cas échéant)
    &  &
  Signature de l’enseignant-e ou des membres de l’équipe pédagogique\\
  \\
  $\checkedbox$ Professeur(e) \hfill $\square$ Chargé(e) de cours & & \\
  \vspace{1cm}\\
  \bf \theprogramdirector & & \\
  \hline
  Nom de la directrice ou du directeur du comité de programmes de premier cycle
    &  &
  Signature de la directrice ou du directeur du comité de programmes de premier cycle\\
  \vspace{1cm}\\
  \bf \thedepartmenthead & & \\
  \hline
  Nom de la directrice ou du directeur du département
    &  &
  Signature de la directrice ou du directeur du département\\
\end{longtable}
\vspace{2mm}
  La version électronique originale de ce plan de cours est conservée au Décanat des études.
}


\newcommand{\signaturescyclessuperieurs}{
\vspace{5mm}
\begin{longtable}{  p{7cm} p{1.5cm}  p{7cm}  }
  \vspace{1cm}\\
  \bf \theauthor & & \insertsignature \\
  \hline
  Nom de l'enseignant.e et nom des membres de l'équipe pédagogique (le cas échéant)
    &  &
  Signature de l’enseignant-e ou des membres de l’équipe pédagogique\\
  \\
  $\checkedbox$ Professeur(e) \hfill $\square$ Chargé(e) de cours & & \\
  \vspace{1cm}\\
  \bf \theprogramdirector & & \\
  \hline
  Nom de la directrice ou du directeur du comité de programmes de cycles supérieurs
    &  &
  Signature de la directrice ou du directeur du comité de programmes de cycles supérieurs\\
  \vspace{1cm}\\
  \bf \thedepartmenthead & & \\
  \hline
  Nom de la directrice ou du directeur du département
    &  &
  Signature de la directrice ou du directeur du département\\
\end{longtable}
\vspace{2mm}
  La version électronique originale de ce plan de cours est conservée au Décanat des études.
}


\newcommand{\cadrereglementairepremiercycle}{

La description officielle du cours publiée sur le site Internet de l’UQTR
où des règlements pédagogiques particuliers peuvent s’appliquer:
\href{\thecourseurl}{\thecoursecode -- \thecoursetitle}

\medskip

Tous les documents normatifs sont disponibles sur le site du secrétariat général:
\href{http://www.uqtr.ca/gouvernance/texte\_reglements.shtml}
     {règlements }
et
\href{http://www.uqtr.ca/gouvernance/texte\_politiques.shtml}
     {politiques}%
    .
Plus particulièrement:
\begin{enumerate}
  \item \href{https://oraprdnt.uqtr.uquebec.ca/vrsg/Reglementation/118.pdf}
             {Règlement des études de premier cycle}
  \item \href{https://oraprdnt.uqtr.uquebec.ca/vrsg/Reglementation/108.pdf}
             {Politique de la formation à distance}
  \item \href{https://oraprdnt.uqtr.uquebec.ca/vrsg/Reglementation/119.pdf}
             {Politique portant sur les utilisations des technologies de l’information et des communications (TIC)}
  \item \href{https://oraprdnt.uqtr.uquebec.ca/vrsg/Reglementation/141.pdf}
             {Politique institutionnelle de soutien aux étudiants en situation de handicap}
              et le site web de \\
        \href{https://oraprdnt.uqtr.uquebec.ca/pls/protege/gscw030?owa\_no\_site=2300\&owa\_no\_fiche=0\&owa\_no\_rubrique=}
             {soutien à la communauté universitaire en regard des étudiants en situation de handicap}
  \item \href{https://oraprdnt.uqtr.uquebec.ca/vrsg/Reglementation/121.pdf}
             {Règlement sur les délits relatifs aux études}
  \item \href{https://oraprdnt.uqtr.uquebec.ca/vrsg/Reglementation/122.pdf}
             {Règlement relatif à la sécurité sur le campus de l'UQTR}
  \item \href{https://oraprdnt.uqtr.uquebec.ca/vrsg/Reglementation/127.pdf}
             {Politique visant à prévenir et enrayer toute forme de harcèlement, de discrimination et d'incivilité}
  \item \href{https://oraprdnt.uqtr.uquebec.ca/pls/protege/docs/GSC5087/O0002664958_Politique_departementale_examens_compensation.pdf}
             {Politique départementale des examens de compensation}
\end{enumerate}

}


\newcommand{\cadrereglementairecyclessuperieurs}{

La description officielle du cours publiée sur le site Internet de l’UQTR
où des règlements pédagogiques particuliers peuvent s’appliquer:
\href{\thecourseurl}{\thecoursecode -- \thecoursetitle}

\medskip

Tous les documents normatifs sont disponibles sur le site du secrétariat général:
\href{http://www.uqtr.ca/gouvernance/texte\_reglements.shtml}
     {règlements }
et
\href{http://www.uqtr.ca/gouvernance/texte\_politiques.shtml}
     {politiques}%
    .
Plus particulièrement:
\begin{enumerate}
  \item \href{https://oraprdnt.uqtr.uquebec.ca/vrsg/Reglementation/98.pdf}
             {Règlement des études de cycles supérieurs}
  \item \href{https://oraprdnt.uqtr.uquebec.ca/vrsg/Reglementation/146.pdf}
             {Politique sur l’intégrité et sur la conduite responsable en recherche et en création}
  \item \href{https://oraprdnt.uqtr.uquebec.ca/vrsg/Reglementation/108.pdf}
             {Politique de la formation à distance}
  \item \href{https://oraprdnt.uqtr.uquebec.ca/vrsg/Reglementation/119.pdf}
             {Politique portant sur les utilisations des technologies de l’information et des communications (TIC)}
  \item \href{https://oraprdnt.uqtr.uquebec.ca/vrsg/Reglementation/141.pdf}
             {Politique institutionnelle de soutien aux étudiants en situation de handicap}
              et le site web de \\
        \href{https://oraprdnt.uqtr.uquebec.ca/pls/protege/gscw030?owa\_no\_site=2300\&owa\_no\_fiche=0\&owa\_no\_rubrique=}
             {soutien à la communauté universitaire en regard des étudiants en situation de handicap}
  \item \href{https://oraprdnt.uqtr.uquebec.ca/vrsg/Reglementation/73.pdf}
             {Politique linguistique de l'Université du Québec à Trois-Rivières}
  \item \href{https://oraprdnt.uqtr.uquebec.ca/vrsg/Reglementation/107.pdf}
             {Règlement relatif à la qualité du français dans les programmes d’études de l’UQTR}
  \item \href{https://oraprdnt.uqtr.uquebec.ca/vrsg/Reglementation/121.pdf}
             {Règlement sur les délits relatifs aux études}
  \item \href{https://oraprdnt.uqtr.uquebec.ca/vrsg/Reglementation/122.pdf}
             {Règlement relatif à la sécurité sur le campus de l'UQTR}
  \item \href{https://oraprdnt.uqtr.uquebec.ca/vrsg/Reglementation/127.pdf}
             {Politique visant à prévenir et enrayer toute forme de harcèlement, de discrimination et d'incivilité}
  \item \href{https://oraprdnt.uqtr.uquebec.ca/pls/protege/docs/GSC5087/O0002664958_Politique_departementale_examens_compensation.pdf}
             {Politique départementale des examens de compensation}
\end{enumerate}

}





% =========================================================================== %
% Bareme
% =========================================================================== %

\newcounter{grade}
\setcounter{grade}{0}
\stepcounter{grade}\csedef{GradeLabel\thegrade}{A+}\csedef{GradeLowerBound\thegrade}{0}\csedef{GradeUpperBound\thegrade}{0}
\stepcounter{grade}\csedef{GradeLabel\thegrade}{A}\csedef{GradeLowerBound\thegrade}{0}\csedef{GradeUpperBound\thegrade}{0}
\stepcounter{grade}\csedef{GradeLabel\thegrade}{A-}\csedef{GradeLowerBound\thegrade}{0}\csedef{GradeUpperBound\thegrade}{0}
\stepcounter{grade}\csedef{GradeLabel\thegrade}{B+}\csedef{GradeLowerBound\thegrade}{0}\csedef{GradeUpperBound\thegrade}{0}
\stepcounter{grade}\csedef{GradeLabel\thegrade}{B}\csedef{GradeLowerBound\thegrade}{0}\csedef{GradeUpperBound\thegrade}{0}
\stepcounter{grade}\csedef{GradeLabel\thegrade}{B-}\csedef{GradeLowerBound\thegrade}{0}\csedef{GradeUpperBound\thegrade}{0}
\stepcounter{grade}\csedef{GradeLabel\thegrade}{C+}\csedef{GradeLowerBound\thegrade}{0}\csedef{GradeUpperBound\thegrade}{0}
\stepcounter{grade}\csedef{GradeLabel\thegrade}{C}\csedef{GradeLowerBound\thegrade}{0}\csedef{GradeUpperBound\thegrade}{0}
\stepcounter{grade}\csedef{GradeLabel\thegrade}{C-}\csedef{GradeLowerBound\thegrade}{0}\csedef{GradeUpperBound\thegrade}{0}
\stepcounter{grade}\csedef{GradeLabel\thegrade}{D+}\csedef{GradeLowerBound\thegrade}{0}\csedef{GradeUpperBound\thegrade}{0}
\stepcounter{grade}\csedef{GradeLabel\thegrade}{D}\csedef{GradeLowerBound\thegrade}{0}\csedef{GradeUpperBound\thegrade}{0}
\stepcounter{grade}\csedef{GradeLabel\thegrade}{E}\csedef{GradeLowerBound\thegrade}{0}\csedef{GradeUpperBound\thegrade}{0}


\newcommand{\setgradebound}[3]{%
  \csxdef{GradeLowerBound#1}{#2}%
  \csxdef{GradeUpperBound#1}{#3}%
  }

% \setgrade{<grade>}{<lower bound>}{<upper bound>}
%
% e.g. \setgrade{A+}{90}{100}
%
\newcommand{\setgrade}[3]{%
  \setcounter{ii}{0}
  \Repeat{\value{grade}}{
    \stepcounter{ii}%
    \edef\first{#1}\edef\second{\csuse{GradeLabel\theii}}
    \ifx\first\second
    %\ifcsequal{#1}{\csuse{GradeLabel\theii}}{
    %\ifx{#1}{\csuse{GradeLabel\theii}}
        \setgradebound{\theii}{#2}{#3}
    \else
      %}{
        \relax
      %}
    \fi
    }
  }


% This a horrible implementation, I know ...
% FIXME Not actually used yet.
\newcommand{\printgrades}{%
  \FloatBarrier
  \begin{center}
  \begin{tabular}{| p{8mm} | p{20mm} |c| p{8mm} | p{20mm} |c| p{8mm} | p{20mm} |c| p{8mm} | p{20mm} |}
    \cline{1-2}\cline{4-5}\cline{7-8}\cline{10-11}
    \bf Cote & \bf Notes (\%)  &  &  \bf Cote & \bf Notes (\%) & &  \bf Cote & \bf Notes (\%) & &  \bf Cote & \bf Notes (\%) \\
    \cline{1-2}\cline{4-5}\cline{7-8}\cline{10-11}
    \csuse{GradeLabel1} & \intervali{\csuse{GradeLowerBound1}}{\csuse{GradeUpperBound1}}&& 
    \csuse{GradeLabel4} & \interval{\csuse{GradeLowerBound4}}{\csuse{GradeUpperBound4}} && 
    \csuse{GradeLabel7} & \interval{\csuse{GradeLowerBound7}}{\csuse{GradeUpperBound7}} &&
    \csuse{GradeLabel10} & \interval{\csuse{GradeLowerBound10}}{\csuse{GradeUpperBound10}} \\
    \csuse{GradeLabel2} & \interval{\csuse{GradeLowerBound2}}{\csuse{GradeUpperBound2}} && 
    \csuse{GradeLabel5} & \interval{\csuse{GradeLowerBound5}}{\csuse{GradeUpperBound5}} && 
    \csuse{GradeLabel8} & \interval{\csuse{GradeLowerBound8}}{\csuse{GradeUpperBound8}} &&
    \csuse{GradeLabel11} & \interval{\csuse{GradeLowerBound11}}{\csuse{GradeUpperBound11}} \\
    \csuse{GradeLabel3} & \interval{\csuse{GradeLowerBound3}}{\csuse{GradeUpperBound3}} && 
    \csuse{GradeLabel6} & \interval{\csuse{GradeLowerBound6}}{\csuse{GradeUpperBound6}} && 
    \csuse{GradeLabel9} & \interval{\csuse{GradeLowerBound9}}{\csuse{GradeUpperBound9}} &&
    \csuse{GradeLabel12} & \interval{\csuse{GradeLowerBound12}}{\csuse{GradeUpperBound12}} \\
    \cline{1-2}\cline{4-5}\cline{7-8}\cline{10-11}
  \end{tabular}
  \end{center}
  \FloatBarrier
  }


\newcommand{\interval}[2]{[  #1 -- #2 [}
\newcommand{\intervali}[2]{[ #1 -- #2 ]}

\newcommand{\baremedenotationpremiercycle}{
  \begin{center}
  \begin{tabular}{| p{8mm} | p{20mm} |c| p{8mm} | p{20mm} |c| p{8mm} | p{20mm} |c| p{8mm} | p{20mm} |}
    \cline{1-2}\cline{4-5}\cline{7-8}\cline{10-11}
    \bf Cote & \bf Notes (\%)  &  &  \bf Cote & \bf Notes (\%) & &  \bf Cote & \bf Notes (\%) & &  \bf Cote & \bf Notes (\%) \\
    \cline{1-2}\cline{4-5}\cline{7-8}\cline{10-11}
    A+    & \intervali{91}{100} & &   B+    & \interval{81}{84} & &  C+    & \interval{72}{75} & &  D+    & \interval{63}{66} \\                                 
    A     & \interval{87}{91}   & &   B     & \interval{78}{81} & &  C     & \interval{69}{72} & &  D     & \interval{59}{63} \\
    A-    & \interval{84}{87}   & &   B-    & \interval{75}{78} & &  C-    & \interval{66}{69} & &  E     & \interval{0 }{59} \\
    \cline{1-2}\cline{4-5}\cline{7-8}\cline{10-11}
  \end{tabular}
  \end{center}
  }

\newcommand{\baremedenotationcyclessuperieurs}{
  \begin{center}
  \begin{tabular}{| p{8mm} | p{20mm} |c| p{8mm} | p{20mm} |c| p{8mm} | p{20mm} |c| p{8mm} | p{20mm} |}
    \cline{1-2}\cline{4-5}\cline{7-8}
    \bf Cote & \bf Notes (\%)  &  &  \bf Cote & \bf Notes (\%) & &  \bf Cote & \bf Notes (\%) \\
    \cline{1-2}\cline{4-5}\cline{7-8}
    A+    & \intervali{90}{100} & &   B+    & \interval{75}{80} & &  C+    & \interval{65}{69}  \\
    A     & \interval{84}{90}   & &   B     & \interval{72}{75} & &  C     & \interval{61}{65}  \\
    A-    & \interval{80}{84}   & &   B-    & \interval{69}{72} & &  E     & \interval{0 }{61}  \\
    \cline{1-2}\cline{4-5}\cline{7-8}
  \end{tabular}
  \end{center}
  }



\newcommand{\baremedenotation}{\baremedenotationpremiercycle}
\newcommand{\cadrereglementaire}{\cadrereglementairepremiercycle}
\newcommand{\signatures}{\signaturespremiercycle}




% Toggle between graduate and undergraduate class
\newcommand{\setundergraduate}{
  \renewcommand{\thecourselevel}{Premier cycle}
  \renewcommand{\theshortcourselevel}{1$^{\text{er}}$ cycle}
  \renewcommand{\cadrereglementaire}{\cadrereglementairepremiercycle}
  \renewcommand{\baremedenotation}{\baremedenotationpremiercycle}
  \renewcommand{\signatures}{\signaturespremiercycle}
  \setgrade{A+}{91}{100}
  \setgrade{A}{87}{91}
  \setgrade{A-}{84}{87}
  \setgrade{B+}{81}{84}
  \setgrade{B}{78}{81}
  \setgrade{B-}{75}{78}
  \setgrade{C+}{72}{75}
  \setgrade{C}{69}{72}
  \setgrade{C-}{66}{69}
  \setgrade{D+}{63}{66}
  \setgrade{D}{59}{63}                                                                                                                                         
  \setgrade{E}{0}{59}
  }

\newcommand{\setgraduate}{
  \renewcommand{\thecourselevel}{Cycles supérieurs}
  \renewcommand{\theshortcourselevel}{2$^{\text{e}}$ ou 3$^{\text{e}}$ cycle}
  \renewcommand{\cadrereglementaire}{\cadrereglementairecyclessuperieurs}
  \renewcommand{\baremedenotation}{\baremedenotationcyclessuperieurs}
  \renewcommand{\signatures}{\signaturescyclessuperieurs}
  \setgrade{A+}{90}{100}
  \setgrade{A}{84}{91}
  \setgrade{A-}{80}{84}
  \setgrade{B+}{75}{80}
  \setgrade{B}{72}{75}
  \setgrade{B-}{69}{72}
  \setgrade{C+}{65}{69}
  \setgrade{C}{61}{65}
  \setgrade{C-}{}{}
  \setgrade{D+}{}{}
  \setgrade{D}{}{}                                                                                                                                         
  \setgrade{E}{0}{61}
  }

\newcommand{\setanygraduate}{
  \renewcommand{\thecourselevel}{Premier et second cycles}
  \renewcommand{\cadrereglementaire}{\cadrereglementairecyclessuperieurs}
  \renewcommand{\baremedenotation}{\baremedenotationcyclessuperieurs}
  \renewcommand{\signatures}{\signaturescyclessuperieurs}
  \setgrade{A+}{91}{100}
  \setgrade{A}{87}{91}
  \setgrade{A-}{84}{87}
  \setgrade{B+}{81}{84}
  \setgrade{B}{78}{81}
  \setgrade{B-}{75}{78}
  \setgrade{C+}{72}{75}
  \setgrade{C}{69}{72}
  \setgrade{C-}{66}{69}
  \setgrade{D+}{63}{66}
  \setgrade{D}{59}{63}                                                                                                                                         
  \setgrade{E}{0}{59}
  }


% =========================================================================== %
% Declare class options
% =========================================================================== %


\DeclareOption{undergraduate}{\setundergraduate}
\DeclareOption{graduate}{\setgraduate}
\DeclareOption{anygraduate}{\setanygraduate}


% =========================================================================== %
% Process class options
% =========================================================================== %

\ProcessOptions\relax

%\ProcessKeyvalOptions*
%
%\makeatletter
%
%\ifuqtrplandecours@undergraduate
%  \setundergraduate                                                                                                                                              
%\else
%  \setgraduate
%\fi
%
%\makeatother

\title{\thecoursetitle}
