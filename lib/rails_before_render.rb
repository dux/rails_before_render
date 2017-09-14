module RailsBeforeRender
  @@before_render ||= {}

  def self.included base
    def base.before_render &block
      klass = self.to_s
      @@before_render[klass] ||= []
      @@before_render[klass].push block
    end
  end

  ###

  def render *args
    return performed? ? nil : super(*args) if @_was_in_render

    @_was_in_render = true

    self.class.ancestors.each do |klass|
      filters = @@before_render[klass.to_s] || next
      filters.each do |filter|
        # do not run if render or redirect is called
        instance_exec &filter unless performed?
      end
    end

    # call native render unless redirect or render or redirect happend
    super unless performed?
  end
end

ActionController::Base.send :include, RailsBeforeRender