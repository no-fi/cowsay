module.exports =
  activate: ->
    atom.workspaceView.command "cowsay:cowsay", => @cowsay()

  cowsay: ->
    editor = atom.workspace.getActivePaneItem()
    selection = editor.getLastSelection()
    if selection.getText()
      cow = require 'cowsay'
      cowsaid = cow.say({text: selection.getText()})
      selection.insertText("\n#{cowsaid}\n")
