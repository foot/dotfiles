import os, re, datetime, time

try:
    import vim
except ImportError, e:
    class vim:
        @staticmethod
        def command(cmd):
            print cmd

NOW = datetime.datetime.now()

def timedelta_to_i(td):
    return (td.days * 24 * 60 * 60) + td.seconds

def datetime_to_s(dt):
    return str(int(time.mktime(dt.timetuple())))

def line_to_anno(line):
    not_committed = re.match("^00000000.*", line)
    match = re.match("^(\w+)\s+\((\s*.+)\s+(\d{4}.*\+\d{4})\s+(\d+)\)(.*)", line)

    if not_committed:
        return { 'date': NOW }
    elif match:
        r, author, datestr, n, line = map(lambda s: s.strip(), match.groups())
        datebits = re.split("[+:\-\s]", datestr)
        date = datetime.datetime(*[int(bit) for bit in datebits if bit])
        return {
            'rev': r,
            'author': author,
            'date': date,
            'lineno': n,
            'line': line,
        }

def annotate(filename):
    out = os.popen("git annotate %s" % (filename))
    return map(line_to_anno, list(out))

def main(filename):
    annos = annotate(filename)
    dates = set(a['date'] for a in annos)

    t0 = min(dates)
    time_range = timedelta_to_i(max(dates) - t0) or 1 # if every line same age

    gradient = 255.0 / time_range
    def f(t):
        return gradient * timedelta_to_i(t - t0)

    # create hi groups
    for t in dates:
        color = "#%02x0000" % f(t)
        cmd = "hi git_age_%s guibg=%s" % (datetime_to_s(t), color)
        vim.command(cmd)

    # set syn
    for i, t in enumerate(a['date'] for a in annos):
        cmd = "syn match git_age_%s '\\%%%dl.*'" % (datetime_to_s(t), i+1)
        vim.command(cmd)

if __name__ == '__main__':
    try:
        import vim
        main(vim.current.buffer.name)
    except ImportError, e:
        import sys
        main(sys.argv[-1])

