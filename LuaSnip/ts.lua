return {
	S(
		";tf",
		Fmt([[
		function toFunctional<T extends Function>(func: T): Function {{
		    const fullArgCount = func.length;
		    function createSubFunction(curriedArgs: unknown[]) {{
			return function(this: unknown) {{
			    const newCurriedArguments = curriedArgs.concat(Array.from(arguments));
			    if (newCurriedArguments.length > fullArgCount) {{
				throw new Error('Too many arguments');
			    }}
			    if (newCurriedArguments.length === fullArgCount) {{
				return func.apply(this, newCurriedArguments);
			    }}
			    return createSubFunction(newCurriedArguments);
			}};
		    }}
		    return createSubFunction([]);
		}}]],
		{}
		)
	)
}
