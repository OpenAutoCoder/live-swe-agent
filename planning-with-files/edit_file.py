#!/usr/bin/env python3
"""
A tool to edit files by line number ranges or pattern matching.
Usage:
  python edit_file.py <file> replace <start_line> <end_line> <new_content>
  python edit_file.py <file> insert <after_line> <new_content>
  python edit_file.py <file> append <new_content>
  python edit_file.py <file> delete <start_line> <end_line>
  python edit_file.py <file> show <start_line> <end_line>
"""
import sys
import os

def read_file(filepath):
    with open(filepath, 'r') as f:
        return f.readlines()

def write_file(filepath, lines):
    with open(filepath, 'w') as f:
        f.writelines(lines)

def main():
    if len(sys.argv) < 3:
        print(__doc__)
        sys.exit(1)
    
    filepath = sys.argv[1]
    action = sys.argv[2]
    
    if action == "show":
        lines = read_file(filepath)
        start = int(sys.argv[3]) - 1 if len(sys.argv) > 3 else 0
        end = int(sys.argv[4]) if len(sys.argv) > 4 else len(lines)
        for i, line in enumerate(lines[start:end], start=start+1):
            print(f"{i:4d}: {line}", end='')
        return
    
    if action == "replace":
        start = int(sys.argv[3]) - 1
        end = int(sys.argv[4])
        new_content = sys.argv[5] if len(sys.argv) > 5 else sys.stdin.read()
        lines = read_file(filepath)
        new_lines = new_content.split('\n')
        if not new_content.endswith('\n'):
            new_lines = [l + '\n' for l in new_lines[:-1]] + [new_lines[-1] + '\n'] if new_lines[-1] else [l + '\n' for l in new_lines[:-1]]
        else:
            new_lines = [l + '\n' for l in new_lines[:-1]]
        lines = lines[:start] + new_lines + lines[end:]
        write_file(filepath, lines)
        print(f"Replaced lines {start+1}-{end} with {len(new_lines)} lines")
        return
    
    if action == "insert":
        after_line = int(sys.argv[3])
        new_content = sys.argv[4] if len(sys.argv) > 4 else sys.stdin.read()
        lines = read_file(filepath)
        new_lines = new_content.split('\n')
        new_lines = [l + '\n' for l in new_lines if l or new_lines.index(l) < len(new_lines)-1]
        lines = lines[:after_line] + new_lines + lines[after_line:]
        write_file(filepath, lines)
        print(f"Inserted {len(new_lines)} lines after line {after_line}")
        return
    
    if action == "append":
        new_content = sys.argv[3] if len(sys.argv) > 3 else sys.stdin.read()
        with open(filepath, 'a') as f:
            f.write(new_content)
        print(f"Appended content to {filepath}")
        return
    
    if action == "delete":
        start = int(sys.argv[3]) - 1
        end = int(sys.argv[4])
        lines = read_file(filepath)
        lines = lines[:start] + lines[end:]
        write_file(filepath, lines)
        print(f"Deleted lines {start+1}-{end}")
        return

if __name__ == "__main__":
    main()
