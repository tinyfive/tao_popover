#= require ./component

class TaoPopover.Trigger extends TaoComponent

  @tag: 'tao-popover-trigger'

  @property 'triggerAction', observe: true, default: 'click'

  @property 'triggerSelector', observe: true, default: 'a, button'

  @get 'popover', ->
    return @_popover if @_popover?

    @_popover = $(@).children('tao-popover').get(0)
    @_popover.active = false
    @_popover.autoHide = @triggerAction == 'click'

    unless @_popover.targetSelector
      @_popover.targetSelector = '*'
      @_popover.targetTraversal = 'prev'
    @_popover

  _connect: ->
    @_bindTriggerEvent()

  _bindTriggerEvent: ->
    @off '.tao-popover-trigger'

    if @triggerAction == 'click'
      @on 'click.tao-popover-trigger', "> #{@triggerSelector}", (e) =>
        @popover.toggleActive()
        false
    else if @triggerAction == 'hover'
      @on 'mouseenter.tao-popover-trigger', "> #{@triggerSelector}", (e) =>
        @popover.active = true
      .on 'mouseleave.tao-popover-trigger', "> #{@triggerSelector}", (e) =>
        @popover.active = false

  _triggerActionChanged: ->
    @_popover = null
    @_bindTriggerEvent()

  _triggerSelectorChanged: ->
    @_bindTriggerEvent()

  _disconnect: ->
    @off '.tao-popover-trigger'

TaoComponent.register TaoPopover.Trigger