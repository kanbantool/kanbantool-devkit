#= require_tree ./templates
#= require_tree ./locales
#= require_self
#= require_tree ./views

class KT.Extensions.DevkitExample
  @powerup: true
  @mobile: false

  # Activate is the entry method to all extensions which is called by the KT.extensionManager upon SDK initialization.
  activate: ->
    @_taskContextMenuExample()
    @_popoverExample()
    # @_externalDependencyExample()

    @ # if possible, return this from otherwise void methods, to allow method chaining.

  ###
  # An example of popover, allowing you to perform mass-update on selected tasks.
  ###
  _popoverExample: =>
    @popover = new KT.Extensions.DevkitExample.Popover()

    self = @

    # Register the 'rename tasks' option in tasks' context menu.
    # Upon click, it will open the popover.
    KT.Elements.Task.contextMenu.insertAfter 'elements.task.menu.duplicate',
      name: 'extensions.devkit_example.context_menu.rename_tasks' # you can either pass a string to display, or a key for I18n lookup.
      permissions: 'update_tasks'
      filter: (el, task, selection) ->
        # Ensure that at least one task is selected, and that the Power-Up is enabled, for this option to be visible.
        return selection.length > 0 and KT.extensionsManager.powerupSettings('DevkitExample', task.board()).enabled
      action: (args...) ->
        self.popover.open(@originalEvent, args...) # open the popover when this option is choosen


  ###
  # An example of how task context menu entries can be added.
  ###
  _taskContextMenuExample: =>
    KT.Elements.Task.contextMenu.insertAfter 'elements.task.menu.duplicate',
      name: 'extensions.devkit_example.context_menu.rename_to_hello_world' # you can either pass a string to display, or a key for I18n lookup.
      permissions: 'update_tasks'
      filter: (view, task, selection) ->
        KT.extensionsManager.powerupSettings('DevkitExample', task.board()).enabled and
          _.any(selection.tasks(), (t) -> !_.isEmpty(task.get('name')))
      action: (view, task, selection) -> selection.groupUpdate(name:'Hello world!')

  ###
  # When external dependencies need to be loaded, KT.require function can be used to load them.
  #
  # Simply pass the URLs to load as arguments, and in return you will get deferred object which resolves once external JS is loaded.
  # KT.require may be safely invoked multiple times, and will load each URL only once.
  ###
  _externalDependencyExample: (args...) =>
    KT.require('https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.css', 'https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.js').then =>
      alert("FullCalendar loaded -" + $.fullCalendar.version)

# All extensions need to be registered in KT.extensionsManager to work
KT.extensionsManager.registerExtension( 'DevkitExample', KT.Extensions.DevkitExample )
