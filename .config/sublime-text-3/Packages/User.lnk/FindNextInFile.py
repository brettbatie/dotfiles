import sublime, sublime_plugin

class FindNextInFileCommand(sublime_plugin.WindowCommand):
    def run(self):
        self.window.run_command("next_result")
        self.window.run_command("find_next")
class FindPrevInFileCommand(sublime_plugin.WindowCommand):
    def run(self):
        self.window.run_command("prev_result")
        self.window.run_command("find_prev")