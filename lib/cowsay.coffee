require 'atom'

module.exports = Cowsay =
  subscriptions: null

  activate: (state) ->
    atom.commands.add 'atom-workspace', 'cowsay:cowsay': => @cowsay()

  cowsay: ->
    editor = atom.workspace.getActivePaneItem()
    selection = editor.getLastSelection()
    if selection.getText()
      cow = require 'cowsay'
      cowsaid = cow.say({text: selection.getText()})
      selection.insertText("\n#{cowsaid}\n", {select: true})
