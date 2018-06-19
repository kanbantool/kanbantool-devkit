class KT.Extensions.DevkitExample.Popover extends KT.Elements.Popover
  id: 'kt-extensions-devkit_example-popover'

  initialize: =>
    super
    @setContent(JST['kt/extensions/devkit_example/templates/popover'])

    @$el.on 'submit', 'form', (e) =>
      e.preventDefault()

      data = KT.serializeForm(e.currentTarget)

      @_selection.groupUpdate(data).then (e) =>
        KT.Elements.Task.getSelection().clear()
        @close()

  open: (event, view, task, selection) =>
    @_selection = selection # memoize selection
    name = _.string.truncate(task?.get('name') || '', 16)
    @setTitle(KT.I18n.t('extensions.devkit_example.popover.title_count', count:selection.length, 'name':name))
    super
