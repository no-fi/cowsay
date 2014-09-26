{WorkspaceView} = require 'atom'
Cowsay = require '../lib/cowsay'
temp = require 'temp'
path = require 'path'

describe "Cowsay", ->
  activationPromise = null
  [editor, buffer] = []

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    atom.workspace = atom.workspaceView.model
    activationPromise = atom.packages.activatePackage('cowsay')
    directory = temp.mkdirSync()
    atom.project.setPath(directory)
    filePath = path.join(directory, 'atom-cowsay.txt')
    waitsForPromise ->
      atom.workspace.open(filePath).then (o) -> editor = o

  describe "when the cowsay:cowsay event is triggered", ->
    it "keeps what is selected", ->
      editor.insertText('Holy Cow!')
      editor.selectAll()

      atom.workspaceView.trigger 'cowsay:cowsay'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(editor.getText()).toContain("Holy Cow!")

    it "prints something else", ->
      editor.insertText('Holy Cow!')
      editor.selectAll()

      atom.workspaceView.trigger 'cowsay:cowsay'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(editor.getText()).not.toEqual("Holy Cow!")
