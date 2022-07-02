# Ultisnips module
# A lot of code taken from 'https://github.com/honza/vim-snippets'

import string, vim, re

# Notes:
# If you want to write a snippets that calls another snippet insert
# `post_jump "expand_existing(snip)"`
# above it
# and insert the call for the other snippet

def _parse_comments(s):
	""" Parses vim's comments option to extract comment format """
	i = iter(s.split(","))

	rv = []
	try:
		while True:
			# get the flags and text of a comment part
			flags, text = next(i).split(':', 1)

			if len(flags) == 0:
				rv.append(('OTHER', text, text, text, ""))
			# parse 3-part comment, but ignore those with O flag
			elif 's' in flags and 'O' not in flags:
				ctriple = ["TRIPLE"]
				indent = ""

				if flags[-1] in string.digits:
					indent = " " * int(flags[-1])
				ctriple.append(text)

				flags, text = next(i).split(':', 1)
				assert flags[0] == 'm'
				ctriple.append(text)

				flags, text = next(i).split(':', 1)
				assert flags[0] == 'e'
				ctriple.append(text)
				ctriple.append(indent)

				rv.append(ctriple)
			elif 'b' in flags:
				if len(text) == 1:
					rv.insert(0, ("SINGLE_CHAR", text, text, text, ""))
	except StopIteration:
		return rv

def get_comment_format():
	""" Returns a 4-element tuple (first_line, middle_lines, end_line, indent)
	representing the comment format for the current file.
	It first looks at the 'commentstring', if that ends with %s, it uses that.
	Otherwise it parses '&comments' and prefers single character comment
	markers if there are any.
	"""
	commentstring = vim.eval("&commentstring")
	if commentstring.endswith("%s"):
		c = commentstring[:-2]
		return (c.rstrip(), c.rstrip(), c.rstrip(), "")
	comments = _parse_comments(vim.eval("&comments"))
	for c in comments:
		if c[0] == "SINGLE_CHAR":
			return c[1:]
	return comments[0][1:]

def expand_existing(snip):
	vim.eval('feedkeys("<C-R>=UltiSnips#ExpandSnippet()<CR>")')

# function to expand placeholders
# called by putting:
# `post_jump "expand_placeholders(snip)"`
# above the wanted snippet
# the snippet must return the next values in a list
# arg1 = the amount of place holders
# arg2 = list of the placeholder lines where: ({
# '$%'  will be '$<number>' (will be counted as a place holder)
# '$%{' will be '${:<number>' (will be counted as a place holder)
# '$%@' will be '<number>'
# })
def expand_placeholders(snip):
	# retrieving single line from current string and treat it like tabstops
	# count
	rv_list = eval(snip.buffer[snip.line].strip()[snip.snippet_start[1]:snip.snippet_end[1]])
	placeholders_count = int(rv_list[0])
	placeholder_list = rv_list[1]

	trigger_length = len(snip.buffer[snip.line].strip()[snip.snippet_start[1]:snip.snippet_end[1]])

	if trigger_length <= 0 :
		# erase current line
		snip.buffer[snip.line] = ''
		snip.cursor.set(snip.line, 0)
	else :
		snip.buffer[snip.line] = snip.buffer[snip.line][0: (-1 * trigger_length)]
		snip.cursor.set(snip.line, snip.column - trigger_length)


	# create anonymous snippet with expected content and number of tabstops
	snippet_body = ''

	current_placeholder_index = 1

	for _ in range(1, placeholders_count + 1):
		for line in placeholder_list:
			tmp_string = str(line)
			for _ in range(tmp_string.count("$%{")):
				tmp_string = tmp_string.replace('$%{', '${' + str(current_placeholder_index) + ':', 1)
				current_placeholder_index += 1
			for _ in range(tmp_string.count("$@")):
				tmp_string = tmp_string.replace('$%@', str(current_placeholder_index))
			for _ in range(tmp_string.count("$%")):
				tmp_string = tmp_string.replace('$%', '$' + str(current_placeholder_index))
				current_placeholder_index += 1
			snippet_body += tmp_string + '\n'

	# expand anonymous snippet
	snip.expand_anon(snippet_body)

def make_box(twidth, bwidth=None):
	b, m, e, i = (s.strip() for s in get_comment_format())
	m0 = m[0] if m else ''
	bwidth_inner = bwidth - 3 - max(len(b), len(i + e)) if bwidth else twidth + 2
	sline = b + m + bwidth_inner * m0 + 2 * m0
	nspaces = (bwidth_inner - twidth) // 2
	mlines = i + m + " " + " " * nspaces
	mlinee = " " + " "*(bwidth_inner - twidth - nspaces) + m
	eline = i + m + bwidth_inner * m0 + 2 * m0 + e
	return sline, mlines, mlinee, eline
