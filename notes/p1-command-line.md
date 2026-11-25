# P1.2 - Command Line Essentials (PowerShell & cmd)

Notes from practicing basic command line usage in PowerShell and cmd.

---

## Commands Practiced

- `pwd` (PowerShell) / `cd` (cmd): Shows the current folder path.
- `dir` / `ls`: Lists files and folders in the current directory.
- `cd <folder>`: Changes into a directory (`cd ..` to go up one folder).
- `mkdir <folder>`: Creates a new folder.
- `copy <file> <destination>`: Copies a file to another location or name.
- `move <file> <destination>`: Moves or renames a file.
- `del <file>` (or `rm`): Deletes a file.
- `type <file>` (or `cat` in PowerShell): Displays the contents of a file in the terminal.

---

## Environment Variables and PATH

Setting and checking environment variables:

In PowerShell:
```
$env:GREETING = "hello"
echo $env:GREETING
```

In cmd:
```
set GREETING=hello
echo %GREETING%
```

### What PATH does
`PATH` is a list of folder locations that Windows searches when you run a command without providing its full path. If an executable isn't in one of those folders or in the current directory, Windows doesn't recognize it.

---

## Programs, Flags, and Signals

- Ran programs with flags: `python --version` to see the Python version, and `git --help` for Git commands.
- `Ctrl + C`: Stops whatever command or server is currently running in the terminal.

---

## Redirecting Output to a File

Command:
```
dir > files.txt 2>&1
```

- `>` redirects standard output to `files.txt`.
- `2>&1` sends errors (stderr) to the same place as normal output (stdout).
This puts both results and errors into `files.txt`.

---

## Running Two Terminals Side by Side

Having two terminal windows open at the same time is useful for performance testing:
- Terminal 1: Runs the backend server or application so you can see live logs and errors.
- Terminal 2: Runs the test tool (like JMeter or curl scripts) generating traffic against the app.

---

## Self-Check

**Question**: You type `jmeter` and get 'not recognized'. What two things do you check?

1. Check if JMeter is actually installed and where its folder is located (looking for `jmeter.bat` inside the `bin` directory).
2. Check if that `bin` folder is added to the system `PATH` variable, and make sure the terminal was restarted after editing PATH.
