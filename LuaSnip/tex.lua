return {
	S({ trig = ";eq", dscr = "Equation"},
		Fmt(
			[[
				\begin{equation*}
					<>
				\end{equation*}
			]],
			{ i(1) },
			{ delimiters = "<>" }
	)),
	S({ trig = ";ls", dscr = "List"},
		Fmt(
			[[
				\begin{itemize}
					\item[<>)]<>
				\end{itemize}
			]],
			{ i(1), i(2) },
			{ delimiters = "<>" }
	)),
	S({ trig = ";al", dscr = "Align Equations"},
		Fmt(
			[[
				\begin{align*}
					<>
				\end{align*}
			]],
			{ i(1) },
			{ delimiters = "<>" }
	)),
	S({ trig = ";ta", dscr = "Table"},
		Fmt(
			[[
				\begin{tabular}{<> | <>}
				<> \\
				\hline
				<>
				\end{tabular}
			]],
			{ i(1), i(2), i(3), i(4) },
			{ delimiters = "<>" }
	)),
	S({ trig = ";ma", dscr = "Nicematrix"},
		Fmt(
			[[
				\begin{bNiceMatrix}[first-row,first-col]
					<>
				\end{bNiceMatrix}
			]],
			{ i(1) },
			{ delimiters = "<>" }
	)),
	S({ trig = ";cr", dscr = "Logic Circuit Diagram"},
		Fmt(
			[[
				\usetikzlibrary {circuits.logic.US}
				\begin{tikzpicture}[circuit logic US]
				\matrix[column sep=7mm]
				{
					\node (i0) {0}; &                            & \\
							& \node [and gate] (a1) {};  & \\
					\node (i1) {0}; &                            & \node [or gate] (o) {};\\
							& \node [nand gate] (a2) {}; & \\
					\node (i2) {1}; &                            & \\
				};
				\draw (i0.east) -- ++(right:3mm) |- (a1.input 1);
				\draw (i1.east) -- ++(right:3mm) |- (a1.input 2);
				\draw (i1.east) -- ++(right:3mm) |- (a2.input 1);
				\draw (i2.east) -- ++(right:3mm) |- (a2.input 2);
				\draw (a1.output) -- ++(right:3mm) |- (o.input 1);
				\draw (a2.output) -- ++(right:3mm) |- (o.input 2);
				\draw (o.output) -- ++(right:3mm);
				<>
				\end{tikzpicture}
			]],
			{ i(1) },
			{ delimiters = "<>" }
	)),
	S({ trig = ";g", dscr = "Graph"},
		Fmt(
			[[
				.\\[0.125cm]
				\centerline{\begin{tikzpicture}
					\graph [spring layout] {
						% [desired at={()}]
						% [loop right]
						% [bend right=10]
						<>
					};
				\end{tikzpicture}}
			]],
			{ i(1) },
			{ delimiters = "<>" }
	)),
	S({ trig = ";ggs", dscr = "Simple Graph"},
		Fmt(
			[[
				.\\[0.125cm]
				\centerline{\begin{tikzpicture}
					\graph [spring layout] {
						a [desired at={(0,0)}] -- b [desired at={(0,-1)}] -- c [desired at={(1,0)}] -- d [desired at={(1,-1)}];
						<>
					};
				\end{tikzpicture}}
			]],
			{ i(1) },
			{ delimiters = "<>" }
	)),
	S({ trig = ";ggm", dscr = "Multigraph"},
		Fmt(
			[[
				.\\[0.125cm]
				\centerline{\begin{tikzpicture}
					\graph [spring layout] {
						a [desired at={(0,0)}] -- b [desired at={(0,-1)}] -- c [desired at={(1,0)}] -- d [desired at={(1,-1)}];
						a -- [bend left=10] c;
						a -- [bend right=5] c;
						<>
					};
				\end{tikzpicture}}
			]],
			{ i(1) },
			{ delimiters = "<>" }
	)),
	S({ trig = ";ggp", dscr = "Pseudograph"},
		Fmt(
			[[
				.\\[0.125cm]
				\centerline{\begin{tikzpicture}[every loop/.style={}]
					\graph [spring layout] {
						a [desired at={(0,0)}, loop left] -- b [desired at={(0,-1)}] -- c [desired at={(1,0)}] -- d [desired at={(1,-1)}];
						a -- [bend left=10] c;
						a -- [bend right=10] c;
						a -- [loop right] a;
						<>
					};
				\end{tikzpicture}}
			]],
			{ i(1) },
			{ delimiters = "<>" }
	)),
	S({ trig = ";gkn", dscr = "K_n Graph"},
		Fmt(
			[[
				.\\[0.125cm]
				\centerline{\begin{tikzpicture}
					\graph [simple necklace layout] {
						subgraph K_n [n=<>];
					};
				\end{tikzpicture}}
			]],
			{ i(1) },
			{ delimiters = "<>" }
	)),
	S({ trig = ";gknm", dscr = "K_nm Graph"},
		Fmt(
			[[
				.\\[0.125cm]
				\centerline{\begin{tikzpicture}
					\graph [branch right, grow down] {
						subgraph K_nm [V={<>,...,<>},W={<>,...,<>}];
					};
				\end{tikzpicture}}
			]],
			{ i(1), i(2), i(3), i(4) },
			{ delimiters = "<>" }
	)),
	S({ trig = ";gcn", dscr = "C_n Graph"},
		Fmt(
			[[
				.\\[0.125cm]
				\centerline{\begin{tikzpicture}
					\graph [simple necklace layout] {
						subgraph C_n [n=<>, --];
					};
				\end{tikzpicture}}
			]],
			{ i(1) },
			{ delimiters = "<>" }
	)),
	S({ trig = ";gwn", dscr = "W_n Graph"},
		Fmt(
			[[
				.\\[0.125cm]
				\centerline{\begin{tikzpicture}
					\graph [spring layout] {
						subgraph C_n [n=<>] -- a;
					};
				\end{tikzpicture}}
			]],
			{ i(1) },
			{ delimiters = "<>" }
	)),
	S({ trig = ";no", dscr = "Node Dot Option"},
		Fmt(
			[[
				nodes={circle,inner sep=0pt,minimum size=2mm,node distance=2cm,fill,as=}
			]],
			{ },
			{ delimiters = "<>" }
	)),
	S({ trig = ";gt", dscr = "Tree Graph"},
		Fmt(
			[[
				\begin{tikzpicture}
					\node at (1, 0) {0} [grow = west]
						child {node {00} [grow = north west]
							child {node {000} [grow = north]
								child {node {0000}}
								child {node {1000}}}
							child {node {100} [grow = west]
								child {node {0100}}
								child {node {1100}}}};
							<>
				\end{tikzpicture}
			]],
			{ i(1) },
			{ delimiters = "<>" }
	)),
	S({ trig = ";rg", dscr = "Relation Graph"},
		Fmt(
			[[
				\begin{tikzpicture}
				\usetikzlibrary{graphs}
				\tikz\graph {
					{1,2,3,4,5,6} -> {[name=second] 1,2,3,4,5,6},
					1 -> {[name=second]2,3,4,5,6},
					2 -> {[name=second]4,6},
					3 -> {[name=second]6},
					"'
				};
				\end{tikzpicture}
			]],
			{ i(1) },
			{ delimiters = "\"'" }
	)),
	S({ trig = ";crt", dscr = "Crossword Tree"},
		Fmt(
			[[
				.\\[0.125cm]
				\centerline {
					\begin{forest}
						TTT/.style args={#1:#2}{
							make tab/.expanded=\forestove{content},
							label={\pgfkeysvalueof{/forest/label position #1}:$#2$}
						},
						TTT*/.style={
							make tab=::/::/::,
							content/.expand once=%
							\expandafter\vphantom\expandafter{\romannumeral-`0\forestov{content}},
							draw=none,
							append after command={(\tikzlastnode.north) edge (\tikzlastnode.south)},
							for descendants={before computing xy={l*=1.2}},
						},
						th/.style=thick,
						for tree={node options=draw, inner sep=+0pt, parent anchor=south, child anchor=north}
						%
						[<>, TTT=r:<>
							<>]
					\end{forest}}
			]],
			{ i(1), i(2), i(3) },
			{ delimiters = "<>" }
	)),
	S({ trig = ";gbt", dscr = "Binary Tree"},
		Fmt(
			[[
				.\\[0.125cm]
				\centerline {\tikz \graph [binary tree layout] {
					<>
				};}
			]],
			{ i(1) },
			{ delimiters = "<>" }
	)),
	S({ trig = ";fsmd", dscr = "Finite-State Machine Diagram"},
		Fmt(
			[[
				.\\[0.125cm] \centerline{
				\begin{tikzpicture}[shorten >=1pt,node distance=2cm,auto]
					\node[state, initial] (s_0) {$s_0$};
					\node[state] (s_1) [above right=of s_0] {$s_1$};
					\path [->] (s_0) edge node {0,1} (s_1)
					           (s_1) edge node {0,1} (s_2)
					"'
				\end{tikzpicture}}
			]],
			{ i(1) },
			{ delimiters = "\"'" }
	)),
	S({ trig = ";fsmt", dscr = "Finite-State Machine Table"},
		Fmt(
			[[
				.\\[0.125cm] \centerline{\begin{tabular}{|l|l|l|l|l|}
				\hline
				State & \multicolumn{2}{|c|}{Input} & \multicolumn{2}{|c|}{Output}\\
				\cline{2-5}
				& \multicolumn{2}{|c|}{f} & \multicolumn{2}{|c|}{g}\\
				\cline{2-5}
				& 0 & 1 & 0 & 1\\
				\cline{2-5}
				$s_0$ & $s_0$ & $s_0$ & 0 & 0\\
				<>
				\hline
				\end{tabular}}
			]],
			{ i(1) },
			{ delimiters = "<>" }
	)),
	S({ trig = ";sl", dscr = "Loop Style"},
		Fmt(
			[[
				every loop/.style={}
			]],
			{  },
			{ delimiters = "<>" }
	)),
	S({ trig = ";brr", dscr = "Reflexive Binary Relation"},
		Fmt(
			[[
				\forall a\left(\left(a,a\right)\in R\right)
			]],
			{  },
			{ delimiters = "<>" }
	)),
	S({ trig = ";brs", dscr = "Symmetric Binary Relation"},
		Fmt(
			[[
				\forall a\forall b\left(\left(a,b\right)\in R\rightarrow (b,a)\in R\right)
			]],
			{  },
			{ delimiters = "<>" }
	)),
	S({ trig = ";bra", dscr = "Anti-symmetric Binary Relation"},
		Fmt(
			[[
				\forall a\forall b\left(\left(\left(a,b\right)\in R\wedge\left(b,a\right)\in R\right)\rightarrow \left(a=b\right)\right)
			]],
			{  },
			{ delimiters = "<>" }
	)),
	S({ trig = ";brt", dscr = "Transitive Binary Relation"},
		Fmt(
			[[
				\forall a\forall b\forall c\left(\left(\left(a,b\right)\in R\wedge\left(b,c\right)\in R\right)\rightarrow \left(a,c\right)\in R\right)
			]],
			{  },
			{ delimiters = "<>" }
	)),
}

