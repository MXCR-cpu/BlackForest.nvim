return {
	S({
		trig = ";sn",
		dscr = "Print Snippet Function"
	},
	Fmt(
	[[
		S({ trig = "<>", dscr = "<>"},
			Fmt(
				[<>[
					<>
				]<>],
				{ <> },
				{ delimiters = "<>" }
		)),
	]],
	{ i(1), i(2), i(3), i(4), i(5), i(6), i(7) },
	{ delimiters = "<>" })),

	S({
		trig = ";r",
		dscr = "Print Require Function"
	},
		Fmt(
			[[
				require("<>")
			]],
			{ i(1) },
			{ delimiters = "<>" }
		)),
}
