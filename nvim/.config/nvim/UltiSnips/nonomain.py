# Ultisnips module

import vim

# Notes:
# If you want to write a snippets that calls another snippet insert
# `post_jump "expand_existing(snip)"`
# above it
# and insert the call for the other snippet

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
