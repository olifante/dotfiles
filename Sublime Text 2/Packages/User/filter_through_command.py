#!/usr/bin/env python
# -*- coding: utf-8 -*-

## based on http://pastie.org/private/bclbdgxzbkb1gs2jfqzehg

import sublime
import sublime_plugin
import subprocess

class PromptRunExternalCommand(sublime_plugin.WindowCommand):
    """
    To create a ⌥⌘R or ctrl-alt-R shortcut to "Filter through command" that
    prompts for a command, insert this somewhere in your keymap file:

    {
        "keys": ["alt+super+r"],
        "command": "prompt_run_external"
    }
    """
    def run(self):
        self.window.show_input_panel("Filter through command:", "", self.on_done, None, None)
        pass

    def on_done(self, text):
        try:
            if self.window.active_view():
                self.window.active_view().run_command("run_external", {"command": text} )
        except ValueError, e:
            sublime.status_message(e)

class RunExternalCommand(sublime_plugin.TextCommand):
    """
    Runs an external command with the selected text, which will then be
    replaced by the command output.

    For example, to sort the selected text with the Unix "sort" command,
    open the console (cmd-` or ctrl-`), input the following and press enter:

    view.run_command('run_external', dict(command="sort"))

    You could add filter shortcuts for specific commands by inserting
    something similar to the following in your user's keymap file:

    {
        "keys": ["alt+super+s"],
        "command": "run_external",
        "args": {"command": "sort -u"}
    }

    This creates a ⌥⌘S or ctrl-alt-S shortcut that lets you sort
    your file with the Unix "sort -u" command
    """

    def run(self, edit, command):
        if self.view.sel()[0].empty():
            ## if nothing selected, process the entire file:
            region = sublime.Region(0L, self.view.size())
        else:
            ## process only selected region:
            region = self.view.line(self.view.sel()[0])

        p = subprocess.Popen(
            command,
            shell   = True,
            bufsize = -1,
            stdout  = subprocess.PIPE,
            stderr  = subprocess.PIPE,
            stdin   = subprocess.PIPE)

        output, error = p.communicate(self.view.substr(region).encode('utf-8'))

        if error:
            # sublime.error_message(error.decode('utf-8'))
            ## I prefer seeing the error message in the status bar
            ## instead of inside a popup window.
            sublime.status_message(error.decode('utf-8'))
        else:
            self.view.replace(edit, region, output.decode('utf-8'))
            ## Comment the above and uncomment the following line
            ## if you want to insert the output at the start of the file:
            # self.view.insert(edit, 0, output.decode('utf-8'))
